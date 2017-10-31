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
        case itu
    }

    public enum Method {
        case toMorse
        case toPhrase
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

    private func morseToPhrase(_ morse: String, transcription _: [(String, String)]) -> String {
        return morse
            .split(separator: " ")
            .map { morseChunkToChar(String($0), transcription: itu) }
            .joined()
    }

    private func phraseToMorse(_ phr: String, transcription _: [(String, String)]) -> String {
        return phr.characters.map { charToMorseChunk(String($0).uppercased(), transcription: itu) }.joined(separator: " ")
    }

    // MARK: Application Setup

    var method: Telegram.Method
    var substitution: Substitution

    public init(method: Telegram.Method, substitution: Substitution) {
        self.method = method
        self.substitution = substitution
    }

    public func translate(text: String) -> String? {
        switch (method, substitution) {
        case (.toMorse, .itu):
            return phraseToMorse(text, transcription: itu)
        case (.toPhrase, .itu):
            return morseToPhrase(text, transcription: itu)
        }
    }
}
