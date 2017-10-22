public class Telegram {
  
  func reverseCollection(_ col: [(String, String)]) -> [(String, String)] {
    return col.map { ($0.1, $0.0) }
  }
  
  // MARK: Basic Implementations
  
  let itu: [(key: String, value: String)] = [
    ("name", "ITU"),
    ("A", ".-"),
    ("B", "-..."),
    ("C", "-.-."),
    ("D", "-.."),
    ("E", "."),
    ("F", "..-."),
    ("G", "--."),
    ("H", "...."),
    ("I", ".."),
    ("J", ".---"),
    ("K", "-.-"),
    ("L", ".-.."),
    ("M", "--"),
    ("N", "-."),
    ("O", "---"),
    ("P", ".--."),
    ("Q", "--.-"),
    ("R", ".-."),
    ("S", "..."),
    ("T", "-"),
    ("U", "..-"),
    ("V", "...-"),
    ("W", ".--"),
    ("X", "-..-"),
    ("Y", "-.--"),
    ("Z", "--.."),
    (" ", "/"),
    ]
  
  public enum Substitution {
    case ITU
  }
  
  public enum Method {
    case ToMorse
    case ToPhrase
  }
  
  //  enum errorCode: Int {
  //    case plaintext
  //    case substitution
  //  }
  
  private func charToMorseChunk(_ char: String, transcription: [(String, String)]) -> String {
    
    for x in transcription {
      switch x.0 {
      case char:
        return x.1
      default:
        continue
      }
      
    }
    return ""
  }
  
  private func morseChunkToChar(_ char: String, transcription: [(String, String)]) -> String {
    print(char)
    for x in transcription {
      switch x.1 {
      case char:
        return x.0
      default:
        continue
      }
      
    }
    return ""
  }
  
  private func morseToPhrase(_ morse: String, transcription: [(String, String)]) -> String {
    return morse.split(separator: " ").map { morseChunkToChar(String($0), transcription: itu) }.joined()
  }
  
  private func phraseToMorse(_ phr: String, transcription: [(String, String)]) -> String {
    return phr.characters.map { charToMorseChunk(String($0).uppercased(), transcription: itu) }.joined(separator: " ")
  }
  
  // MARK: Application Setup
  
  private var plaintext: String?
  private var method: Telegram.Method?
  private var substitution: Substitution?
  
  public init() {
    plaintext = nil
    substitution = nil
    method = nil
  }
  
  // Get Methods
  
  public func getPlaintext() -> String? {
    return plaintext
  }
  
  public func getSubstitution() -> Substitution? {
    return substitution
  }
  
  public func getMethod() -> Telegram.Method? {
    return method
  }
  
  // Set Methods
  
  public func setPlaintext(_ text: String) {
    self.plaintext = text
  }
  
  public func setSubstitution(_ subs: Substitution) {
    substitution = subs
  }
  
  public func setMethod(_ method: Telegram.Method) {
    self.method = method
  }
  
  public func translate() -> String? {
    if method == nil { return nil }
    if plaintext == nil { return nil }
    
    if substitution == nil { return nil } else {
      
      switch method! {
      case .ToMorse:
        switch substitution! {
        case .ITU:
          return phraseToMorse(plaintext!, transcription: itu)
        }
      case .ToPhrase:
        switch substitution! {
        case .ITU:
          return morseToPhrase(plaintext!, transcription: itu)
        }
      }
      
    }
  }
  
}
