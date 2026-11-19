import SwiftUI
import WidgetKit

struct Y4b:TimelineEntry{var date:Date;var b:B2f}
struct E7h:TimelineProvider {
 func placeholder(in context:Context)->Y4b{Y4b(date:Date(),b:B2f(day:d4(),streak:0,score:0,categories:[0,0,0],friends:[],ready:true))}
 func getSnapshot(in context:Context,completion:@escaping(Y4b)->Void){completion(r2w())}
 func getTimeline(in context:Context,completion:@escaping(Timeline<Y4b>)->Void){let now=Date();let next=Calendar.current.date(byAdding:.day,value:1,to:Calendar.current.startOfDay(for:now))!;var entries=[r2w()];if let until=entries[0].b.friendUntil,until>now,until<next{entries.append(r2w(until.addingTimeInterval(1)))};entries.append(r2w(next));completion(Timeline(entries:entries.sorted{$0.date<$1.date},policy:.after(next.addingTimeInterval(60))))}
 func r2w(_ date:Date=Date())->Y4b{let u=UserDefaults(suiteName:z8G);let p=u?.data(forKey:"ledger").flatMap{try? JSONDecoder().decode(P3d.self,from:$0)} ?? P3d();let saved=u?.data(forKey:"glance").flatMap{try? JSONDecoder().decode(B2f.self,from:$0)};let b=B2f(friendUntil:saved?.friendUntil,day:d4(date),streak:p.streakAt(date),score:p.weekAt(date),categories:(0..<3).map{c in p.history.filter{$0.mode=="c\(c)"}.count},friends:((saved?.friendUntil ?? .distantPast)>date ? saved?.friends:nil) ?? [],ready:p.daily[d4(date)]==nil);return Y4b(date:date,b:b)}
}
#if !WIDGET_PROOF
@main struct A8q:Widget {
 var body:some WidgetConfiguration{StaticConfiguration(kind:"CobaltFieldGlance",provider:E7h()){entry in G7p(e:entry)}.configurationDisplayName(v3("widget_name")).description(v3("widget_detail")).supportedFamilies([.systemSmall,.systemMedium,.systemLarge,.accessoryCircular,.accessoryRectangular,.accessoryInline])}
}
#endif
struct G7p:View {
 var e:Y4b;var proofFamily:WidgetFamily?=nil;@Environment(\.widgetFamily) var family
 var f:WidgetFamily {proofFamily ?? family}
 let cyan=Color(red:0.22,green:0.74,blue:0.973)
 var body:some View {
  Group{
   switch f {
   case .accessoryInline:Label(v3(e.b.ready ? "daily_ready":"daily_done"),systemImage:"questionmark.circle")
   case .accessoryCircular:Gauge(value:Double(min(e.b.streak,7)),in:0...7){Image(systemName:"questionmark") }currentValueLabel:{Text("\(e.b.streak)")}.gaugeStyle(.accessoryCircular)
   case .accessoryRectangular:VStack(alignment:.leading,spacing:3){Text(v3(e.b.ready ? "daily_ready":"daily_done")).font(.headline).lineLimit(2);Label("\(e.b.streak) · "+v3("day_streak"),systemImage:"flame").font(.caption).lineLimit(1)}
   default:VStack(alignment:.leading,spacing:f == .systemSmall ? 6:12){HStack{Image(systemName:"sportscourt.fill").foregroundStyle(cyan);Text("Sports Trivia").font(.caption.bold());Spacer()}
    if f == .systemSmall {Text(v3("daily")).font(.headline).lineLimit(2);Text(v3("cat\(c9d())")).font(.caption).foregroundStyle(cyan);Spacer(minLength:0);Label("\(e.b.streak) · "+v3("day_streak"),systemImage:"flame.fill").font(.caption);Text(v3(e.b.ready ? "widget_start":"daily_done")).font(.caption2).foregroundStyle(.secondary)}else{
     HStack{VStack(alignment:.leading,spacing:4){Text(v3("weekly_match")).font(.headline);Text(v3("week_points")).font(.caption).foregroundStyle(.secondary)};Spacer();Text("\(e.b.score)").font(.system(size:36,weight:.heavy,design:.rounded)).foregroundStyle(cyan)}
     Label("\(e.b.streak) · "+v3("day_streak"),systemImage:"flame.fill").font(.caption)
     if f == .systemLarge {Divider();ForEach(0..<3){i in HStack{Text(v3("cat\(i)"));Spacer();Text("\(e.b.categories.indices.contains(i) ? e.b.categories[i]:0)").foregroundStyle(cyan)}};Divider();Text(v3("friends_league")).font(.headline);if e.b.friends.isEmpty{Text(v3("empty_league")).font(.caption).foregroundStyle(.secondary).lineLimit(3)}else{ForEach(e.b.friends,id:\.self){Text($0).font(.caption)}};Spacer(minLength:0)}
    }
   }
   }
  }.foregroundStyle([WidgetFamily.systemSmall,.systemMedium,.systemLarge].contains(f) ? Color.white:Color.primary).containerBackground(for:.widget){Color(red:0.043,green:0.122,blue:0.227)}.widgetURL(URL(string:f == .systemMedium || f == .systemLarge ? "fieldtrivia://ranking":"fieldtrivia://daily"))
 }
 func c9d()->Int {let n=Calendar.current.dateComponents([.day],from:Date(timeIntervalSince1970:0),to:Calendar.current.startOfDay(for:e.date)).day ?? 0;return (abs(n)%36)/12}
}
