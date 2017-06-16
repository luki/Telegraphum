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
  
  // UI Elements
  let topBackground: UIView = {
    let tb = UIView()
    tb.falseAutoResizingMaskTranslation()
    tb.backgroundColor = .black
    return tb
  }()
  
  let sectionOneLabel: UILabel = {
    let label = UILabel()
    label.falseAutoResizingMaskTranslation()
    label.font = .systemFont(ofSize: 29/2, weight: UIFontWeightMedium)
    label.textColor = UIColor(red: 166/255.0, green: 166/255.0, blue: 166/255.0, alpha: 1)
    label.text = "Plaintext"
    return label
  }()
  
  let sectionOneText: UITextView = {
    let tv = UITextView()
    tv.falseAutoResizingMaskTranslation()
    tv.font = .systemFont(ofSize: 35/2, weight: UIFontWeightRegular)
    tv.textColor = UIColor(red: 217/255.0, green: 217/255.0, blue: 217/255.0, alpha: 1)
    tv.text = "This is some example text"
    tv.backgroundColor = .clear
    tv.textContainer.lineFragmentPadding = 0
    tv.textContainerInset = .zero
    return tv
  }()
  
  lazy var transcribeButton: UIButton = {
    let tb = UIButton()
    tb.falseAutoResizingMaskTranslation()
    tb.setTitle("Transcribe", for: .normal)
    tb.addTarget(self, action: #selector(transcribe), for: .touchUpInside)
    tb.tintColor = UIColor(red: 140/255, green: 60/255, blue: 85/250, alpha: 1.0)
    tb.titleLabel?.font = .systemFont(ofSize: 29/2, weight: UIFontWeightMedium)
    return tb
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.backgroundColor = UIColor(red: 14/255.0, green: 14/255.0, blue: 14/255.0, alpha: 1.0)
    
    addSubviews(to: view, views: topBackground)
    addSubviews(to: topBackground, views: sectionOneLabel, sectionOneText, transcribeButton)
    addConstraints(
    
      topBackground.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      topBackground.topAnchor.constraint(equalTo: view.topAnchor),
      topBackground.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      topBackground.heightAnchor.constraint(equalToConstant: view.frame.height*0.372),
      
      sectionOneLabel.topAnchor.constraint(equalTo: topBackground.topAnchor, constant: 128/2),
      sectionOneLabel.leadingAnchor.constraint(equalTo: topBackground.leadingAnchor, constant: 88/2),
      sectionOneLabel.trailingAnchor.constraint(equalTo: topBackground.trailingAnchor, constant: -88/2),
      sectionOneLabel.heightAnchor.constraint(equalToConstant: 29/2),
      
      sectionOneText.leadingAnchor.constraint(equalTo: topBackground.leadingAnchor, constant: 88/2),
      sectionOneText.trailingAnchor.constraint(equalTo: topBackground.trailingAnchor, constant: -88/2),
      sectionOneText.topAnchor.constraint(equalTo: sectionOneLabel.bottomAnchor, constant: 40/2),
      sectionOneText.heightAnchor.constraint(equalToConstant: 128/2),
      
      transcribeButton.trailingAnchor.constraint(equalTo: topBackground.trailingAnchor, constant: -88/2),
      transcribeButton.topAnchor.constraint(equalTo: sectionOneText.bottomAnchor, constant: 72/2)
      
    )
  }
  
  // Actions / Targets
  
  func transcribe() {
    if sectionOneText.text != "This is some example text" {
      telegram.setPlaintext(sectionOneText.text)
      telegram.setMorseMethod(.ITU)
      
      print(telegram.translate()!)
      
    } else {
      print("Can't do it, Sherlock!")
    }
  }
  
  // Helpers
  func addSubviews(to parent: UIView, views: UIView...) {
    views.forEach { parent.addSubview($0) }
  }
  
  func addConstraints(_ consts: NSLayoutConstraint...) {
    NSLayoutConstraint.activate(consts)
  }
  
}

extension UIView {
  func falseAutoResizingMaskTranslation() {
    self.translatesAutoresizingMaskIntoConstraints = false
  }
}
