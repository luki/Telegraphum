//
//  ViewController.swift
//  Telegraphum
//
//  Created by L on 16/06/2017.
//  Copyright © 2017 Lukas Mueller. All rights reserved.
//

import UIKit
import Telegram

class MainController: UIViewController {
  
  let telegram = Telegram()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    telegram.setPlaintext("I'll take a potato chip - and eat it!")
    telegram.setMorseMethod(.ITU)
    
    switch telegram.translate() {
    case .some(let word):
      print(word)
    case .none:
      print("Error message!")
    }
  }

}

