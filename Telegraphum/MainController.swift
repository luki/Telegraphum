//
//  ViewController.swift
//  Telegraphum
//
//  Created by L on 16/06/2017.
//  Copyright © 2017 Lukas Mueller. All rights reserved.
//

import UIKit
import AudioToolbox
import AVFoundation

class MainController: UIViewController {
  
  let telegram = Telegram()
  var player = AVQueuePlayer()

  // UI Elements
  
  // Upper
  let topBackground: UIView = {
    let tb = UIView()
    tb.falseAutoResizingMaskTranslation()
    tb.backgroundColor = .black
    return tb
  }()
  
  let sectionOneLabel: UILabel = {
    let label = UILabel()
    label.falseAutoResizingMaskTranslation()
    label.font = UIFont(name: "Okomito-Medium", size: 29/2)
    label.textColor = UIColor(red: 166/255.0, green: 166/255.0, blue: 166/255.0, alpha: 1)
    label.text = "Plaintext"
    return label
  }()
  
  let sectionOneText: UITextView = {
    let tv = UITextView()
    tv.falseAutoResizingMaskTranslation()
    tv.font = UIFont(name: "Okomito-Regular", size: 35/2)
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
    tb.setTitleColor(UIColor(red: 85/255, green: 215/255, blue: 130/250, alpha: 1.0), for: .normal)
    tb.setTitleColor(.black, for: .highlighted)
    tb.titleLabel?.font = UIFont(name: "Okomito-Medium", size: 29/2)
    return tb
  }()
  
  // Lower half
  
  let lowerHalfArea: UIView = {
    let v = UIView()
    v.falseAutoResizingMaskTranslation()
    v.backgroundColor = .clear
    return v
  }()
  
  let lowerHalfView: UIView = {
    let v = UIView()
    v.falseAutoResizingMaskTranslation()
    v.backgroundColor = .clear
    return v
  }()
  
  let sectionTwoLabel: UILabel = {
    let label = UILabel()
    label.falseAutoResizingMaskTranslation()
    label.font = UIFont(name: "Okomito-Medium", size: 29/2)
    label.textColor = UIColor(red: 166/255.0, green: 166/255.0, blue: 166/255.0, alpha: 1)
    label.text = "Code"
    return label
  }()
  
  let sectionTwoText: UITextView = {
    let tv = UITextView()
    tv.falseAutoResizingMaskTranslation()
    tv.font = UIFont(name: "Okomito-Regular", size: 35/2)
    tv.textColor = UIColor(red: 102/255.0, green: 102/255.0, blue: 102/255.0, alpha: 1)
    tv.backgroundColor = .clear
    tv.textContainer.lineFragmentPadding = 0
    tv.textContainerInset = .zero
    tv.isEditable = false
    tv.text = "XYZ"
    return tv
  }()
  
  var playButton: UIButton = {
    let tb = UIButton()
    tb.falseAutoResizingMaskTranslation()
    tb.contentMode = .scaleAspectFit
    tb.setImage(UIImage(named: "play"), for: .normal)
//    tb.setTitle("Play", for: .normal)
    tb.addTarget(self, action: #selector(play), for: .touchUpInside)
    tb.setTitleColor(UIColor(red: 85/255, green: 215/255, blue: 130/250, alpha: 1.0), for: .normal)
    tb.setTitleColor(.black, for: .highlighted)
    tb.setTitleColor(.darkGray, for: .disabled)
    tb.titleLabel?.font = UIFont(name: "Okomito-Medium", size: 29/2)
    return tb
    }() {
    didSet {
      if playButton.isEnabled { playButton.titleColor(for: .normal) }
    }
  }
  
  var flashButton: UIButton = {
    let tb = UIButton()
    tb.falseAutoResizingMaskTranslation()
    tb.contentMode = .scaleAspectFit
    tb.setImage(UIImage(named: "flashlight"), for: .normal)
    //    tb.setTitle("Play", for: .normal)
    tb.addTarget(self, action: #selector(flashLightAction), for: .touchUpInside)
    tb.setTitleColor(UIColor(red: 85/255, green: 215/255, blue: 130/250, alpha: 1.0), for: .normal)
    tb.setTitleColor(.black, for: .highlighted)
    tb.setTitleColor(.darkGray, for: .disabled)
    tb.titleLabel?.font = UIFont(name: "Okomito-Medium", size: 29/2)
    return tb
    }()
  
  var copyButton: UIButton = {
    let tb = UIButton()
    tb.falseAutoResizingMaskTranslation()
    tb.contentMode = .scaleAspectFit
    tb.setImage(UIImage(named: "clipboard"), for: .normal)
    //    tb.setTitle("Play", for: .normal)
    tb.addTarget(self, action: #selector(copyText), for: .touchUpInside)
    tb.setTitleColor(UIColor(red: 85/255, green: 215/255, blue: 130/250, alpha: 1.0), for: .normal)
    tb.setTitleColor(.black, for: .highlighted)
    tb.setTitleColor(.darkGray, for: .disabled)
    tb.titleLabel?.font = UIFont(name: "Okomito-Medium", size: 29/2)
    return tb
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.backgroundColor = UIColor(red: 14/255.0, green: 14/255.0, blue: 14/255.0, alpha: 1.0)
    
    addSubviews(to: view, views: topBackground, lowerHalfArea)
    addSubviews(to: topBackground, views: sectionOneLabel, sectionOneText, transcribeButton)
    addSubviews(to: lowerHalfView, views: sectionTwoLabel, sectionTwoText, playButton, flashButton, copyButton)
    addSubviews(to: lowerHalfArea, views: lowerHalfView)
    addConstraints(
    
      topBackground.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      topBackground.topAnchor.constraint(equalTo: view.topAnchor),
      topBackground.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      topBackground.heightAnchor.constraint(equalToConstant: view.frame.height*0.372),
      
      sectionOneLabel.topAnchor.constraint(equalTo: topBackground.topAnchor, constant: 128/2 - 3),
      sectionOneLabel.leadingAnchor.constraint(equalTo: topBackground.leadingAnchor, constant: 42.8),
      sectionOneLabel.trailingAnchor.constraint(equalTo: topBackground.trailingAnchor, constant: -42.8),
      sectionOneLabel.heightAnchor.constraint(equalToConstant: 29/2),
      
      sectionOneText.leadingAnchor.constraint(equalTo: topBackground.leadingAnchor, constant: 42.8),
      sectionOneText.trailingAnchor.constraint(equalTo: topBackground.trailingAnchor, constant: -42.8),
      sectionOneText.topAnchor.constraint(equalTo: sectionOneLabel.bottomAnchor, constant: 18.5),
      sectionOneText.heightAnchor.constraint(equalToConstant: 128/2),
      
      transcribeButton.trailingAnchor.constraint(equalTo: topBackground.trailingAnchor, constant: -42.8),
      transcribeButton.topAnchor.constraint(equalTo: sectionOneText.bottomAnchor, constant: 25), //36
      
      lowerHalfArea.topAnchor.constraint(equalTo: topBackground.bottomAnchor),
      lowerHalfArea.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      lowerHalfArea.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      lowerHalfArea.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      
      lowerHalfView.centerYAnchor.constraint(equalTo: lowerHalfArea.centerYAnchor),
      lowerHalfView.leadingAnchor.constraint(equalTo: lowerHalfArea.leadingAnchor, constant: 42.5),
      lowerHalfView.trailingAnchor.constraint(equalTo: lowerHalfArea.trailingAnchor, constant: -42.5),
      lowerHalfView.heightAnchor.constraint(equalToConstant: 240),
      
      sectionTwoLabel.leadingAnchor.constraint(equalTo: lowerHalfView.leadingAnchor),
      sectionTwoLabel.topAnchor.constraint(equalTo: lowerHalfView.topAnchor),
      
      sectionTwoText.leadingAnchor.constraint(equalTo: lowerHalfView.leadingAnchor),
      sectionTwoText.topAnchor.constraint(equalTo: sectionTwoLabel.bottomAnchor, constant: 40/2),
      sectionTwoText.trailingAnchor.constraint(equalTo: lowerHalfView.trailingAnchor),
      sectionTwoText.heightAnchor.constraint(equalToConstant: 256/2),
      
      playButton.trailingAnchor.constraint(equalTo: lowerHalfView.trailingAnchor),
      playButton.topAnchor.constraint(equalTo: sectionTwoText.bottomAnchor, constant: 72/2),
      playButton.heightAnchor.constraint(equalToConstant: 20),
      playButton.widthAnchor.constraint(equalToConstant: 20.5),
      
      flashButton.trailingAnchor.constraint(equalTo: playButton.leadingAnchor, constant: -12.5),
      flashButton.centerYAnchor.constraint(equalTo: playButton.centerYAnchor),
      flashButton.heightAnchor.constraint(equalToConstant: 20),
      flashButton.widthAnchor.constraint(equalToConstant: 12.5),
      
      copyButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 42.8),
      copyButton.centerYAnchor.constraint(equalTo: flashButton.centerYAnchor),
      copyButton.heightAnchor.constraint(equalToConstant: 22.5),
      copyButton.widthAnchor.constraint(equalToConstant: 20.5)
    )
    hideLower()
  }
  
  override var preferredStatusBarStyle: UIStatusBarStyle {
    return .lightContent
  }
  
  // Actions / Targets
  
  func transcribe() {
    
    if lowerHalfView.isHidden {
      lowerHalfView.isHidden = false
    }
    
    telegram.setPlaintext(sectionOneText.text)
    telegram.setMorseMethod(.ITU)
    sectionTwoText.text = telegram.translate()!
//    flashLight(withInterval: 40)
  }
  
  func play(_ sender: UIButton) {
    playMorse(sectionTwoText.text)
    playButton.isEnabled = false
    player.play()
  }
  
  // App Helpers: Play
  
  func playMorse(_ code: String) {
    for char in code.characters {
      switch String(char) {
      case "-":
        playSound(fileName: "long", ext: "wav")
      case ".":
        playSound(fileName: "short", ext: "wav")
      case " ":
        playSound(fileName: "break", ext: "wav")
      default:
        print("Eh?")
      }
    }
    playButton.isEnabled = true
  }
  
  func copyText() {
    UIPasteboard.general.string = sectionTwoText.text
  }
  
  func playSound(fileName name: String, ext: String) {
    player.insert(AVPlayerItem(url: Bundle.main.url(forResource: name, withExtension: ext)!), after: player.items().last)
  }
  
  func flashLightAction() {
    sectionTwoText.text.characters.forEach {
      switch String($0) {
      case "-":
        flashLight(withInterval: 1)
      case ".":
        flashLight(withInterval: 0.5)
      case " ":
        _ = Timer.scheduledTimer(withTimeInterval: 0.6, repeats: false) { _ in
          
        }
      default:
        print("Eh?")
      }
    }
  }
  
  func flashLight(withInterval int: Double) {
    _ = Timer.scheduledTimer(withTimeInterval: int, repeats: false) {
      (_) in
      self.useFlashLight()
    }
    // Turns Off
    useFlashLight()
  }
  
  func useFlashLight() {
    if let device = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo), device.hasTorch {
      do {
        try device.lockForConfiguration()
        let torchOn = device.isTorchActive
        try device.setTorchModeOnWithLevel(1.0)
        device.torchMode = torchOn ? .off : .on
      } catch {
        print("Hello")
      }
    }
  }
  
  // Hide lower section
  
  func hideLower() {
    lowerHalfView.isHidden = true
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
