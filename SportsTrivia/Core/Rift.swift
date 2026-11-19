import Foundation

let z8G = "group.org.cobaltfield.triviaq82"
final class L9r:NSObject {}
let j8B=Bundle(for:L9r.self)
#if DEBUG && targetEnvironment(simulator)
enum ScreenshotScreen: String, CaseIterable {
 case playHome = "play-home"
 case timedQuestion = "timed-question"
 case roundResults = "round-results"
 case duelChallenge = "duel-challenge"
 case weeklyRanking = "weekly-ranking"

 static let challengeCode = "SportsTrivia-1234ABCD"
 static let current: ScreenshotScreen? = {
  let process = ProcessInfo.processInfo
  let arguments = process.arguments
  let environment = process.environment
  func value(after flag: String) -> String? {
   guard let position = arguments.firstIndex(of: flag) else { return nil }
   return arguments.dropFirst(position + 1).first
  }
  if arguments.contains("-ReviewScreen") {
   return value(after: "-ReviewScreen").flatMap { ScreenshotScreen(rawValue: $0) }
  }
  let usesArguments = arguments.contains("-AppStoreScreenshots")
  let usesEnvironment = environment["APPSTORE_SCREENSHOTS"] == "1"
  guard usesArguments || usesEnvironment else { return nil }
  let index = (usesArguments ? value(after: "-AppStoreScreenshotScreen") : nil)
   ?? (usesEnvironment ? environment["APPSTORE_SCREENSHOT_SCREEN"] : nil)
   ?? "0"
  guard let number = Int(index), ScreenshotScreen.allCases.indices.contains(number) else { return nil }
  return ScreenshotScreen.allCases[number]
 }()
 static let englishBundle = j8B.url(forResource: "en", withExtension: "lproj").flatMap { Bundle(url: $0) }

 var tab: Int {
  switch self {
  case .playHome: return 0
  case .timedQuestion, .roundResults, .duelChallenge: return 1
  case .weeklyRanking: return 2
  }
 }

 var presentsRound: Bool { self == .timedQuestion || self == .roundResults }
}
#endif

func v3(_ s:String)->String {
 #if DEBUG && targetEnvironment(simulator)
 if ScreenshotScreen.current != nil, let english = ScreenshotScreen.englishBundle {
  return NSLocalizedString(s, bundle: english, comment: "")
 }
 #endif
 return NSLocalizedString(s,bundle:j8B,comment: "")
}
func k7()->String {
 #if DEBUG && targetEnvironment(simulator)
 if ScreenshotScreen.current != nil { return "en" }
 #endif
 let s=j8B.preferredLocalizations.first ?? "en"; return s.hasPrefix("pt") ? "pt-BR" : String(s.prefix(2))
}
func d4(_ d:Date = Date())->String { let f=DateFormatter(); f.locale=Locale(identifier:"en_US_POSIX");f.calendar=Calendar(identifier:.gregorian); f.dateFormat="yyyy-MM-dd"; return f.string(from:d) }
func w4(_ d:Date = Date())->String { var c=Calendar(identifier:.iso8601);c.timeZone = .current;let a=c.dateComponents([.yearForWeekOfYear,.weekOfYear],from:d);return "\(a.yearForWeekOfYear!)-\(a.weekOfYear!)" }
func o4(_ r:String,_ q:String)->[Int] {
 var z=(r+q).utf8.reduce(UInt64(14695981039346656037)){($0 ^ UInt64($1)) &* 1099511628211};if z==0{z=9187321};var a=[0,1,2,3]
 for i in stride(from:3,through:1,by:-1){z ^= z << 13;z ^= z >> 7;z ^= z << 17;a.swapAt(i,Int(z % UInt64(i+1)))};return a
}

struct Q8r:Codable,Identifiable,Equatable {
 var id:String;var c:Int;var q:[String:String];var o:[String:[String]];var a:Int;var src:String
 var text:String {q[k7()] ?? q["en"] ?? ""};var choices:[String] {o[k7()] ?? o["en"] ?? []}
}
struct R2k:Codable,Identifiable {
 var id=UUID().uuidString;var d8a:String=d4();var s4a:String="";var qs:[Q8r];var mode:String;var chapter:Int=0;var match:String="";var answers:[Int]=[];var revealed=false;var deadline:Date=Date().addingTimeInterval(20)
 var score:Int { zip(qs,answers).filter{$0.0.a == $0.1}.count * 100 }
 var done:Bool {answers.count >= qs.count}
}
struct T6s:Codable,Identifiable { var id:String;var date:Date;var score:Int;var total:Int;var mode:String;var chapter:Int;var reviewIDs:[String]?=nil;var reviewPicks:[Int]?=nil;var reviewTime:[Int]?=nil }
struct P3d:Codable {
 var history:[T6s]=[];var daily:[String:Int]=[:];var round:R2k?;var chapters:[String:Int]=[:];var autoUpdates=false;var notices=false;var turnSeen:[String]=[]
 var streak:Int {streakAt(Date())}
 func streakAt(_ now:Date)->Int { var n=0;let c=Calendar.current;var date=now;if daily[d4(date)] == nil {date=c.date(byAdding:.day,value:-1,to:date)!};while daily[d4(date)] != nil {n+=1;date=c.date(byAdding:.day,value:-1,to:date)!};return n }
 var week:Int {weekAt(Date())}
 func weekAt(_ now:Date)->Int {var b:[String:Int]=[:];for x in history where w4(x.date)==w4(now) && x.total==10 { b[d4(x.date)]=max(b[d4(x.date)] ?? 0,x.score) };return b.values.reduce(0,+)}
}
struct B2f:Codable { var friendUntil:Date?=nil;var day:String;var streak:Int;var score:Int;var categories:[Int];var friends:[String];var ready:Bool }
struct W3n:Codable {var qs:[Q8r];var scores:[String:Int]=[:]}

func j6p(_ x:W3n,_ bank:[Q8r])->[Q8r]? {
 guard x.qs.count==10,Set(x.qs.map(\.id)).count==10,Set(x.scores.keys).isSubset(of:Set(["0","1"])),x.scores.values.allSatisfy({(0...1000).contains($0) && $0%100==0}) else{return nil}
 var a:[Q8r]=[];for q in x.qs{guard let local=bank.first(where:{$0.id==q.id}) else{return nil};a.append(local)};return a
}
