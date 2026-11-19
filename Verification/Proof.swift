#if MODEL_CLI
import Foundation
@main struct M8c {
 static func main() throws {
  let path=CommandLine.arguments[1]
  let qs=try JSONDecoder().decode([Q8r].self,from:Data(contentsOf:URL(fileURLWithPath:path)))
  precondition(qs.count==52)
  var r=R2k(qs:Array(qs.prefix(10)),mode:"c0")
  r.answers=r.qs.map{$0.a};precondition(r.score==1000 && r.done)
  r.answers=Array(repeating:-1,count:10);precondition(r.score==0)
  r.answers=[0];r.revealed=true
  let restored=try JSONDecoder().decode(R2k.self,from:JSONEncoder().encode(r));precondition(restored.revealed && restored.answers.count==1)
  var p=P3d();let now=Date()
  p.history=[T6s(id:"1",date:now,score:300,total:10,mode:"c0",chapter:0),T6s(id:"2",date:now,score:800,total:10,mode:"season",chapter:0),T6s(id:"3",date:now,score:1000,total:10,mode:"duel",chapter:0),T6s(id:"4",date:now,score:100,total:1,mode:"daily",chapter:0)]
  precondition(p.week==1000)
  let weekAhead=Calendar.current.date(byAdding:.day,value:7,to:now)!;precondition(p.weekAt(weekAhead)==0)
  p.daily[d4()]=0;precondition(p.streak==1)
  let yesterday=Calendar.current.date(byAdding:.day,value:-1,to:now)!;p.daily[d4(yesterday)]=100;precondition(p.streak==2)
  let afterGap=Calendar.current.date(byAdding:.day,value:2,to:now)!;precondition(p.streakAt(afterGap)==0)
  p.round=r;let copy=try JSONDecoder().decode(P3d.self,from:JSONEncoder().encode(p));precondition(copy.week==1000 && copy.round?.revealed==true)
  let cache=B2f(friendUntil:now.addingTimeInterval(3600),day:d4(),streak:2,score:800,categories:[1,0,0],friends:["fixture"],ready:false)
  let cached=try JSONDecoder().decode(B2f.self,from:JSONEncoder().encode(cache));precondition(cached.friends==["fixture"] && cached.friendUntil==cache.friendUntil)
  let duel=W3n(qs:Array(qs.prefix(10)),scores:["0":900,"1":600]);let turn=try JSONDecoder().decode(W3n.self,from:JSONEncoder().encode(duel));precondition(turn.scores["0"]==900 && turn.scores["1"]==600)
  precondition(o4("saved-round","q")==o4("saved-round","q"));var positions=Set<Int>();for i in 0..<100{let order=o4("round-\(i)","q");precondition(Set(order)==Set(0..<4));positions.insert(order.firstIndex(of:0)!)};precondition(positions.count==4)
  var foreign=duel;foreign.qs[0].q=["en":"foreign text"];foreign.qs[0].o=["en":[]];precondition(j6p(foreign,qs)?.first==qs.first);foreign.qs[1].id="unknown";precondition(j6p(foreign,qs)==nil);foreign=duel;foreign.scores["0"]=1100;precondition(j6p(foreign,qs)==nil)
  print("PASS: canonical bundled duel questions and invalid-payload rejection, stable diverse answer permutations, stable two-participant turn payload, friend-cache expiry persistence, content integrity, perfect score, timeout score, revealed-answer persistence, best daily aggregation, duel inclusion and daily exclusion, ISO week rollover, streak continuity, missed-day reset, ledger round-trip")
 }
}
#else
import SwiftUI
import WidgetKit
import XCTest

final class C9t:XCTestCase {
 func shot(_ name:String){let a=XCTAttachment(screenshot:XCUIApplication().screenshot());a.name=name;a.lifetime = .keepAlways;add(a)}
 @MainActor func test01FullRoundAndPersistence() throws {
  let a=XCUIApplication();a.launchArguments=["-AppleLanguages","(en)","-AppleLocale","en_US"];a.launch()
  XCTAssertTrue(a.buttons["startRound"].waitForExistence(timeout:15));shot("01-home")
  a.buttons["startRound"].tap();XCTAssertTrue(a.buttons["answer0"].waitForExistence(timeout:5));shot("02-round")
  a.buttons["answer0"].tap();XCTAssertTrue(a.buttons["nextQuestion"].exists)
  a.buttons["Close"].tap();a.buttons["Save and leave"].tap();XCTAssertTrue(a.buttons["startRound"].waitForExistence(timeout:5));XCTAssertTrue(a.buttons["startRound"].isHittable);shot("02a-saved-round-home");a.buttons["startRound"].tap();XCTAssertTrue(a.buttons["nextQuestion"].waitForExistence(timeout:5))
  a.terminate();a.launch();XCTAssertTrue(a.buttons["nextQuestion"].waitForExistence(timeout:10));a.buttons["nextQuestion"].tap()
  for _ in 1..<10 {let answer=a.buttons["answer0"];XCTAssertTrue(answer.waitForExistence(timeout:5));answer.tap();let next=a.buttons["nextQuestion"];if !next.isHittable {a.swipeUp()};XCTAssertTrue(next.waitForExistence(timeout:3));next.tap()}
  XCTAssertTrue(a.buttons["backHome"].waitForExistence(timeout:5));shot("03-results");a.buttons["backHome"].tap()
  a.buttons["Ranking"].firstMatch.tap();XCTAssertTrue(a.staticTexts["This week’s form"].waitForExistence(timeout:5));shot("04-ranking")
  a.buttons["Duels"].firstMatch.tap();XCTAssertTrue(a.buttons["connectGameCenter"].waitForExistence(timeout:5));shot("05-duels")
 }
 @MainActor func test02DailyAndTimeout() throws {
  let a=XCUIApplication();a.launchArguments=["-AppleLanguages","(en)","-AppleLocale","en_US"];a.launch()
  let daily=a.buttons["daily"];a.swipeUp();XCTAssertTrue(daily.waitForExistence(timeout:5));daily.tap()
  XCTAssertTrue(a.buttons["answer0"].waitForExistence(timeout:5));a.terminate();Thread.sleep(forTimeInterval:21);a.launch()
  XCTAssertTrue(a.staticTexts["Time is up"].waitForExistence(timeout:8));a.buttons["nextQuestion"].tap();XCTAssertTrue(a.buttons["backHome"].waitForExistence(timeout:5));a.buttons["backHome"].tap();a.swipeUp();XCTAssertTrue(a.staticTexts["Completed today. See you tomorrow."].waitForExistence(timeout:5));shot("06-daily-complete")
 }
 @MainActor func test03LocalizedColdLaunches() throws {
  let a=XCUIApplication()
  for (lang,title) in [("de","Wähle dein Gebiet"),("pt-BR","Escolha seu campo"),("fr","Choisissez votre terrain"),("es","Elige tu terreno"),("it","Scegli il tuo campo"),("ru","Выбери свою тему")] {
   a.terminate();a.launchArguments=["-AppleLanguages","(\(lang))"];a.launch();XCTAssertTrue(a.buttons["startRound"].waitForExistence(timeout:10));XCTAssertTrue(a.staticTexts[title].exists);shot("locale-"+lang)
  }
 }
 func test04ModelInvariants() throws {
  let q=Q8r(id:"a",c:0,q:["en":"Q"],o:["en":["A","B","C","D"]],a:2,src:"")
  var r=R2k(qs:Array(repeating:q,count:10),mode:"c0");r.answers=[2,2,-1,1,2,0,2,3,2,2]
  XCTAssertEqual(r.score,600);XCTAssertTrue(r.done)
  var p=P3d();p.history=[T6s(id:"1",date:Date(),score:500,total:10,mode:"c0",chapter:0),T6s(id:"2",date:Date(),score:700,total:10,mode:"c1",chapter:0),T6s(id:"3",date:Date(),score:1000,total:10,mode:"duel",chapter:0)]
  XCTAssertEqual(p.week,1000);p.daily[d4()]=0;XCTAssertEqual(p.streak,1)
  p.daily[d4(Calendar.current.date(byAdding:.day,value:-1,to:Date())!)]=100;XCTAssertEqual(p.streak,2)
  let d=try JSONEncoder().encode(p);let copy=try JSONDecoder().decode(P3d.self,from:d);XCTAssertEqual(copy.week,1000)
 }
 @MainActor func test05NotificationDenied() throws {
  let a=XCUIApplication();a.launchArguments=["-AppleLanguages","(en)","-AppleLocale","en_US"];a.launch();a.buttons["More"].firstMatch.tap()
  XCTAssertTrue(a.buttons["Enable reminders"].waitForExistence(timeout:5));a.buttons["Enable reminders"].tap()
  let spring=XCUIApplication(bundleIdentifier:"com.apple.springboard")
  let deny=spring.alerts.buttons.matching(NSPredicate(format:"label == %@ OR label == %@","Don’t Allow","Don't Allow")).firstMatch
  if deny.waitForExistence(timeout:5){deny.tap()}
  XCTAssertTrue(a.alerts.staticTexts["Reminders are unavailable. You can enable notifications in system settings."].waitForExistence(timeout:5));shot("07-reminders-denied")
  a.alerts.buttons["OK"].tap()
 }

 @MainActor func test06WidgetLayouts() throws {
  let e=Y4b(date:Date(),b:B2f(day:d4(),streak:0,score:0,categories:[0,0,0],friends:[],ready:true))
  let sizes:[(WidgetFamily,CGFloat,CGFloat,String)]=[(.systemSmall,170,170,"small"),(.systemMedium,364,170,"medium"),(.systemLarge,364,390,"large"),(.accessoryRectangular,190,90,"lock-rectangle"),(.accessoryCircular,80,80,"lock-circle"),(.accessoryInline,364,44,"lock-inline")]
  for (family,w,h,name) in sizes {
   let view=G7p(e:e,proofFamily:family).environment(\.colorScheme,.dark).padding([WidgetFamily.systemSmall,.systemMedium,.systemLarge].contains(family) ? 16:0).frame(width:w,height:h).background(Color(red:0.043,green:0.122,blue:0.227))
   let render=ImageRenderer(content:view);render.scale=2;let image=try XCTUnwrap(render.uiImage);XCTAssertGreaterThan(image.size.width,0)
   let a=XCTAttachment(image:image);a.name="widget-"+name;a.lifetime = .keepAlways;add(a)
  }
 }

}

#endif
