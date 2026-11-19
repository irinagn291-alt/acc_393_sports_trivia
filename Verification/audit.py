from pathlib import Path
import re,json,plistlib,os
r=Path(__file__).resolve().parents[1]
book=json.loads((r/'SportsTrivia/Resources/Fieldbook.json').read_text())
langs=['en','de','pt-BR','fr','es','it','ru']
assert len(book)==36 and len({q['id'] for q in book})==36
for q in book:
 assert set(q['q'])==set(langs) and set(q['o'])==set(langs)
 assert q['a'] in range(4)
 for lang in langs:assert len(q['o'][lang])==4 and len(set(q['o'][lang]))==4
for c in range(3):assert len([q for q in book if q['c']==c])>=10
refs=set(re.findall(r'v3\("([a-z_]+)"\)', '\n'.join(p.read_text() for folder in ['SportsTrivia','TriviaGlance','Verification'] for p in (r/folder).rglob('*.swift'))))
keys=[]
for lang in langs:
 text=(r/f'SportsTrivia/Resources/{lang}.lproj/Localizable.strings').read_text()
 k=set(re.findall(r'^"([^"]+)" = ',text,re.M));keys.append(k)
 assert not refs-k,(lang,refs-k)
 assert '\ufffd' not in text
assert all(k==keys[0] for k in keys)
project=(r/'SportsTrivia.xcodeproj/project.pbxproj').read_text()
assert str(Path.home()) not in project and Path.home().name not in project
ids=set(re.findall(r'\b[A-F0-9]{24}\b',project))
collisions=[]
root=r.parents[2]
paths=[]
for folder,dirs,files in os.walk(root):
 dirs[:]=[d for d in dirs if d not in ['Build','DerivedData','Evidence','QA','.git','node_modules','.build','Artifacts','build','.artifacts','ReleaseBuild','HostModuleCache','CheckModuleCache','Deliverables']]
 if 'project.pbxproj' in files:paths.append(Path(folder)/'project.pbxproj')
for other in paths:
 if other==r/'SportsTrivia.xcodeproj/project.pbxproj' or 'Build' in other.parts:continue
 other_text=other.read_text(errors='ignore')
 assert 'org.cobaltfield.triviaq82' not in other_text,other
 found=ids.intersection(re.findall(r'\b[A-F0-9]{24}\b',other_text))
 if found:collisions.append((str(other),list(found)))
assert not collisions,collisions
info=plistlib.loads((r/'SportsTrivia/Info.plist').read_bytes());assert set(info['UIBackgroundModes'])=={'fetch','remote-notification'}
sources=[str(p.relative_to(r)) for folder in ['SportsTrivia','TriviaGlance','Verification'] for p in (r/folder).rglob('*.swift')]
assert len(sources)==6,sources
result={'questions':len(book),'localized_strings':len(keys[0]),'languages':langs,'unique_project_objects':len(ids),'uuid_collisions':0,'swift_files':sources,'source_path_scan':'pass'}
(r/'Evidence/static-audit.json').write_text(json.dumps(result,indent=2));print(json.dumps(result,indent=2))
