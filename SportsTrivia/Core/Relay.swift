import SwiftUI

struct Duel10x2:View {
 let ids:[String];let play:([String])->Void
 @Environment(\.locale) private var locale
 @State private var code: String

 init(ids: [String], play: @escaping ([String]) -> Void) {
  self.ids = ids
  self.play = play
  #if DEBUG && targetEnvironment(simulator)
  if ScreenshotScreen.current?.tab == 1 {
   _code = State(initialValue: ScreenshotScreen.challengeCode)
   return
  }
  #endif
  _code = State(initialValue: "SportsTrivia-" + String(UUID().uuidString.prefix(8)))
 }
 private var words:[String] {let all:[String:[String]]=["en":["Challenge code","Play this challenge","Share challenge"],"de":["Duellcode","Dieses Duell spielen","Duell teilen"],"es":["Código de duelo","Jugar este duelo","Compartir duelo"],"fr":["Code du défi","Jouer ce défi","Partager le défi"],"pt":["Código do duelo","Jogar este duelo","Compartilhar duelo"],"it":["Codice sfida","Gioca la sfida","Condividi sfida"],"ro":["Codul duelului","Joacă acest duel","Distribuie duelul"],"ru":["Код дуэли","Начать дуэль","Поделиться дуэлью"],"hu":["Kihíváskód","Kihívás indítása","Kihívás megosztása"]];return all[locale.language.languageCode?.identifier ?? "en"] ?? all["en"]!}
 private var seed: String? { Self.normalizedCode(code) }
 private static func normalizedCode(_ code:String)->String?{let s=code.trimmingCharacters(in:.whitespacesAndNewlines);guard s.hasPrefix("SportsTrivia-"),s.count=="SportsTrivia-".count+8,s.suffix(8).allSatisfy({$0.isHexDigit}) else{return nil};return s.uppercased()}
 static func questionIDs(for code: String, in ids: [String]) -> [String] {
  guard let seed = normalizedCode(code) else { return [] }
  func order(_ id: String) -> UInt64 {
   (seed + "|" + id).utf8.reduce(UInt64(14695981039346656037)) { hash, byte in
    (hash ^ UInt64(byte)) &* 1099511628211
   }
  }
  let sorted = Set(ids).sorted {
   let a = order($0), b = order($1)
   return a == b ? $0 < $1 : a < b
  }
  return Array(sorted.prefix(10))
 }
 var body:some View {VStack(alignment:.leading,spacing:14){
  TextField(words[0],text:$code).textFieldStyle(.roundedBorder).autocorrectionDisabled().textInputAutocapitalization(.never)
  ShareLink(item:code.trimmingCharacters(in:.whitespacesAndNewlines)){Label(words[2],systemImage:"square.and.arrow.up")}.disabled(seed==nil)
  Button(words[1]) {
   let questions = Self.questionIDs(for: code, in: ids)
   guard questions.count == 10 else { return }
   play(questions)
  }.buttonStyle(.borderedProminent).disabled(seed==nil || Set(ids).count<10)
 }}
}
