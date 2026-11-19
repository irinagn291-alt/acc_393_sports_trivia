import SwiftUI
import Combine

let qN=Color(red:0.043,green:0.122,blue:0.227)
let qB=Color(red:0.145,green:0.388,blue:0.922)
let qC=Color(red:0.22,green:0.74,blue:0.973)

@main struct F4z:App {
 @UIApplicationDelegateAdaptor(N7v.self) var delegate
 @StateObject var k=K6m()
 var body:some Scene {
  WindowGroup {
   #if DEBUG && targetEnvironment(simulator)
   if ScreenshotScreen.current != nil {
    root.defaultAppStorage(Self.screenshotDefaults)
     .environment(\.locale, Locale(identifier: "en_US"))
     .transaction { $0.disablesAnimations = true }
   } else {
    root
   }
   #else
   root
   #endif
  }
 }

 private var root: some View {
  U9j().environmentObject(k).preferredColorScheme(.dark)
 }

 #if DEBUG && targetEnvironment(simulator)
 private static let screenshotDefaults: UserDefaults = {
  let suite = "org.cobaltfield.triviaq82.screenshots"
  let defaults = UserDefaults(suiteName: suite)!
  defaults.removePersistentDomain(forName: suite)
  return defaults
 }()
 #endif
}
struct U9j:View {
 @EnvironmentObject var k:K6m;@Environment(\.scenePhase) var phase
 @State var tab=0;@State var open=false;@State var confirm=false;@State var b8t=false;@State var d3t=d4()
 #if DEBUG && targetEnvironment(simulator)
 init() {
  if let screen = ScreenshotScreen.current {
   _tab = State(initialValue: screen.tab)
   _open = State(initialValue: screen.presentsRound)
   _b8t = State(initialValue: true)
  }
 }
 #endif
 var body:some View {
  TabView(selection:$tab){
   NavigationStack {h9j.id(d3t)}.tabItem{Label(v3("play"),systemImage:"sportscourt.fill")}.tag(0)
   NavigationStack {d8j}.tabItem{Label(v3("duels"),systemImage:"person.2.fill")}.tag(1)
   NavigationStack {t6j}.tabItem{Label(v3("ranking"),systemImage:"chart.bar.xaxis")}.tag(2)
   NavigationStack {s4j}.tabItem{Label(v3("more"),systemImage:"ellipsis.circle")}.tag(3)
  }.tint(qC).onAppear {if !b8t {b8t=true;if k.p.round != nil {r8u()}}}
  .onChange(of:k.p.round?.id){_,n in if n != nil {r8u()}else{open=false}}
  .onChange(of:phase){_,p in if p == .active {Task{await k.s8n();await v5z()}};if p == .background {N7v.p1s()}}
  .onOpenURL{u in switch u.host {case "duels":tab=1;case "ranking","weekly":tab=2;default:tab=0;if k.p.round==nil && k.p.daily[d4()]==nil{k.z6k(-1,mode:"daily")}}}
  .fullScreenCover(isPresented:$open){J5a().environmentObject(k).interactiveDismissDisabled()}
  .alert(v3("notice"),isPresented:Binding(get:{!k.message.isEmpty},set:{if !$0{k.message=""}})){Button(v3("ok")){k.message=""}}message:{Text(k.message)}
  .onReceive(NotificationCenter.default.publisher(for:.NSCalendarDayChanged)){_ in d3t=d4()}
  .task {await k.s8n()}
 }
 func r8u(){if k.p.round?.mode=="web" && k7() != "en" {open=false;k.message=v3("english_library")}else{open=true}}
 func v5z() async {k.p8b()}
 var h9j:some View {
  ScrollView {
   VStack(alignment:.leading,spacing:24){
    HStack {VStack(alignment:.leading,spacing:4){Text(v3("field_notes")).font(.caption.weight(.bold)).tracking(2).foregroundStyle(qC);Text("Sports Trivia").font(.largeTitle.weight(.heavy))};Spacer();Image(systemName:"sportscourt").font(.title).foregroundStyle(qC).padding(14).background(qC.opacity(0.12),in:Circle())}
    Button {if k.p.round != nil{r8u()}else{k.z6k(-1)}} label:{
     HStack(alignment:.center){VStack(alignment:.leading,spacing:12){Text(v3("hero_kicker")).font(.caption.weight(.bold)).tracking(1.5);Text(v3("hero_title")).font(.system(.largeTitle,design:.rounded,weight:.heavy)).multilineTextAlignment(.leading);Label(v3(k.p.round==nil ? "start_round":"resume"),systemImage:"arrow.right.circle.fill").font(.headline)};Spacer(minLength:5);VStack(spacing:0){Text("10").font(.system(size:70,weight:.black,design:.rounded));Text(v3("questions")).font(.caption.weight(.semibold))}.accessibilityHidden(true)}.foregroundStyle(.white).padding(24).frame(maxWidth:.infinity,minHeight:210).background(LinearGradient(colors:[qB,Color(red:0.06,green:0.34,blue:0.7)],startPoint:.topLeading,endPoint:.bottomTrailing),in:RoundedRectangle(cornerRadius:28))
    }.buttonStyle(.plain).accessibilityIdentifier("startRound")
    HStack(spacing:12){h3w("flame.fill","\(k.p.streak)","day_streak");h3w("chart.bar.fill","\(k.p.week)","week_points");h3w("checkmark.circle.fill","\(k.p.history.count)","rounds")}
    if k.p.round != nil {Button(v3("discard"),role:.destructive){confirm=true}.confirmationDialog(v3("discard_confirm"),isPresented:$confirm,titleVisibility:.visible){Button(v3("discard"),role:.destructive){k.c1t()};Button(v3("cancel"),role:.cancel){}}}
    HStack{Text(v3("choose_category")).font(.title2.bold());Spacer();Text(v3("offline")).font(.caption.bold()).foregroundStyle(qC)}
    LazyVGrid(columns:[GridItem(.adaptive(minimum:240),spacing:12)],spacing:12){ForEach(0..<3){i in Button {if k.p.round != nil{r8u()}else{k.z6k(i)}}label:{HStack(spacing:16){Image(systemName:["trophy.fill","clock.arrow.circlepath","figure.run"][i]).font(.title2).foregroundStyle(qC).frame(width:42,height:48);VStack(alignment:.leading,spacing:5){Text(v3("cat\(i)")).font(.headline);Text(v3("category_detail")).font(.caption).foregroundStyle(.secondary)};Spacer();Image(systemName:"chevron.right").font(.caption)}.padding(18).frame(maxWidth:.infinity,alignment:.leading).background(.white.opacity(0.065),in:RoundedRectangle(cornerRadius:20))}.buttonStyle(.plain).disabled(k.p.round != nil).accessibilityIdentifier("category\(i)")}}
    Button {if k.p.round != nil {r8u()}else if k.p.daily[d4()]==nil{k.z6k(-1,mode:"daily")}}label:{HStack(spacing:16){Image(systemName:k.p.daily[d4()]==nil ? "sun.max.fill":"checkmark.seal.fill").font(.title).foregroundStyle(.yellow);VStack(alignment:.leading,spacing:5){Text(v3("daily")).font(.headline);Text(v3(k.p.daily[d4()]==nil ? "daily_detail":"daily_done")).font(.subheadline).foregroundStyle(.secondary)};Spacer();Image(systemName:"arrow.up.right")}.padding(20).background(qC.opacity(0.1),in:RoundedRectangle(cornerRadius:20))}.buttonStyle(.plain).disabled(k.p.round != nil || k.p.daily[d4()] != nil).accessibilityIdentifier("daily")
    VStack(alignment:.leading,spacing:16){Text(v3("season")).font(.title2.bold());Text(v3("season_detail")).foregroundStyle(.secondary);ForEach(0..<4){i in HStack{Text(String(format:v3("chapter"),i+1)).bold();Spacer();let score=k.p.chapters[k.seasonKeys[i]];if let score{Text("\(score) / 1000").foregroundStyle(qC)};Button(v3(score==nil ? "play":"replay")){k.z6k(-1,mode:"season",chapter:i)}.buttonStyle(.bordered).disabled(k.p.round != nil || (i>0 && (k.p.chapters[k.seasonKeys[i-1]] ?? 0)<600))}}
    }.padding(22).background(.white.opacity(0.045),in:RoundedRectangle(cornerRadius:22))
   }.padding(22).frame(maxWidth:1000).frame(maxWidth:.infinity)
  }.background(qN).toolbar(.hidden,for:.navigationBar)
 }
 func h3w(_ symbol:String,_ value:String,_ key:String)->some View {VStack(spacing:7){Image(systemName:symbol).foregroundStyle(qC);Text(value).font(.title2.bold()).monospacedDigit();Text(v3(key)).font(.caption2).foregroundStyle(.secondary).multilineTextAlignment(.center)}.frame(maxWidth:.infinity).padding(.vertical,18).background(.white.opacity(0.045),in:RoundedRectangle(cornerRadius:18))}
 var d8j:some View {
  GeometryReader{geo in ScrollView{let wide=geo.size.width>700
   VStack(alignment:.leading,spacing:24){Text(v3("duels_title")).font(.largeTitle.bold())
    if wide {HStack(alignment:.top,spacing:24){d3i.frame(maxWidth:.infinity);m6i.frame(maxWidth:.infinity)}}else{d3i;m6i}
   }.padding(24).frame(maxWidth:1100).frame(maxWidth:.infinity)
  }.background(qN)}.toolbar(.hidden,for:.navigationBar)
 }
 var d3i:some View {Duel10x2(ids:k.bank.map(\.id)){ids in guard k.p.round==nil else{open=true;return};k.startChallenge(ids)}}
 var m6i:some View {Rank11a6a(points:["★":k.p.history.filter{$0.total==10}.map(\.score).max() ?? 0],slips:k.p.history.compactMap{row in guard let ids=row.reviewIDs,let picks=row.reviewPicks else{return nil};return Seal11a6a.Slip(ids:ids,picks:picks,time:row.reviewTime ?? Array(repeating:0,count:picks.count),playedAt:row.date)},answers:Dictionary(k.bank.map{($0.id,$0.a)},uniquingKeysWith:{a,_ in a}))}
 var t6j:some View {ScrollView{VStack(alignment:.leading,spacing:24){Text(v3("weekly_title")).font(.largeTitle.bold());HStack{h3w("chart.bar.xaxis","\(k.p.week)","week_points");h3w("flame.fill","\(k.p.streak)","day_streak")};m6i;Text(v3("recent")).font(.title2.bold());if k.p.history.isEmpty{Text(v3("empty_history")).foregroundStyle(.secondary)};ForEach(k.p.history.prefix(25)){r in HStack{VStack(alignment:.leading){Text(v3(r.mode.hasPrefix("c") ? "cat"+String(r.mode.suffix(1)) : r.mode)).font(.headline);Text(r.date,style:.date).font(.caption).foregroundStyle(.secondary)};Spacer();Text("\(r.score) / \(r.total*100)").font(.headline).monospacedDigit()}.padding(.vertical,8)}}.padding(24).frame(maxWidth:850).frame(maxWidth:.infinity)}.background(qN).toolbar(.hidden,for:.navigationBar)}
 var s4j:some View {List{
  Section(v3("daily_reminders")){Text(v3("reminder_detail"));Text(v3("reminder_window")).font(.footnote).foregroundStyle(.secondary);Button(v3("enable_reminders")){Task{await k.u9p()}};Button(v3("system_settings")){UIApplication.shared.open(URL(string:UIApplication.openSettingsURLString)!)} }
  Section(v3("library")){Toggle(v3("auto_update"),isOn:$k.p.autoUpdates).onChange(of:k.p.autoUpdates){_,_ in k.n8v();N7v.p1s()};Text(v3("library_detail"));Button {Task{await k.w6c()}}label:{HStack{Text(v3("update"));if k.busy{ProgressView()}}}.disabled(k.busy);if k7()=="en"{Button(v3("play_web")){k.e5j()}.disabled(k.p.round != nil)};Text(v3("english_library")).font(.footnote);Link("Open Trivia DB · CC BY-SA 4.0",destination:URL(string:"https://opentdb.com")!);Link(v3("license"),destination:URL(string:"https://creativecommons.org/licenses/by-sa/4.0/")!)}
  Section(v3("accessibility")){Text(v3("timer_info"));Text(v3("language_info"))}
  Section(v3("privacy")){Text(v3("privacy_detail"));Text(v3("gc_privacy"));Text(v3("offline_detail"))}
  Section(v3("about")){Text("Sports Trivia · 1.2.2 (12)");Text(v3("free"))}
 }.navigationTitle(v3("more")).scrollContentBackground(.hidden).background(qN)}
}
struct O8b:ButtonStyle {func makeBody(configuration:Configuration)->some View{configuration.label.font(.headline).foregroundStyle(.white).frame(maxWidth:.infinity).padding(16).background(qB.opacity(configuration.isPressed ? 0.65:1),in:RoundedRectangle(cornerRadius:16))}}
struct J5a:View {
 @EnvironmentObject var k:K6m
 @State var now=Date();@State var exit=false;@State var submitting=false
 let ticker=Timer.publish(every:0.25,on:.main,in:.common).autoconnect()
 var body:some View {NavigationStack {Group{if let r=k.p.round {if r.done && !r.revealed {f8b(r)}else{q8b(r)}}}.background(qN).toolbar{ToolbarItem(placement:.topBarTrailing){Button(v3("close")){exit=true}}}.confirmationDialog(v3("leave_round"),isPresented:$exit,titleVisibility:.visible){Button(v3("save_exit")){k.n8v();dismiss()};Button(v3("cancel"),role:.cancel){}}}.onReceive(ticker){tick in if let r=k.p.round,!r.revealed,!r.done{now=tick;if tick>=r.deadline{k.a6c(-1)}}}}
 @Environment(\.dismiss) var dismiss

 @ViewBuilder
 private func roundScroll<Content: View>(@ViewBuilder content: (CGFloat) -> Content) -> some View {
  let regular = content(24)
  #if DEBUG && targetEnvironment(simulator)
  if ScreenshotScreen.current?.presentsRound == true {
   let compact = content(14)
   GeometryReader { viewport in
    // Leave the hint and later review cards in the scroll view on short cover displays.
    ScrollView { viewport.size.height < 700 ? compact : regular }
   }
  } else {
   ScrollView { regular }
  }
  #else
  ScrollView { regular }
  #endif
 }

 func q8b(_ r:R2k)->some View {
  let i=min(r.qs.count-1,r.answers.count-(r.revealed ? 1:0));let q=r.qs[i]
  let order=o4(r.id,q.id)
  return roundScroll { spacing in VStack(alignment:.leading,spacing:spacing){HStack{Text(String(format:v3("question_index"),i+1,r.qs.count)).font(.headline);Spacer();if !r.revealed {Label("\(max(0,Int(ceil(r.deadline.timeIntervalSince(now)))))",systemImage:"timer").font(.title3.bold()).monospacedDigit().foregroundStyle(qC).accessibilityLabel(v3("seconds_left")+" \(max(0,Int(r.deadline.timeIntervalSince(now))))")}};ProgressView(value:Double(i),total:Double(r.qs.count)).tint(qC);Text(v3("cat\(min(3,q.c))")).font(.caption.bold()).tracking(2).foregroundStyle(qC);Text(q.text).font(.system(.title,design:.rounded,weight:.bold)).fixedSize(horizontal:false,vertical:true).padding(.vertical,12)
   ForEach(Array(order.enumerated()),id:\.offset){idx,a in Button{k.a6c(a)}label:{HStack(spacing:16){Text(["A","B","C","D"][idx]).font(.headline).frame(width:34,height:34).background(.white.opacity(0.08),in:Circle());Text(q.choices[a]).font(.headline).multilineTextAlignment(.leading);Spacer();if r.revealed && a==q.a{Image(systemName:"checkmark.circle.fill").foregroundStyle(.green)}}.padding(18).frame(maxWidth:.infinity,alignment:.leading).background(r.revealed && a==q.a ? Color.green.opacity(0.18):Color.white.opacity(0.06),in:RoundedRectangle(cornerRadius:18)).overlay(RoundedRectangle(cornerRadius:18).stroke(r.revealed && r.answers.last==a && a != q.a ? Color.red:Color.clear,lineWidth:2))}.buttonStyle(.plain).disabled(r.revealed).accessibilityIdentifier("answer\(idx)")}
   if r.revealed{VStack(alignment:.leading,spacing:12){Text(v3(r.answers.last==q.a ? "correct":(r.answers.last == -1 ? "timeout":"not_quite"))).font(.title3.bold()).foregroundStyle(r.answers.last==q.a ? .green:qC);if r.answers.last != q.a{Text(v3("correct_answer")+" "+q.choices[q.a])};Button(v3(i+1==r.qs.count ? "see_result":"next")){k.n2q();now=Date()}.buttonStyle(O8b()).accessibilityIdentifier("nextQuestion")}}else{Text(v3("answer_hint")).font(.footnote).foregroundStyle(.secondary)}
  }.padding(24).frame(maxWidth:800).frame(maxWidth:.infinity)}.navigationBarTitleDisplayMode(.inline)
 }
 func f8b(_ r:R2k)->some View {roundScroll { spacing in VStack(alignment:.leading,spacing:spacing){Image(systemName:"checkmark.seal.fill").font(.system(size:68)).foregroundStyle(qC);Text(v3("round_complete")).font(.largeTitle.bold());Text("\(r.score)").font(.system(size:76,weight:.black,design:.rounded)).foregroundStyle(qC);Text(String(format:v3("result_detail"),r.score/100,r.qs.count)).font(.title3);Button(v3("back_home")){k.c1t(r.id)}.buttonStyle(O8b()).accessibilityIdentifier("backHome");Text(v3("review")).font(.title2.bold());ForEach(Array(r.qs.enumerated()),id:\.element.id){i,q in VStack(alignment:.leading,spacing:8){Text(q.text).bold();Label(q.choices[q.a],systemImage:r.answers[i]==q.a ? "checkmark.circle.fill":"xmark.circle").foregroundStyle(r.answers[i]==q.a ? .green:qC);if let url=URL(string:q.src){Link(v3("source"),destination:url).font(.caption)}}.frame(maxWidth:.infinity,alignment:.leading).padding(18).background(.white.opacity(0.05),in:RoundedRectangle(cornerRadius:16))}}.padding(26).frame(maxWidth:800).frame(maxWidth:.infinity)}.onAppear{k.f9s()}}
}

import CryptoKit
private enum Seal11a6a {
 struct Slip:Codable {let ids:[String];let picks:[Int];let time:[Int];var playedAt:Date?=nil}
 struct Card:Codable,Identifiable {let id:String;var points:[String:Int];var day:String?;var slip:Slip?;var signed:Bool?}
 struct Packet:Codable {let publicKey:Data;let content:Data;let signature:Data}
 static let prefix="SportsTrivia-2/"
 static func owner(_ pub:Data)->String {SHA256.hash(data:pub).map{String(format:"%02x",$0)}.joined()}
 static func pack(_ card:Card,key:Curve25519.Signing.PrivateKey)throws->String {
  let data=try JSONEncoder().encode(card)
  let authenticated=Data(prefix.utf8)+data
  let packet=Packet(publicKey:key.publicKey.rawRepresentation,content:data,signature:try key.signature(for:authenticated))
  return prefix+(try JSONEncoder().encode(packet)).base64EncodedString()
 }
 static func retaining(_ incoming:Card,in history:[Card])->[Card] {
  let normalized = incoming.id.lowercased()
  let others = history.filter { $0.id.lowercased() != normalized }
  let updated = others + [incoming]
  return Array(updated.filter { $0.signed == true }.suffix(80)) +
         Array(updated.filter { $0.signed != true }.suffix(40))
 }
 static func earlier(_ raw:String,allowed:Set<String>)->Card? {
  let older=String(prefix.dropLast(3))+"-1/"
  guard raw.hasPrefix(older),raw.utf8.count<=4000,let data=Data(base64Encoded:String(raw.dropFirst(older.count))),
    let item=try? JSONDecoder().decode(Card.self,from:data),UUID(uuidString:item.id) != nil,!item.points.isEmpty,
    item.points.keys.allSatisfy(allowed.contains),item.points.values.allSatisfy({(0...1000000000).contains($0)}) else{return nil}
  return Card(id:item.id,points:item.points,day:nil,slip:nil,signed:false)
 }
 static func unpack(_ raw:String)throws->Card {
  guard raw.hasPrefix(prefix),raw.utf8.count<=16384,let data=Data(base64Encoded:String(raw.dropFirst(prefix.count))) else{throw CocoaError(.fileReadCorruptFile)}
  let packet=try JSONDecoder().decode(Packet.self,from:data)
  let publicKey=try Curve25519.Signing.PublicKey(rawRepresentation:packet.publicKey)
  guard publicKey.isValidSignature(packet.signature,for:Data(prefix.utf8)+packet.content) else{throw CocoaError(.fileReadCorruptFile)}
  var item=try JSONDecoder().decode(Card.self,from:packet.content)
  guard item.id==owner(packet.publicKey) else{throw CocoaError(.fileReadCorruptFile)}
  item.signed=true;return item
 }
 static func thisWeek(_ playedAt:Date?,now:Date=Date())->Bool {
  guard let playedAt,playedAt<=now else{return false}
  var cal=Calendar(identifier:.iso8601);cal.timeZone=TimeZone(secondsFromGMT:0)!
  return cal.isDate(playedAt,equalTo:now,toGranularity:.weekOfYear)
 }
 static func total(_ slip:Slip?,answers:[String:Int])->Int? {
  guard let slip,slip.ids.count==10,Set(slip.ids).count==10,slip.picks.count==10,slip.time.count==10 else{return nil}
  var result=0
  for i in slip.ids.indices {
   guard let correct=answers[slip.ids[i]],(-1...3).contains(slip.picks[i]),(0...20).contains(slip.time[i]) else{return nil}
   if slip.picks[i]==correct {result+=100}
  };return result
 }
}
private struct Rank11a6a:View {
 typealias Card=Seal11a6a.Card
 let points:[String:Int]
 let slips:[Seal11a6a.Slip];let answers:[String:Int]
 @AppStorage("org.cobaltfield.triviaq82.scorecard.signer.v2") private var identity=Data()
 @AppStorage("org.cobaltfield.triviaq82.scorecard.cards") private var saved=Data()
 @Environment(\.locale) private var locale
 @State private var entry=""
 @State private var invalid=false
  private var words:[String]{let all:[String:[String]]=["en":["Scorecards","Share my scorecard","Paste a scorecard","Add scorecard","You","Invalid scorecard"],"pt":["Placares","Compartilhar placar","Cole um placar","Adicionar placar","Você","Placar inválido"],"de":["Ergebniskarten","Ergebnis teilen","Ergebniskarte einfügen","Ergebnis hinzufügen","Du","Ungültige Ergebniskarte"],"fr":["Feuilles de score","Partager mon score","Coller un score","Ajouter le score","Vous","Score non valide"],"es":["Tarjetas de puntuación","Compartir mi tarjeta","Pega una tarjeta","Añadir tarjeta","Tú","Tarjeta no válida"],"it":["Schede punteggio","Condividi il punteggio","Incolla una scheda","Aggiungi scheda","Tu","Scheda non valida"],"ru":["Карточки результатов","Поделиться результатом","Вставьте карточку","Добавить результат","Вы","Неверная карточка"]];return all[locale.language.languageCode?.identifier ?? "en"] ?? all["en"]!}
 private var captions:[String] {let a:[String:[String]]=["en":["Signed scorecard", "Earlier cards · unverified", "Play a ten-question round to share its answers.", "Score recalculated from ten answers."],"de":["Signierte Ergebniskarte", "Frühere Karten · ungeprüft", "Spiele eine Runde mit zehn Fragen, um die Antworten zu teilen.", "Punktzahl aus zehn Antworten berechnet."],"pt":["Placar assinado", "Placares anteriores · sem verificação", "Jogue uma rodada de dez perguntas para compartilhar as respostas.", "Pontuação recalculada com dez respostas."],"fr":["Carte de score signée", "Anciennes cartes · non vérifiées", "Jouez une manche de dix questions pour partager vos réponses.", "Score recalculé à partir de dix réponses."],"es":["Tarjeta de puntuación firmada", "Tarjetas anteriores · sin verificar", "Juega una ronda de diez preguntas para compartir las respuestas.", "Puntuación recalculada a partir de diez respuestas."],"it":["Scheda punteggio firmata", "Schede precedenti · non verificate", "Gioca un turno di dieci domande per condividere le risposte.", "Punteggio ricalcolato da dieci risposte."],"ru":["Подписанная карточка", "Старые карточки без проверки", "Сыграйте раунд из десяти вопросов, чтобы поделиться ответами.", "Очки пересчитаны по десяти ответам."]];return a[locale.language.languageCode?.identifier ?? "en"] ?? a["en"]!}
 private var cards:[Card]{(try? JSONDecoder().decode([Card].self,from:saved)) ?? []}
 @AppStorage("org.cobaltfield.triviaq82.scorecard.week") private var weeklyScores=Data()
 @State private var onlyWeek=true
 private var weekLabel: String {
  #if DEBUG && targetEnvironment(simulator)
  if ScreenshotScreen.current != nil { return "This week (UTC)" }
  #endif
  return String(localized:"This week (UTC)")
 }
 private var weekCards:[Card]{((try? JSONDecoder().decode([Card].self,from:weeklyScores)) ?? []).filter{Seal11a6a.thisWeek($0.slip?.playedAt)}}
 private var day:String {""}
 private var key:Curve25519.Signing.PrivateKey?{try? .init(rawRepresentation:identity)}
 private var mine:Card? {guard let key else{return nil};let best=slips.filter{!onlyWeek || Seal11a6a.thisWeek($0.playedAt)}.compactMap { slip in Seal11a6a.total(slip,answers:answers).map{($0,slip)} }.max{$0.0<$1.0}
 guard let best else{return nil};return Card(id:Seal11a6a.owner(key.publicKey.rawRepresentation),points:["★":best.0],day:nil,slip:best.1,signed:true)}
 private var shareText:String? {guard let key,let mine else{return nil};return try? Seal11a6a.pack(mine,key:key)}
 private func accept(){
  let raw=entry.trimmingCharacters(in:.whitespacesAndNewlines)
  if let legacy=Seal11a6a.earlier(raw,allowed:Set(points.keys)) {
   saved=(try? JSONEncoder().encode(Seal11a6a.retaining(legacy,in:cards))) ?? saved;invalid=false;entry="";return
  }
  guard let item=try? Seal11a6a.unpack(raw),item.id != mine?.id,item.id != key.map({Seal11a6a.owner($0.publicKey.rawRepresentation)}),!item.points.isEmpty,item.points.keys.allSatisfy({points[$0] != nil}),item.points.values.allSatisfy({(0...1000000000).contains($0)}) ,let score=Seal11a6a.total(item.slip,answers:answers),item.points==["★":score] else{invalid=true;return}
  if Seal11a6a.thisWeek(item.slip?.playedAt) {
   let list=weekCards
   if (list.first{$0.id==item.id}?.points["★"] ?? -1)<score {
    weeklyScores=(try? JSONEncoder().encode(Seal11a6a.retaining(item,in:list))) ?? weeklyScores
   }
  }
  var next=item
  if let old=cards.first(where:{$0.id==item.id && $0.signed==true}) {
   if (old.points["★"] ?? 0) > (item.points["★"] ?? 0) {next=old}
  }
  saved=(try? JSONEncoder().encode(Seal11a6a.retaining(next,in:cards))) ?? saved;invalid=false;entry=""
 }
 var body:some View {VStack(alignment:.leading,spacing:12){
  Label(words[0],systemImage:"person.2").font(.headline)
  Toggle(weekLabel,isOn:$onlyWeek).accessibilityIdentifier("scores-week")
  ForEach(points.keys.sorted(),id:\.self){category in
   Text(category).font(.caption.bold())
   let entries=([mine].compactMap{$0}+(onlyWeek ? weekCards:cards.filter{$0.signed==true})).filter{card in card.points[category] != nil && (category != "☀︎" || card.day==day)}
   ForEach(entries.sorted{let a=$0.points[category] ?? 0,b=$1.points[category] ?? 0;return a==b ? $0.id<$1.id:a>b}.prefix(10)){card in
    HStack{Text(card.id==mine?.id ? words[4]:String(card.id.prefix(8)));Spacer();Text(String(card.points[category] ?? 0)).monospacedDigit()}
   }
  }
  if let shareText {ShareLink(item:shareText){Label(words[1],systemImage:"square.and.arrow.up")};Text(captions[3]).font(.caption).foregroundStyle(.secondary)}
  else {Text(captions[2]).font(.caption).foregroundStyle(.secondary)}
  if cards.contains(where:{$0.signed != true}){DisclosureGroup(captions[1]){ForEach(cards.filter{$0.signed != true}){card in Text(String(card.id.prefix(8))+" · "+card.points.keys.sorted().map{$0+" "+String(card.points[$0] ?? 0)}.joined(separator:"  "))}}}
  TextField(words[2],text:$entry).textFieldStyle(.roundedBorder).autocorrectionDisabled().textInputAutocapitalization(.never)
  Button(words[3]){accept()}.disabled(entry.isEmpty)
  if invalid{Text(words[5]).foregroundStyle(.secondary).font(.caption)}
 }.onAppear{if key==nil{identity=Curve25519.Signing.PrivateKey().rawRepresentation}}}
}

