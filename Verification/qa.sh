#!/bin/bash
set -uo pipefail
TASK_DIR="$(cd "$(dirname "$0")/.." && pwd)"
cd "$TASK_DIR"
export DEVELOPER_DIR=/Applications/Xcode.app/Contents/Developer
: "${GF_SIMULATOR_UDID:?Run this script with simulator_pool.py}"
xcrun simctl boot "$GF_SIMULATOR_UDID" 2>/dev/null || true
xcrun simctl bootstatus "$GF_SIMULATOR_UDID" -b
QA_BASE="${QA_LABEL:-phone}"
QA_STATUS=1
for QA_TRY in 0 1; do
  QA_RUN="$QA_BASE"
  if [ "$QA_TRY" -gt 0 ]; then QA_RUN="$QA_BASE-retry$QA_TRY"; fi
  xcodebuild -project SportsTrivia.xcodeproj -scheme FieldArena -configuration Debug -destination "id=$GF_SIMULATOR_UDID" -parallel-testing-enabled NO -derivedDataPath Build -resultBundlePath "Evidence/$QA_RUN.xcresult" CODE_SIGNING_ALLOWED=YES CODE_SIGN_IDENTITY=- ONLY_ACTIVE_ARCH=YES ARCHS=arm64 test > "Evidence/$QA_RUN-tests.log" 2>&1
  QA_STATUS=$?
  xcrun xcresulttool export attachments --path "Evidence/$QA_RUN.xcresult" --output-path "Evidence/$QA_RUN-attachments" > "Evidence/$QA_RUN-export.log" 2>&1 || true
  xcrun simctl io "$GF_SIMULATOR_UDID" screenshot "Evidence/$QA_RUN-final.png" || true
  QA_CONTAINER="$(xcrun simctl get_app_container "$GF_SIMULATOR_UDID" org.cobaltfield.triviaq82 data 2>/dev/null)"
  if [ -n "$QA_CONTAINER" ]; then cp "$QA_CONTAINER/Library/Application Support/q82-ledger.json" "Evidence/$QA_RUN-ledger.json" 2>/dev/null || true; fi
  QA_GROUP="$(xcrun simctl get_app_container "$GF_SIMULATOR_UDID" org.cobaltfield.triviaq82 group.org.cobaltfield.triviaq82 2>"Evidence/$QA_RUN-group.log")"
  if [ -n "$QA_GROUP" ]; then cp "$QA_GROUP/Library/Preferences/group.org.cobaltfield.triviaq82.plist" "Evidence/$QA_RUN-shared-preferences.plist" 2>/dev/null || true; fi
  if [ "$QA_STATUS" -eq 0 ] || [ "$QA_TRY" -gt 0 ]; then break; fi
  touch "Evidence/$QA_BASE-needs-fix"
  QA_RETRY=0
  for QA_TICK in $(seq 1 72); do
    if [ -f "Evidence/$QA_BASE.retry" ]; then rm "Evidence/$QA_BASE.retry"; QA_RETRY=1; break; fi
    sleep 5
  done
  if [ "$QA_RETRY" -eq 0 ]; then break; fi
  xcrun simctl uninstall "$GF_SIMULATOR_UDID" org.cobaltfield.triviaq82 || true
  rm -f "Evidence/$QA_BASE-needs-fix"
done
exit "$QA_STATUS"
