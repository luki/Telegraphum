//
//  ViewController.swift
//  Telegraphum
//
//  Created by L on 16/06/42.817.
//  Copyright © 42.817 Lukas Mueller. All rights reserved.
//

import UIKit
import AudioToolbox
import AVFoundation

class MainController: UIViewController {
  
  let telegram = Telegram()
  var player = AVQueuePlayer()
  
  let substitutions = ["International", "Continental"]

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
  
  lazy var sectionOneText: UITextView = {
    let tv = UITextView()
    tv.falseAutoResizingMaskTranslation()
    tv.font = UIFont(name: "Okomito-Regular", size: 35/2)
    tv.textColor = UIColor(red: 217/255.0, green: 217/255.0, blue: 217/255.0, alpha: 1)
    tv.text = "This is some example text"
    tv.backgroundColor = .clear
    tv.textContainer.lineFragmentPadding = 0
    tv.textContainerInset = .zero
    tv.delegate = self
    tv.keyboardType = .asciiCapable
    tv.keyboardAppearance = .dark
    return tv
  }()
  
//  lazy var transcribeButton: UIButton = {
//    let tb = UIButton()
//    tb.falseAutoResizingMaskTranslation()
//    tb.setTitle("Transcribe", for: .normal)
//    tb.addTarget(self, action: #selector(transcribe), for: .touchUpInside)
//    tb.setTitleColor(UIColor(red: 85/255, green: 215/255, blue: 130/250, alpha: 1.0), for: .normal)
//    tb.setTitleColor(.black, for: .highlighted)
//    tb.titleLabel?.font = UIFont(name: "Okomito-Medium", size: 29/2)
//    return tb
//  }()
  
  lazy var selectionButton: UIButton = {
    let tb = UIButton()
    tb.falseAutoResizingMaskTranslation()
    tb.setTitle("Select Method", for: .normal)
    tb.addTarget(self, action: #selector(selectionAction), for: .touchUpInside)
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
    }()
  
  var flashButton: UIButton = {
    let tb = UIButton()
    tb.falseAutoResizingMaskTranslation()
    tb.contentMode = .scaleAspectFit
    tb.setImage(UIImage(named: "flashlight"), for: .normal)
    //    tb.setTitle("Play", for: .normal)
    tb.addTarget(self, action: #selector(flashlightAction), for: .touchUpInside)
    tb.setTitleColor(UIColor(red: 85/255, green: 215/255, blue: 130/250, alpha: 1.0), for: .normal)
    tb.setTitleColor(.black, for: .highlighted)
    tb.setTitleColor(.darkGray, for: .disabled)
    tb.titleLabel?.font = UIFont(name: "Okomito-Medium", size: 29/2)
    return tb
    }()
  
  let copyButton: UIButton = {
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
  
//  let selectionButton: SelectionButton = {
//    let sb = SelectionButton()
//    sb.sectionOneLabel.text = "Select Substitution"
//    sb.falseAutoResizingMaskTranslation()
//    let gr = UITapGestureRecognizer(target: sb, action: #selector(selectionAction))
//    sb.addGestureRecognizer(gr)
//    return sb
//  }()
  
  lazy var selectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.itemSize = CGSize(width: 467/2, height: 52/2)
    layout.minimumLineSpacing = 0
    let cv = UICollectionView(frame: CGRect(x: 0, y: 0, width: 467/2, height: 188/2), collectionViewLayout: layout)
    cv.falseAutoResizingMaskTranslation()
    cv.backgroundColor = UIColor(red: 23/255.0, green: 23/255.0, blue: 23/255.0, alpha: 1.0)
    //    cv.isScrollEnabled = false
    cv.layer.cornerRadius = 1.5
    cv.clipsToBounds = true
    cv.dataSource = self
    cv.contentInset = UIEdgeInsets(top: 4, left: 0, bottom: -4, right: 0)
    cv.register(SelectionCell.self, forCellWithReuseIdentifier: "cell")
    return cv
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = UIColor(red: 14/255.0, green: 14/255.0, blue: 14/255.0, alpha: 1.0)
    
    addSubviews(to: view, views: topBackground, lowerHalfArea)
    addSubviews(to: topBackground, views: sectionOneLabel, sectionOneText, /*transcribeButton,*/ selectionButton)
    addSubviews(to: lowerHalfArea, views: sectionTwoLabel, sectionTwoText, playButton, flashButton, copyButton)
    addConstraints(
      
      topBackground.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.45),
      topBackground.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      topBackground.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      topBackground.topAnchor.constraint(equalTo: view.topAnchor),
      
      sectionOneText.leadingAnchor.constraint(equalTo: topBackground.leadingAnchor, constant: 42.8),
      sectionOneText.trailingAnchor.constraint(equalTo: topBackground.trailingAnchor, constant: -42.8),
      sectionOneText.centerYAnchor.constraint(equalTo: topBackground.centerYAnchor),
      sectionOneLabel.leadingAnchor.constraint(equalTo: topBackground.leadingAnchor, constant: 42.8),
      sectionOneText.heightAnchor.constraint(equalToConstant: 128/2),
      sectionOneLabel.trailingAnchor.constraint(equalTo: topBackground.trailingAnchor, constant: -42.8),
      sectionOneLabel.bottomAnchor.constraint(equalTo: sectionOneText.topAnchor, constant: -8),
      
//      transcribeButton.trailingAnchor.constraint(equalTo: topBackground.trailingAnchor, constant: -42.8),
//      transcribeButton.topAnchor.constraint(equalTo: sectionOneText.bottomAnchor, constant: 5),
      
      selectionButton.leadingAnchor.constraint(equalTo: topBackground.leadingAnchor, constant: 42.8),
      selectionButton.topAnchor.constraint(equalTo: sectionOneText.bottomAnchor, constant: 5),
      
      
      lowerHalfArea.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      lowerHalfArea.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      lowerHalfArea.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      lowerHalfArea.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.55),
      
      sectionTwoText.centerYAnchor.constraint(equalTo: lowerHalfArea.centerYAnchor),
      sectionTwoText.leadingAnchor.constraint(equalTo: lowerHalfArea.leadingAnchor, constant: 42.8),
      sectionTwoText.trailingAnchor.constraint(equalTo: lowerHalfArea.trailingAnchor, constant: -42.8),
      sectionTwoText.heightAnchor.constraint(equalToConstant: 152/2),
      sectionTwoLabel.bottomAnchor.constraint(equalTo: sectionTwoText.topAnchor, constant: -8),
      sectionTwoLabel.leadingAnchor.constraint(equalTo: lowerHalfArea.leadingAnchor, constant: 42.8),
      sectionTwoLabel.trailingAnchor.constraint(equalTo: lowerHalfArea.trailingAnchor, constant: -42.8),
      
      playButton.topAnchor.constraint(equalTo: sectionTwoText.bottomAnchor, constant: 72/2),
      playButton.heightAnchor.constraint(equalToConstant: 20),
      playButton.widthAnchor.constraint(equalToConstant: 20.5),
      playButton.trailingAnchor.constraint(equalTo: lowerHalfArea.trailingAnchor, constant: -42.8),
      
      flashButton.trailingAnchor.constraint(equalTo: playButton.leadingAnchor, constant: -12.5),
      flashButton.centerYAnchor.constraint(equalTo: playButton.centerYAnchor),
      flashButton.heightAnchor.constraint(equalToConstant: 20),
      flashButton.widthAnchor.constraint(equalToConstant: 12.5),
      
      copyButton.leadingAnchor.constraint(equalTo: lowerHalfArea.leadingAnchor, constant: 42.8),
      copyButton.centerYAnchor.constraint(equalTo: flashButton.centerYAnchor),
      copyButton.heightAnchor.constraint(equalToConstant: 22.5),
      copyButton.widthAnchor.constraint(equalToConstant: 20.5)
      
    )
    hideLower()
  }
  
  override var preferredStatusBarStyle: UIStatusBarStyle {
    return .lightContent
  }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    self.view.endEditing(true)
  }
  
  // Actions / Targets
  
  func selectionAction() {
    transcribeMethodAlert()
  }
  
  func transcribe() {
    telegram.setPlaintext(sectionOneText.text)
    telegram.setSubstitution(.ITU)
    
    switch telegram.getMethod() {
      case .some(let method):
        switch method {
          case .ToPhrase:
            presentLowerInState(isToMorse: false)
          case .ToMorse:
            presentLowerInState(isToMorse: true)
      }
      if let translationText = telegram.translate() {
        sectionTwoText.text = translationText
      }
      
      case.none:
        transcribeMethodAlert()
    }
    
    switch telegram.getMethod() {
      case .some(let method):
        if lowerHalfArea.isHidden {
          lowerHalfArea.isHidden = false
          switch method {
            case .ToPhrase:
              presentLowerInState(isToMorse: false)
            default:
              presentLowerInState(isToMorse: true)
          }
        }
        sectionTwoText.text = telegram.translate()!
//        sectionOneText.endEditing(true)
      
      case .none:
        transcribeMethodAlert()
        print("None!")
    }
//    flashLight(withInterval: 40)
  }
  
  func play(_ sender: UIButton) {
    if player.items().count == 0 {
      sender.isEnabled = false
      playMorse(sectionTwoText.text)
      player.play()
    } else {
      player.pause()
      player.removeAllItems()
    }
  }
  
  // App Helpers: Play
  
  func playMorse(_ code: String) {
    for char in code.characters {
      switch String(char) {
      case "-":
        playSound(fileName: "long", ext: "wav")
      case ".":
        playSound(fileName: "short", ext: "wav")
      case "/":
        playSound(fileName: "break", ext: "wav")
      default:
        print(char)
        print("Unknown file.")
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
  
  func flashlightAction() {
    if let text = sectionTwoText.text {
      let intervals: [Double] = text.characters.map {
        switch String($0) {
          case ".":
            return 0.25
          case "-":
            return 0.8
          case "/":
            return -0.8
          default:
            return 0
        }
      }
      
      flashLight(withInterval: intervals)
    }
  }
  
  func flashLight(withInterval i: [Double]) {
    var timeToCome = 0.0
    i.forEach { time in

      timeToCome += time
      
      DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + timeToCome, execute: {
        if time > 0 {
          self.useFlashlight(turnOn: true)
          DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + time) {
            print("Flashing ", time)
            self.useFlashlight(turnOn: false)
          }
        } else if time < 0 {
          self.useFlashlight(turnOn: false)
          print("Pause ", time)
          DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + (time * time).squareRoot()) {
          }
        }
      })
    }
  }

  func useFlashlight(turnOn: Bool) {
    if let device = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo), device.hasTorch {
      do {
        try device.lockForConfiguration()
        try device.setTorchModeOnWithLevel(1.0)
        if turnOn { device.torchMode = .on } else { device.torchMode = .off }
      } catch {
        print("Hello")
      }
    }
  }
  
  
  func transcribeMethodAlert() {
    let alert = UIAlertController(title: "No Method Set.", message: "Please choose 'Morse to Phrase' or 'Phrase to Morse'", preferredStyle: .alert)
    
    let a1 = UIAlertAction(title: "To Morse", style: .default) { _ in
      self.telegram.setMethod(.ToMorse)
      self.selectionButton.setTitle("To Morse", for: .normal)
    }
    
    let a2 = UIAlertAction(title: "To Phrase", style: .default) { _ in
      self.telegram.setMethod(.ToPhrase)
      self.selectionButton.setTitle("To Phrase", for: .normal)
    }
    
    let a3 = UIAlertAction(title: "Later", style: .cancel) { _ in
      self.dismiss(animated: true, completion: nil)
    }
    
    alert.addActions(a1, a2, a3)
    present(alert, animated: true, completion: nil)
  }
  
  // Hide lower section
  
  func hideLower() {
    lowerHalfArea.isHidden = true
  }
  
  func presentLowerInState(isToMorse: Bool) {
    self.flashButton.isHidden = !isToMorse
    self.playButton.isHidden = !isToMorse
  }
  
  // Helpers
  func addSubviews(to parent: UIView, views: UIView...) {
    views.forEach { parent.addSubview($0) }
  }
  
  func addConstraints(_ consts: NSLayoutConstraint...) {
    NSLayoutConstraint.activate(consts)
  }
}

extension MainController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 2
  }
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! SelectionCell
    cell.contentLabel.text = substitutions[indexPath.row]
    return cell
  }
}

extension MainController: UITextViewDelegate {
//    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
//      transcribe()
//      return false
//    }
  
  func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
    return true
  }
  
  func textViewDidChange(_ textView: UITextView) {
    transcribe()
  }
  
//  func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
//    print("A )
//    transcribe()
//    return true
//  }
}

extension UIView {
  func falseAutoResizingMaskTranslation() {
    self.translatesAutoresizingMaskIntoConstraints = false
  }
}

extension UIAlertController {
  func addActions(_ actions: UIAlertAction...) {
    actions.forEach { self.addAction($0) }
  }
}
