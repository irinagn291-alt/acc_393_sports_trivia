from pathlib import Path
import zipfile,json,hashlib,plistlib
r=Path(__file__).resolve().parents[1]
out=r/'Deliverables';out.mkdir(exist_ok=True)
items=[]
for directory in ['SportsTrivia','TriviaGlance','SportsTrivia.xcodeproj','Verification','Metadata']:
 items += [p for p in (r/directory).rglob('*') if p.is_file() and not any(x in p.parts for x in ['__pycache__','xcuserdata']) and p.name!='.DS_Store']
items += [r/name for name in ['REPORT.txt','SETUP.txt','CONTENT_SOURCES.txt']]
for p in items:
 assert str(Path.home()).encode() not in p.read_bytes(),p.relative_to(r)
with zipfile.ZipFile(out/'SportsTrivia-source.zip','w',zipfile.ZIP_DEFLATED) as z:
 for p in items:z.write(p,str(p.relative_to(r)))
archive=out/'SportsTrivia.xcarchive'
leaks=[]
for p in archive.rglob('*'):
 if p.is_file() and str(Path.home()).encode() in p.read_bytes():leaks.append(str(p.relative_to(archive)))
summary={'source_zip_files':len(items),'source_zip_sha256':hashlib.sha256((out/'SportsTrivia-source.zip').read_bytes()).hexdigest(),'archive_home_path_leaks':leaks}
(r/'Evidence/package-audit.json').write_text(json.dumps(summary,indent=2));print(json.dumps(summary,indent=2));assert not leaks
