import SwiftUI
import Combine
import UserNotifications
import WidgetKit
import BackgroundTasks

@MainActor final class K6m:ObservableObject {
 @Published var p=P3d();@Published var bank:[Q8r]=[];@Published var busy=false;@Published var message="";@Published var friends:[String]=[];var friendUntil:Date?=nil
 private var latest=Date.distantPast
 private var disk:URL {FileManager.default.urls(for:.applicationSupportDirectory,in:.userDomainMask)[0].appendingPathComponent("q82-ledger.json")}
 init(){
  #if DEBUG && targetEnvironment(simulator)
  if let screen = ScreenshotScreen.current {
   loadBundledQuestions()
   seedScreenshot(screen)
   return
  }
  #endif
  if let data=try? Data(contentsOf:disk),let x=try? JSONDecoder().decode(P3d.self,from:data){p=x}
  loadBundledQuestions()
  if let d=UserDefaults(suiteName:z8G)?.data(forKey:"glance"),let b=try? JSONDecoder().decode(B2f.self,from:d),let until=b.friendUntil,until>Date(){friends=b.friends;friendUntil=until}
  p8b()
 }
 private func loadBundledQuestions() {
  if let u=Bundle.main.url(forResource:"Fieldbook",withExtension:"json"),let b=try? Data(contentsOf:u),let q=try? JSONDecoder().decode([Q8r].self,from:b){bank=q}
 }

 #if DEBUG && targetEnvironment(simulator)
 private func seedScreenshot(_ screen: ScreenshotScreen) {
  let ids = Duel10x2.questionIDs(for: ScreenshotScreen.challengeCode, in: bank.map(\.id))
  startChallenge(ids)
  guard screen != .timedQuestion, let round = p.round else { return }
  for (index, question) in round.qs.enumerated() {
   let pick = index == round.qs.count - 1 ? (question.a + 1) % question.choices.count : question.a
   a6c(pick)
   n2q()
  }
  if screen == .roundResults { return }
  c1t()
  if screen == .playHome || screen == .weeklyRanking {
   z6k(-1, mode: "daily")
   if let question = p.round?.qs.first {
    a6c(question.a)
    c1t()
   }
  }
 }
 #endif

 func n8v(){
  #if DEBUG && targetEnvironment(simulator)
  if ScreenshotScreen.current != nil { return }
  #endif
  do{try FileManager.default.createDirectory(at:disk.deletingLastPathComponent(),withIntermediateDirectories:true);try JSONEncoder().encode(p).write(to:disk,options:.atomic)}catch{message=v3("save_error")};p8b()
 }
 func p8b(){
  #if DEBUG && targetEnvironment(simulator)
  if ScreenshotScreen.current != nil { return }
  #endif
  if let d=try? JSONEncoder().encode(p){UserDefaults(suiteName:z8G)?.set(d,forKey:"ledger")};let counts=(0...2).map{ c in p.history.filter{$0.mode=="c\(c)"}.count};let b=B2f(friendUntil:friendUntil,day:d4(),streak:p.streak,score:p.week,categories:counts,friends:(friendUntil ?? .distantPast)>Date() ? friends:[],ready:p.daily[d4()]==nil);if let d=try? JSONEncoder().encode(b){UserDefaults(suiteName:z8G)?.set(d,forKey:"glance")};WidgetCenter.shared.reloadAllTimelines()
 }
 func startChallenge(_ ids: [String]) {
  guard p.round == nil else { return }
  let questions = ids.compactMap { id in bank.first { $0.id == id } }
  guard questions.count == 10 else { return }
  p.round = R2k(qs: questions, mode: "mixed")
  n8v()
 }
 func d3q(_ moment:Date)->Q8r {let n=Calendar.current.dateComponents([.day],from:Date(timeIntervalSince1970:0),to:Calendar.current.startOfDay(for:moment)).day ?? 0;return bank[abs(n)%max(1,bank.count)]}
 func z6k(_ category:Int,mode:String="",chapter:Int=0){
  guard p.round==nil else {return};let moment=Date();let qs=category<0 ? bank : bank.filter{$0.c==category};guard qs.count>=10 else{return}
  var deck=Array(qs.shuffled().prefix(10));if mode=="season" {let shift=(Calendar.current.component(.year,from:moment)*4+(Calendar.current.component(.month,from:moment)-1)/3+chapter*10)%qs.count;deck=(0..<10).map{qs[(shift+$0)%qs.count]}};if mode=="daily"{deck=[d3q(moment)]};var u=R2k(qs:deck,mode:mode.isEmpty ? (category<0 ? "mixed":"c\(category)") : mode,chapter:chapter);u.d8a=d4(moment);u.s4a="\(Calendar.current.component(.year,from:moment))-\((Calendar.current.component(.month,from:moment)-1)/3)-\(chapter)";p.round=u;n8v()
 }
 func x5d(_ m:String,_ qs:[Q8r]){guard p.round==nil,qs.count==10 else {return};UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers:["turn-"+m]);UNUserNotificationCenter.current().removeDeliveredNotifications(withIdentifiers:["turn-"+m]);if !p.turnSeen.contains(m){p.turnSeen.append(m)};p.round=R2k(qs:qs,mode:"duel",match:m);n8v()}
 func a6c(_ a:Int){guard var r=p.round,!r.done,!r.revealed else{return};let actual=Date()>r.deadline ? -1:a;r.answers.append(actual);r.revealed=true;p.round=r;if r.done{f9s()}else{n8v()}}
 func n2q(){guard var r=p.round,r.revealed else{return};r.revealed=false;r.deadline=Date().addingTimeInterval(20);p.round=r;n8v()}
 func f9s(){guard let r=p.round,r.done,!p.history.contains(where:{$0.id==r.id}) else{return}
  p.history.insert(T6s(id:r.id,date:Date(),score:r.score,total:r.qs.count,mode:r.mode,chapter:r.chapter,reviewIDs:r.qs.map(\.id),reviewPicks:r.answers),at:0)
  if r.mode=="daily" {p.daily[r.d8a]=r.score;Task{await s8n()}}
  if r.mode=="season" {let key=r.s4a.isEmpty ? "\(Calendar.current.component(.year,from:Date()))-\((Calendar.current.component(.month,from:Date())-1)/3)-\(r.chapter)":r.s4a;p.chapters[key]=max(p.chapters[key] ?? 0,r.score)}
  n8v()
 }
 func c1t(_ token:String?=nil){guard token==nil || p.round?.id==token else{return};p.round=nil;n8v()}
 var seasonKeys:[String] {(0..<4).map{"\(Calendar.current.component(.year,from:Date()))-\((Calendar.current.component(.month,from:Date())-1)/3)-\($0)"}}
 func u9p() async {
  #if DEBUG && targetEnvironment(simulator)
  if ScreenshotScreen.current != nil { return }
  #endif
  do{let ok=try await UNUserNotificationCenter.current().requestAuthorization(options:[.alert,.sound,.badge]);p.notices=ok;message=v3(ok ? "notice_on":"notice_denied");n8v();await s8n()}catch{message=v3("notice_denied")}
 }
 func s8n() async {
  #if DEBUG && targetEnvironment(simulator)
  if ScreenshotScreen.current != nil { return }
  #endif
  let c=UNUserNotificationCenter.current();let pending=await c.pendingNotificationRequests();c.removePendingNotificationRequests(withIdentifiers:pending.filter{$0.identifier.hasPrefix("daily") || $0.identifier=="weekly"}.map(\.identifier));guard p.notices else{return}
  let cal=Calendar.current
  for offset in 0..<14 {guard let day=cal.date(byAdding:.day,value:offset,to:Date()),let at=cal.date(bySettingHour:19,minute:0,second:0,of:day),at>Date(),p.daily[d4(day)]==nil else{continue}
   let n=UNMutableNotificationContent();n.title=v3("daily_ready");n.body=v3("notice_body");n.sound = .default;n.userInfo=["route":"daily"]
   let dc=cal.dateComponents([.year,.month,.day,.hour,.minute],from:at);try? await c.add(UNNotificationRequest(identifier:"daily-"+d4(day),content:n,trigger:UNCalendarNotificationTrigger(dateMatching:dc,repeats:false)))
  }
  let n=UNMutableNotificationContent();n.title=v3("weekly_ready");n.body=v3("notice_body");n.sound = .default;n.userInfo=["route":"weekly"]
  try? await c.add(UNNotificationRequest(identifier:"weekly",content:n,trigger:UNCalendarNotificationTrigger(dateMatching:DateComponents(hour:19,minute:5,weekday:2),repeats:true)))
 }

 func r4f(_ id:String){guard p.notices,!p.turnSeen.contains(id) else{return};p.turnSeen.append(id);n8v();let n=UNMutableNotificationContent();n.title=v3("turn_ready");n.body=v3("turn_body");n.userInfo=["route":"duels"];UNUserNotificationCenter.current().add(UNNotificationRequest(identifier:"turn-"+id,content:n,trigger:UNTimeIntervalNotificationTrigger(timeInterval:2,repeats:false)))}
 func w6c() async {
  #if DEBUG && targetEnvironment(simulator)
  if ScreenshotScreen.current != nil { return }
  #endif
  guard !busy else{return};guard Date().timeIntervalSince(latest)>=6 else{message=v3("slow_down");return};latest=Date();busy=true;defer{busy=false}
  do{
   var req=URLRequest(url:URL(string:"https://opentdb.com/api.php?amount=10&category=21&type=multiple&encode=url3986")!);req.timeoutInterval=15
   let (d,r)=try await URLSession.shared.data(for:req);guard (r as? HTTPURLResponse)?.statusCode==200 else{throw URLError(.badServerResponse)}
   struct E:Decodable{var response_code:Int;var results:[F]};struct F:Decodable{var question:String;var correct_answer:String;var incorrect_answers:[String]}
   let e=try JSONDecoder().decode(E.self,from:d);guard e.response_code==0 else{message=v3(e.response_code==5 ? "slow_down":"update_failed");return}
   func decode(_ s:String)->String{s.removingPercentEncoding ?? s}
   let extra=e.results.compactMap{f->Q8r? in let q=decode(f.question);let all=([f.correct_answer]+f.incorrect_answers).map(decode);let bad=["casino","bet","gambl","poker","jackpot","money","dollar","prize","odds","lottery","cash","slot","bonus","roulette","wager","payout","salary","transfer fee","million","billion","$","€","£"]
    guard all.count==4,Set(all).count==4,!bad.contains(where:{(q+all.joined()).lowercased().contains($0)}) else{return nil};return Q8r(id:"web-"+q,c:3,q:["en":q],o:["en":all],a:0,src:"https://opentdb.com")}
   let u=disk.deletingLastPathComponent().appendingPathComponent("open-library.json");let existing=d7w();var merged=Dictionary(existing.map{($0.id,$0)},uniquingKeysWith:{$1});for q in extra{merged[q.id]=q};try JSONEncoder().encode(Array(merged.values.prefix(200))).write(to:u,options:.atomic);message=v3("update_done")
  }catch{message=v3("update_failed")}
 }
 func d7w()->[Q8r]{
  #if DEBUG && targetEnvironment(simulator)
  if ScreenshotScreen.current != nil { return [] }
  #endif
  let u=disk.deletingLastPathComponent().appendingPathComponent("open-library.json");return (try? JSONDecoder().decode([Q8r].self,from:Data(contentsOf:u))) ?? []
 }
 func e5j(){guard p.round==nil else{return};let q=d7w();guard q.count>=10 else{message=v3("web_need");return};p.round=R2k(qs:Array(q.shuffled().prefix(10)),mode:"web");n8v()}
}
final class N7v:NSObject,UIApplicationDelegate,UNUserNotificationCenterDelegate {
 func application(_ application:UIApplication,didFinishLaunchingWithOptions launchOptions:[UIApplication.LaunchOptionsKey:Any]?=nil)->Bool{
  #if DEBUG && targetEnvironment(simulator)
  if ScreenshotScreen.current != nil {
   UIView.setAnimationsEnabled(false)
   return true
  }
  #endif
  UNUserNotificationCenter.current().delegate=self
  BGTaskScheduler.shared.register(forTaskWithIdentifier:"org.cobaltfield.triviaq82.refresh",using:nil){task in
   let j=Task{@MainActor in let k=K6m();await k.s8n();if k.p.autoUpdates {await k.w6c()};task.setTaskCompleted(success:!Task.isCancelled)};task.expirationHandler={j.cancel()}
  };return true
 }
 func applicationDidEnterBackground(_ application:UIApplication){Self.p1s()}
 static func p1s(){
  #if DEBUG && targetEnvironment(simulator)
  if ScreenshotScreen.current != nil { return }
  #endif
  let r=BGAppRefreshTaskRequest(identifier:"org.cobaltfield.triviaq82.refresh");r.earliestBeginDate=Date().addingTimeInterval(86400);try? BGTaskScheduler.shared.submit(r)
 }
 func userNotificationCenter(_ center:UNUserNotificationCenter,didReceive response:UNNotificationResponse) async {
  let route=response.notification.request.content.userInfo["route"] as? String ?? "daily";await MainActor.run {UIApplication.shared.open(URL(string:"fieldtrivia://\(route)")!)}
 }
}
