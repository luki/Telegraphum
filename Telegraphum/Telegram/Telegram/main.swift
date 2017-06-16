//
//  main.swift
//  Telegram
//
//  Created by L on 16/06/2017.
//  Copyright © 2017 Lukas Mueller. All rights reserved.
//

import Foundation

public class Telegram {
  
  // MARK: Basic Implementations
  
  let itu = [
    "name":"ITU",
    "A":".-",
    "B":"-...",
    "C":"-.-.",
    "D":"-..",
    "E":".",
    "F":"..-.",
    "G":"--.",
    "H":"....",
    "I":"..",
    "J":".---",
    "K":"-.-",
    "L":".-..",
    "M":"--",
    "N":"-.",
    "O":"---",
    "P":".--.",
    "Q":"--.-",
    "R":".-.",
    "S":"...",
    "T":"-",
    "U":"..-",
    "V":"...-",
    "W":".--",
    "X":"-..-",
    "Y":"-.--",
    "Z":"--..",
    ]
  
  public enum MorseMethod {
    case ITU
  }
  
  //  enum errorCode: Int {
  //    case plaintext
  //    case morseMethod
  //  }
  
  private func charToMorseChunk(_ char: String, transcription: [String:String]) -> String {
    switch transcription[char] {
    case .some(let chunk):
      return chunk
    case .none:
      return ""
    }
  }
  
  private func phraseToMorse(_ phr: String, transcription: [String:String]) -> String {
    return phr.characters.map {
      charToMorseChunk(String($0).uppercased(), transcription: transcription)
      }.joined(separator: " ")
  }
  
  // MARK: Application Setup
  
  private var plaintext: String?
  private var morseMethod: MorseMethod?
  
  public init() {
    plaintext = nil
    morseMethod = nil
  }
  
  // Get Methods
  
  public func getPlaintext() -> String? {
    return plaintext
  }
  
  public func getMorseMethod() -> MorseMethod? {
    return morseMethod
  }
  
  // Set Methods
  
  public func setPlaintext(_ text: String) {
    plaintext = text
  }
  
  public func setMorseMethod(_ mthd: MorseMethod) {
    morseMethod = mthd
  }
  
  public func translate() -> String? {
    
    if plaintext == nil { return nil }
    
    if morseMethod == nil { return nil } else {
      
      switch morseMethod! {
      case .ITU:
        return phraseToMorse(plaintext!, transcription: itu)
      }
      
    }
  }
  
}
