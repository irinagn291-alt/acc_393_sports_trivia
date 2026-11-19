<!-- gf-brief source=fc2066b7e4e6df672dfda36c5555dabaa1aac25655dfe3d0598dd2967a021df0 written=2026-11-19T19:33:36+03:00 -->
# Sports Trivia

## What it is

Sports Trivia is a multiple-choice quiz game for sports fans who want to test their knowledge of leagues, rules, sporting history, and athletes. Players can take timed solo rounds, build a daily streak, unlock seasonal chapters, or share a challenge code so a friend can answer the same ten questions.

## Launch and onboarding

1. On a fresh install, the app opens directly to “Play” in a dark interface. There is no welcome sequence, sign-in, or permission prompt.
2. The top of the screen shows “THE SPORTING MIND” and “Sports Trivia”. The main card reads “YOUR DAILY CHALLENGE”, followed by “Think fast.” and “Know your sport.” on separate lines, “Start a round”, and “10 questions”.
3. “Daily streak”, “Weekly points”, and “Rounds played” all start at zero. Below them are “Find your field”, “OFFLINE READY”, the category buttons, “Question of the day”, and “Season challenge”. The four tabs are “Play”, “Duels”, “Ranking”, and “More”.
4. Tap “Start a round” to open the first timed question in a mixed round. For the one-question daily challenge, tap the separate “Question of the day” card. On a later cold launch, a saved round normally opens automatically. The home card reads “Resume round” while that round is saved.

The labels below are quoted as displayed in English.

## Screens

### “Play” — “Sports Trivia”

- The main card’s “Start a round” action draws ten questions from across the bundled categories. “Resume round” reopens the saved round at its current question, answer feedback, or results. The card still displays “10 questions” when resuming the one-question daily challenge.
- “Daily streak”, “Weekly points”, and “Rounds played” are counters. “Rounds played” includes completed daily questions and other completed rounds.
- “Discard saved round” appears when a round is saved. It opens “Discard this unfinished round?” with “Discard saved round” to clear the saved round and “Cancel” to keep it.
- Under “Find your field”, beside “OFFLINE READY”, “Leagues & rules”, “Sporting history”, and “The athletes” each start a round in that category. Each button says “10 questions · 20 seconds each”.
- “Question of the day” starts one question from the bundled library. Its subtitle is “One question. Keep your streak alive.” After completion, the subtitle changes to “Completed today. See you tomorrow.”
- “Season challenge” says “Four chapters each quarter. Score 600 to open the next.” The rows are “Chapter 1”, “Chapter 2”, “Chapter 3”, and “Chapter 4”. “Play” starts an available chapter. After a chapter is completed, its button reads “Replay” and its best score appears out of 1000. Replaying uses the same chapter questions for that quarter.

### “Duels” — “A friendly rivalry”

- “Challenge code” is an editable field prefilled with a generated code. Keep that code to start a new shared challenge, or replace it with one from a friend.
- “Share challenge” opens the iOS share sheet with the code as text. “Play this challenge” starts the ten-question round generated from that code. Players enter the same code on their own devices to get the same questions, then compare results by exchanging scorecards. Answer order can vary. The challenge appears as “All sports” in “Recent rounds”.
- “Scorecards” provides the same comparison and sharing controls as on “Ranking”. Sharing a challenge sends the code. Sharing a scorecard is a separate action after play.

### “Ranking” — “This week’s form”

- “Weekly points” shows the sum of the best ten-question score for each day of the current local week, starting Monday. “Daily streak” counts consecutive days with a completed “Question of the day”. One-question daily results do not contribute to “Weekly points”.
- “Scorecards” appears here and on “Duels”. “This week (UTC)” starts on. Turn it off to see all-time signed scores. The “★” list shows up to ten ranked entries. Your entry reads “You”. Imported entries use short identifiers.
- “Share my scorecard” opens the iOS share sheet with a signed text scorecard for your best eligible ten-question result in the selected time range. When available, it is accompanied by “Score recalculated from ten answers.” Before there is a qualifying result, the app shows “Play a ten-question round to share its answers.”
- Paste a friend’s scorecard into “Paste a scorecard”, then tap “Add scorecard”. A valid card clears the field. Invalid, incompatible, or self-issued signed cards show “Invalid scorecard”. Accepted older cards appear in the expandable “Earlier cards · unverified” section. These cards sit outside the signed ranking.
- “Recent rounds” lists up to 25 newest results, with the mode, date, and score out of the round’s maximum. Mode labels include “All sports”, the three bundled category names, “Question of the day”, “Season challenge”, and “Open library”. Rows are display-only. On a fresh install, the section reads “Complete your first round to see your results.”

### “More”

| Section | Copy and controls |
|---|---|
| “Daily reminders” | “An optional reminder at 19:00 for the daily question, plus a Monday weekly reminder. Compare scores on this device and exchange scorecards directly.” Also shows “Daily reminders are planned for the next 14 days and renewed when you open the app. Today’s reminder is removed after you finish the daily question.” “Enable reminders” requests notification permission. “Open system settings” opens the app’s iOS settings. |
| “Question library” | “52 translated questions are bundled and always available offline. Optional Open Trivia DB questions use a separate English library.” “Optional background library updates” is off by default. Turning it on allows iOS to run library updates in the background. “Update open library” downloads more optional questions and shows a spinner while it works. “Play English library” starts a ten-question round from the downloaded questions and appears only in English. The section says “The optional library is English only. It is offered for play when the app language is English.” “Open Trivia DB · CC BY-SA 4.0” opens the question provider’s site. “Content license” opens the license. |
| “Playing comfortably” | “Each question allows 20 seconds. Leaving a round saves progress; its current timer keeps running. Correct answers earn 100 points, with no speed scoring.” Also shows “App language follows iOS. You can change it in system settings.” |
| “Privacy” | “Round history and streaks stay on this device. Widgets use your saved quiz progress. Solo play requires no account. There is no analytics, advertising or tracking.” Also shows “Compare scores on this device and exchange scorecards directly. Open Trivia DB receives a network request only when you choose to update.” A final line reads “Compare scores on this device and exchange scorecards directly.” |
| “About” | “Sports Trivia · 1.2.2 (12)” and “Free to play. No purchases or advertisements.” |

### Timed question

- The question screen displays a counter such as “Question 1 of 10” or “Question 1 of 1”, a progress bar, the question’s category, the question text, and four answer buttons marked “A”, “B”, “C”, and “D”. Each button also displays its answer text. The countdown has the accessibility label “Seconds left” followed by the remaining time.
- Before an answer, the hint reads “Choose one answer. There is no speed scoring.” Tapping an answer commits it immediately. A correct answer earns 100 points. An incorrect answer or timeout earns zero.
- Feedback reads “You know your sport!”, “A new fact to remember”, or “Time is up”. The correct choice is highlighted. An incorrect choice is outlined, and an incorrect answer or timeout also shows “Correct answer:” followed by the answer text.
- “Next question” starts the next 20-second timer. On the final question it becomes “See results”.
- “Close” opens “Save this round and leave?” with “Save and leave” to return to the originating tab and “Cancel” to stay in the round. The quiz is presented full-screen.

### “Round complete”

- Shows the points total and a count such as “7 correct out of 10”. “Your round, reviewed” lists each question with its correct answer and a mark showing whether the player got it right. “Reference” opens the source for that question.
- “Back to the field” clears the saved round and returns to the originating tab, including “Duels” or “More” when the round started there. “Close” instead offers “Save this round and leave?” so the result screen can be reopened.

### “Sports at a glance” widget

- The widget gallery description is “Your daily question, streak and weekly scores, from this device.”
- The small Home Screen widget shows “Sports Trivia”, “Question of the day”, a category label, “Daily streak”, and either “Open your daily question” or “Completed today. See you tomorrow.” Lock Screen versions show the daily status or a streak count, depending on size. The daily status reads “Your daily question is ready” or “Completed today. See you tomorrow.” These widgets open “Play” and start the daily question when it is available and there is no saved round.
- The medium and large Home Screen widgets show “Sports Trivia”, “This week’s quiz”, “Weekly points”, and “Daily streak”. The large widget also shows play counts for the three bundled categories and “Friends league”, with “Compare scores on this device and exchange scorecards directly.” Tapping either size opens “Ranking”.

## Features

- “Start a round” for mixed offline play and category rounds in “Leagues & rules”, “Sporting history”, and “The athletes”.
- “Question of the day” and “Daily streak”, including completed questions that time out or are answered incorrectly.
- “Season challenge” with four quarterly chapters, unlocks at 600 points, and “Replay” to improve a chapter score.
- Timed four-choice questions, 100 points per correct answer, immediate feedback, and “Your round, reviewed” with “Reference” links.
- “Save and leave”, “Resume round”, and “Discard saved round”.
- “Challenge code”, “Share challenge”, and “Play this challenge” for matching rounds on separate devices.
- “Scorecards” with signed score sharing, pasted scorecards, weekly and all-time comparisons, and an expandable list for accepted older cards.
- “Weekly points” and “Recent rounds”.
- “Question library” with offline bundled content and optional English downloads, manual updates, and opt-in background updates.
- “Daily reminders” and a Monday weekly reminder. Notifications read “Your daily question is ready” or “Your weekly ranking is ready”, both with “Open Sports Trivia to see your local progress.” The daily notification opens the daily question when available. The weekly notification opens “Ranking”.
- “Sports at a glance” Home Screen and Lock Screen widgets.

## Behaviours that can look like bugs

- **Only one round can be saved at a time.** A saved round disables the three category buttons, “Question of the day”, the chapter buttons, and “Play English library”. “Play this challenge” reopens the existing round when one is saved. Finish and tap “Back to the field”, or return to “Play” and confirm “Discard saved round” to start something else.
- **Leaving does not pause a live timer.** “Save and leave” keeps your place and the current question’s deadline. When you return after that deadline, expect “Time is up”. Once feedback is visible, it waits for “Next question” or “See results”. Answer buttons are disabled after any answer or timeout.
- **Completion is recorded on the final answer or timeout.** “See results” opens the recap. Closing or discarding a saved round after that point leaves the recorded result in history.
- **The daily card stays disabled after completion.** “Completed today. See you tomorrow.” applies once the daily question has been answered or timed out. The next question becomes available on the next local day.
- **Season chapters unlock in order.** If “Play” is disabled on a later chapter, use “Replay” on the preceding chapter and earn at least 600 points. A lower replay score leaves the best score intact. Each new calendar quarter has a new set of chapter unlocks and scores.
- **Challenge codes have a required format.** “Share challenge” and “Play this challenge” are disabled for an invalid code. Paste a shared code as received, such as “SportsTrivia-1234ABCD”. The prefix is case-sensitive and must be followed by eight hexadecimal characters. There is no waiting room or automatic turn handoff.
- **The two weekly views use different clocks and scores.** “Weekly points” starts over on a local Monday and adds each day’s best full round. “This week (UTC)” filters scorecards by the UTC week and shows a best score per player. Turn it off for all-time scores. A newly imported card can be missing from the weekly view if it was played outside the current UTC week.
- **Scorecards start empty and update locally.** “Add scorecard” is disabled until the field contains text. If “Invalid scorecard” appears, paste a complete valid card from another player. “Share my scorecard” appears after an eligible ten-question round using the bundled questions. Daily questions and downloaded English rounds do not qualify. The ranked list shows up to ten entries and keeps the best accepted score per sender for its time range. “Recent rounds” grows as rounds finish and displays the latest 25.
- **The optional library starts empty.** In English, tapping “Play English library” too early shows “Update the open library first. A full round needs 10 questions.” Use “Update open library” and retry once there are ten eligible questions. Downloads merge distinct questions into the optional library, up to 200. A successful update may add fewer than ten distinct playable questions. In other app languages, the play button is hidden. If an English library round was saved before changing languages, switch back to English to resume it, or discard it from “Play”.
- **Library updates can take time or require a retry.** “Update open library” is disabled while an update is running. A repeat attempt can show “Please wait a few seconds before updating again.” Success shows “Open library saved. Bundled questions are unchanged.” Failure shows “Could not update. Your offline library is ready to play.” These alerts are titled “Sports Trivia” and dismissed with “OK”.
- **Reminders require iOS permission.** “Enable reminders” reports “Reminders enabled.” or “Reminders are unavailable. You can enable notifications in system settings.” Use “Open system settings” if permission was denied. These alerts use “Sports Trivia” and “OK”. Completing today’s daily question removes today’s pending daily reminder.
- **A save can fail if device storage is unavailable.** The “Sports Trivia” alert says “Could not save. Check available device storage.” and has “OK”.

## Starter content and resume

The app ships with 52 translated questions for offline play. There are 20 in “Leagues & rules”, 18 in “Sporting history”, and 14 in “The athletes”. They cover topics such as football and basketball rules, league championships, Olympic and World Cup history, and notable athletes. The daily question, season chapters, and shared-code challenges are playable from the bundled questions on first launch. Round history, scorecards, and the optional English library start empty.

One round can be resumed, including its recorded answers, any visible feedback, and completed results that have yet to be cleared. The current unanswered question retains its original deadline. “Discard saved round” removes the saved round. Results already recorded in “Recent rounds” remain.

## Permissions

The app asks for iOS notification permission only when the player taps “Enable reminders” under “More” → “Daily reminders”. It requests alerts, sounds, and badges for the reminders. iOS supplies the prompt wording. The app has no custom usage-description string for this permission.

## Absent

Login or accounts, in-app purchases, ads, analytics, content creation or publishing by users, an account deletion flow, and an App Tracking Transparency prompt are absent. The editable challenge and scorecard fields accept game codes and results for direct exchange.

## Data and support

Round history, streaks, chapter scores, saved rounds, downloaded questions, and imported scorecards are kept on the device. The widget reads local progress. “Share challenge” and “Share my scorecard” hand the selected text to the iOS share sheet so the player can choose where to send it. “Update open library” requires an internet connection, and enabling “Optional background library updates” also permits update requests in the background. There is no on-screen “Contact” or “Support” control.

## Scanning and health

None.

## Platform

Supports iPhone and iPad on iOS or iPadOS 17.4 or later. iPhone supports portrait and both landscape orientations. iPad also supports upside-down portrait.

The display name is “Sports Trivia” in every supported language. The interface and bundled questions support English, German, Brazilian Portuguese, French, Spanish, Italian, and Russian, with English as the fallback. The app follows the iOS language setting, including a per-app language selection if set in iOS. “Play English library” is gated by language. Daily questions, reminders, seasonal chapters, and local “Weekly points” follow the device calendar or time zone. The scorecard filter “This week (UTC)” uses UTC. There is no country-specific gameplay restriction.

## Category

Games → Trivia
