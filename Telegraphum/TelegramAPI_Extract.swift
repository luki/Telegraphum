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
  
  public enum Substitution {
    case ITU
  }
  
  //  enum errorCode: Int {
  //    case plaintext
  //    case substitution
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
  private var substitution: Substitution?
  
  public init() {
    plaintext = nil
    substitution = nil
  }
  
  // Get Methods
  
  public func getPlaintext() -> String? {
    return plaintext
  }
  
  public func getsubstitution() -> Substitution? {
    return substitution
  }
  
  // Set Methods
  
  public func setPlaintext(_ text: String) {
    plaintext = text
  }
  
  public func setSubstitution(_ mthd: Substitution) {
    substitution = mthd
  }
  
  public func translate() -> String? {
    
    if plaintext == nil { return nil }
    
    if substitution == nil { return nil } else {
      
      switch substitution! {
      case .ITU:
        return phraseToMorse(plaintext!, transcription: itu)
      }
      
    }
  }
  
}
