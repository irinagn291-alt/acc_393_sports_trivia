from pathlib import Path
import uuid,plistlib,json,shutil
r=Path(__file__).resolve().parents[1]
base='org.cobaltfield.triviaq82'
def plist(path,d):
 (r/path).write_bytes(plistlib.dumps(d,sort_keys=False))
common={'CFBundleDevelopmentRegion':'en','CFBundleExecutable':'$(EXECUTABLE_NAME)','CFBundleIdentifier':'$(PRODUCT_BUNDLE_IDENTIFIER)','CFBundleName':'$(PRODUCT_NAME)','CFBundlePackageType':'APPL','CFBundleShortVersionString':'$(MARKETING_VERSION)','CFBundleVersion':'$(CURRENT_PROJECT_VERSION)'}
plist('SportsTrivia/Info.plist',dict(common,CFBundleDisplayName='Sports Trivia',LSRequiresIPhoneOS=True,UILaunchScreen={},UIBackgroundModes=['remote-notification','fetch'],BGTaskSchedulerPermittedIdentifiers=[base+'.refresh'],UISupportedInterfaceOrientations=['UIInterfaceOrientationPortrait','UIInterfaceOrientationLandscapeLeft','UIInterfaceOrientationLandscapeRight'],**{'UISupportedInterfaceOrientations~ipad':['UIInterfaceOrientationPortrait','UIInterfaceOrientationPortraitUpsideDown','UIInterfaceOrientationLandscapeLeft','UIInterfaceOrientationLandscapeRight']},CFBundleURLTypes=[{'CFBundleURLName':'FieldTriviaRoutes','CFBundleURLSchemes':['fieldtrivia']}],UIApplicationSupportsIndirectInputEvents=True,UIApplicationSceneManifest={'UIApplicationSupportsMultipleScenes':False,'UISceneConfigurations':{}},ITSAppUsesNonExemptEncryption=False,NSSupportsLiveActivities=False))
wc=dict(common);wc['CFBundlePackageType']='XPC!';wc['CFBundleDisplayName']='Sports Trivia';wc['NSExtension']={'NSExtensionPointIdentifier':'com.apple.widgetkit-extension'}
plist('TriviaGlance/Info.plist',wc)
plist('SportsTrivia/Field.entitlements',{'com.apple.security.application-groups':['group.'+base],'com.apple.developer.game-center':True,'aps-environment':'development'})
plist('TriviaGlance/Field.entitlements',{'com.apple.security.application-groups':['group.'+base]})
plist('SportsTrivia/Resources/PrivacyInfo.xcprivacy',{'NSPrivacyTracking':False,'NSPrivacyTrackingDomains':[],'NSPrivacyCollectedDataTypes':[],'NSPrivacyAccessedAPITypes':[{'NSPrivacyAccessedAPIType':'NSPrivacyAccessedAPICategoryUserDefaults','NSPrivacyAccessedAPITypeReasons':['1C8F.1']} ]})
asset=r/'SportsTrivia'/'Resources'/'FieldArt.xcassets';(asset/'AppIcon.appiconset').mkdir(parents=True,exist_ok=True)
(asset/'Contents.json').write_text(json.dumps({'info':{'version':1,'author':'xcode'}}))
import sys
source=Path(sys.argv[1]) if len(sys.argv)>1 else Path('unused-icon')
if source.exists():
 shutil.copy(source,asset/'AppIcon.appiconset'/'FieldIcon.png')
 import subprocess
 subprocess.run(['sips','-z','1024','1024',str(asset/'AppIcon.appiconset'/'FieldIcon.png')],check=True)
(asset/'AppIcon.appiconset'/'Contents.json').write_text(json.dumps({'images':[{'filename':'FieldIcon.png','idiom':'universal','platform':'ios','size':'1024x1024'}],'info':{'version':1,'author':'xcode'}}))
# Random object identities are intentionally independent of file names.
o={}
def add(isa,**kw):
 i=uuid.uuid4().hex[:24].upper();o[i]=dict(isa=isa,**kw);return i
def ref(path,typ):return add('PBXFileReference',lastKnownFileType=typ,path=path,sourceTree='<group>')
appFiles=[ref('SportsTrivia/Arena.swift','sourcecode.swift'),ref('SportsTrivia/Core/Rift.swift','sourcecode.swift'),ref('SportsTrivia/Core/Vault.swift','sourcecode.swift'),ref('SportsTrivia/Core/Relay.swift','sourcecode.swift')]
appFiles.extend(ref(str(p.relative_to(r)), 'sourcecode.swift') for p in sorted((r/'SportsTrivia/Website').glob('*.swift')))
widgetFile=ref('TriviaGlance/Glance4879eb.swift','sourcecode.swift');testFile=ref('Verification/Proof.swift','sourcecode.swift')
langs=['en','de','pt-BR','fr','es','it','ru']
locs=[add('PBXFileReference',lastKnownFileType='text.plist.strings',name=l,path=f'{l}.lproj/Localizable.strings',sourceTree='<group>') for l in langs]
local=add('PBXVariantGroup',children=locs,name='Localizable.strings',sourceTree='<group>')
data=ref('SportsTrivia/Resources/Fieldbook.json','text.json');art=ref('SportsTrivia/Resources/FieldArt.xcassets','folder.assetcatalog');info=ref('SportsTrivia/Resources/InfoPlist.xcstrings','text.json.xcstrings');privacy=ref('SportsTrivia/Resources/PrivacyInfo.xcprivacy','text.xml')
plistRefs=[ref(p,'text.plist.xml') for p in ['SportsTrivia/Info.plist','TriviaGlance/Info.plist','SportsTrivia/Field.entitlements','TriviaGlance/Field.entitlements']]
prod=[add('PBXFileReference',explicitFileType=t,includeInIndex=0,path=n,sourceTree='BUILT_PRODUCTS_DIR') for t,n in [('wrapper.application','SportsTrivia.app'),('wrapper.app-extension','TriviaGlance.appex'),('wrapper.cfbundle','FieldProof.xctest')]]
products=add('PBXGroup',children=prod,name='Products',sourceTree='<group>')
root=add('PBXGroup',children=appFiles+[widgetFile,testFile,local,data,art,info,privacy]+plistRefs+[products],sourceTree='<group>')
folders = {Path('.'): root}
def project_folder(directory):
    if directory not in folders:
        parent = project_folder(directory.parent)
        group = add('PBXGroup', path=directory.name, sourceTree='<group>', children=[])
        o[parent]['children'].append(group)
        folders[directory] = group
    return folders[directory]

for item in list(o[root]['children']):
    entry = o[item]
    if entry['isa'] == 'PBXFileReference':
        path = Path(entry['path'])
        entry['path'] = path.name
    elif item == local:
        path = Path('SportsTrivia/Resources/Localizable.strings')
    else:
        continue
    if path.parent != Path('.'):
        o[root]['children'].remove(item)
        o[project_folder(path.parent)]['children'].append(item)

def phase(isa,refs):return add(isa,buildActionMask=2147483647,files=[add('PBXBuildFile',fileRef=x) for x in refs],runOnlyForDeploymentPostprocessing=0)
def _configs(settings):return add('XCConfigurationList',buildConfigurations=[add('XCBuildConfiguration',buildSettings=dict(settings,**({'SWIFT_OPTIMIZATION_LEVEL':'-Onone','ENABLE_TESTABILITY':'YES','DEBUG_INFORMATION_FORMAT':'dwarf','SWIFT_ACTIVE_COMPILATION_CONDITIONS':'DEBUG'} if name=='Debug' else {'SWIFT_COMPILATION_MODE':'wholemodule','DEBUG_INFORMATION_FORMAT':'dwarf'})),name=name) for name in ['Debug','Release']],defaultConfigurationIsVisible=0,defaultConfigurationName='Release')
def configs(settings):
 result=_configs(settings)
 if settings.get('TEST_TARGET_NAME'):
  for c in o[result]['buildConfigurations']:o[c]['buildSettings']['SWIFT_ACTIVE_COMPILATION_CONDITIONS']='DEBUG WIDGET_PROOF' if o[c]['name']=='Debug' else 'WIDGET_PROOF'
 return result

prid=uuid.uuid4().hex[:24].upper()
settings={'SDKROOT':'iphoneos','IPHONEOS_DEPLOYMENT_TARGET':'17.4','SWIFT_VERSION':'5.0','SWIFT_SERIALIZE_DEBUGGING_OPTIONS':'NO','OTHER_SWIFT_FLAGS':['$(inherited)','-debug-prefix-map','$(SRCROOT)=.','-file-prefix-map','$(SRCROOT)=.'],'TARGETED_DEVICE_FAMILY':'1,2','MARKETING_VERSION':'1.2.2','CURRENT_PROJECT_VERSION':'12','CODE_SIGN_STYLE':'Automatic','CLANG_ENABLE_MODULES':'YES','ENABLE_USER_SCRIPT_SANDBOXING':'YES','SWIFT_EMIT_LOC_STRINGS':'NO','SUPPORTED_PLATFORMS':'iphoneos iphonesimulator'}
appset=dict(settings,PRODUCT_NAME='SportsTrivia',PRODUCT_BUNDLE_IDENTIFIER=base,INFOPLIST_FILE='SportsTrivia/Info.plist',CODE_SIGN_ENTITLEMENTS='SportsTrivia/Field.entitlements',ASSETCATALOG_COMPILER_APPICON_NAME='AppIcon',LD_RUNPATH_SEARCH_PATHS=['$(inherited)','@executable_path/Frameworks'])
wset=dict(settings,PRODUCT_NAME='TriviaGlance',PRODUCT_BUNDLE_IDENTIFIER=base+'.glance',INFOPLIST_FILE='TriviaGlance/Info.plist',CODE_SIGN_ENTITLEMENTS='TriviaGlance/Field.entitlements',APPLICATION_EXTENSION_API_ONLY='YES',SKIP_INSTALL='YES',LD_RUNPATH_SEARCH_PATHS=['$(inherited)','@executable_path/Frameworks','@executable_path/../../Frameworks'])
widget=add('PBXNativeTarget',buildConfigurationList=configs(wset),buildPhases=[phase('PBXSourcesBuildPhase',[appFiles[1],widgetFile]),phase('PBXResourcesBuildPhase',[local,info,privacy]),phase('PBXFrameworksBuildPhase',[])],buildRules=[],dependencies=[],name='TriviaGlance',productName='TriviaGlance',productReference=prod[1],productType='com.apple.product-type.app-extension')
proxy=add('PBXContainerItemProxy',containerPortal=prid,proxyType=1,remoteGlobalIDString=widget,remoteInfo='TriviaGlance');dep=add('PBXTargetDependency',target=widget,targetProxy=proxy)
embed=add('PBXCopyFilesBuildPhase',buildActionMask=2147483647,dstPath='',dstSubfolderSpec=13,files=[add('PBXBuildFile',fileRef=prod[1],settings={'ATTRIBUTES':['RemoveHeadersOnCopy']})],name='Embed Glance',runOnlyForDeploymentPostprocessing=0)
app=add('PBXNativeTarget',buildConfigurationList=configs(appset),buildPhases=[phase('PBXSourcesBuildPhase',appFiles),phase('PBXResourcesBuildPhase',[local,data,art,info,privacy]),phase('PBXFrameworksBuildPhase',[]),embed],buildRules=[],dependencies=[dep],name='FieldArena',productName='SportsTrivia',productReference=prod[0],productType='com.apple.product-type.application')
tset=dict(settings,PRODUCT_NAME='FieldProof',PRODUCT_BUNDLE_IDENTIFIER=base+'.proof',GENERATE_INFOPLIST_FILE='YES',TEST_TARGET_NAME='FieldArena')
tproxy=add('PBXContainerItemProxy',containerPortal=prid,proxyType=1,remoteGlobalIDString=app,remoteInfo='FieldArena')
test=add('PBXNativeTarget',buildConfigurationList=configs(tset),buildPhases=[phase('PBXSourcesBuildPhase',[testFile,appFiles[1],widgetFile]),phase('PBXResourcesBuildPhase',[local]),phase('PBXFrameworksBuildPhase',[])],buildRules=[],dependencies=[add('PBXTargetDependency',target=app,targetProxy=tproxy)],name='FieldProof',productName='FieldProof',productReference=prod[2],productType='com.apple.product-type.bundle.ui-testing')
o[prid]=dict(isa='PBXProject',attributes={'BuildIndependentTargetsInParallel':'YES','LastUpgradeCheck':'2720','ORGANIZATIONNAME':'Cobalt Field Studio','TargetAttributes':{app:{'SystemCapabilities':{'com.apple.GameCenter':{'enabled':1},'com.apple.ApplicationGroups.iOS':{'enabled':1},'com.apple.Push':{'enabled':1},'com.apple.BackgroundModes':{'enabled':1}}},test:{'TestTargetID':app}}},buildConfigurationList=configs(settings),compatibilityVersion='Xcode 14.0',developmentRegion='en',hasScannedForEncodings=0,knownRegions=langs,mainGroup=root,productRefGroup=products,projectDirPath='',projectRoot='',targets=[app,widget,test])
def val(x):
 if isinstance(x,dict):return '{'+''.join(str(k)+' = '+val(v)+';' for k,v in x.items())+'}'
 if isinstance(x,list):return '('+','.join(val(v) for v in x)+(',' if x else '')+')'
 if isinstance(x,int):return str(x)
 return json.dumps(x,ensure_ascii=False)
p=r/'SportsTrivia.xcodeproj';p.mkdir(exist_ok=True)
(p/'project.pbxproj').write_text('// !$*UTF8*$!\n'+val({'archiveVersion':1,'classes':{},'objectVersion':56,'objects':o,'rootObject':prid}))
s=p/'xcshareddata'/'xcschemes';s.mkdir(parents=True,exist_ok=True)
def bre(i,n):return f'<BuildableReference BuildableIdentifier="primary" BlueprintIdentifier="{i}" BuildableName="{n}" BlueprintName="{o[i]["name"]}" ReferencedContainer="container:SportsTrivia.xcodeproj"/>'
(s/'FieldArena.xcscheme').write_text(f'''<?xml version="1.0" encoding="UTF-8"?><Scheme LastUpgradeVersion="2720" version="1.7"><BuildAction parallelizeBuildables="YES" buildImplicitDependencies="YES"><BuildActionEntries><BuildActionEntry buildForTesting="YES" buildForRunning="YES" buildForProfiling="YES" buildForArchiving="YES" buildForAnalyzing="YES">{bre(app,'SportsTrivia.app')}</BuildActionEntry></BuildActionEntries></BuildAction><TestAction buildConfiguration="Debug" shouldUseLaunchSchemeArgsEnv="YES"><Testables><TestableReference skipped="NO">{bre(test,'FieldProof.xctest')}</TestableReference></Testables></TestAction><LaunchAction buildConfiguration="Debug" selectedDebuggerIdentifier="Xcode.DebuggerFoundation.Debugger.LLDB" selectedLauncherIdentifier="Xcode.IDEFoundation.Launcher.LLDB" launchStyle="0" useCustomWorkingDirectory="NO" ignoresPersistentStateOnLaunch="NO" debugDocumentVersioning="YES" debugServiceExtension="internal" allowLocationSimulation="YES"><BuildableProductRunnable runnableDebuggingMode="0">{bre(app,'SportsTrivia.app')}</BuildableProductRunnable></LaunchAction><ProfileAction buildConfiguration="Release" shouldUseLaunchSchemeArgsEnv="YES" useCustomWorkingDirectory="NO" debugDocumentVersioning="YES"><BuildableProductRunnable runnableDebuggingMode="0">{bre(app,'SportsTrivia.app')}</BuildableProductRunnable></ProfileAction><AnalyzeAction buildConfiguration="Debug"/><ArchiveAction buildConfiguration="Release" revealArchiveInOrganizer="YES"/></Scheme>''')
print('Project objects:',len(o))
