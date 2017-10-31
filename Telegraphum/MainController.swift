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
  
  let telegram = Telegram(method: .toMorse, substitution: .itu)
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
    label.font = UIFont(name: "Okomito-Medium", size: 29 / 2)
    label.textColor = UIColor(red: 166 / 255.0, green: 166 / 255.0, blue: 166 / 255.0, alpha: 1)
    label.text = NSLocalizedString("section-one-label", comment: "")
    return label
  }()
  
  lazy var sectionOneText: UITextView = {
    let tv = UITextView()
    tv.falseAutoResizingMaskTranslation()
    tv.font = UIFont(name: "Okomito-Regular", size: 35 / 2)
    tv.textColor = UIColor(red: 217 / 255.0, green: 217 / 255.0, blue: 217 / 255.0, alpha: 1)
    // TODO fixme
    tv.tintColor = UIColor.green
    tv.text = NSLocalizedString("example-text", comment: "")
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
    tb.setTitle(NSLocalizedString("selection-title", comment: ""), for: .normal)
    tb.addTarget(self, action: #selector(selectionAction), for: .touchUpInside)
    tb.setTitleColor(UIColor.darkGray, for: .normal)
    tb.setTitleColor(.black, for: .highlighted)
    tb.titleLabel?.font = UIFont(name: "Okomito-Bold", size: 29 / 2)
    tb.backgroundColor = .lightGray
    tb.layer.cornerRadius = 17
    tb.clipsToBounds = true
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
    label.font = UIFont(name: "Okomito-Medium", size: 29 / 2)
    label.textColor = UIColor(red: 166 / 255.0, green: 166 / 255.0, blue: 166 / 255.0, alpha: 1)
    label.text = NSLocalizedString("section-two-label", comment: "")
    return label
  }()
  
  let sectionTwoText: UITextView = {
    let tv = UITextView()
    tv.falseAutoResizingMaskTranslation()
    tv.font = UIFont(name: "Okomito-Regular", size: 35 / 2)
    tv.textColor = UIColor(red: 102 / 255.0, green: 102 / 255.0, blue: 102 / 255.0, alpha: 1)
    // TODO fixme
    tv.tintColor = UIColor.green
    tv.backgroundColor = .clear
    tv.textContainer.lineFragmentPadding = 0
    tv.textContainerInset = .zero
    tv.isEditable = false
    return tv
  }()
  
  var playButton: UIButton = {
    let tb = UIButton()
    tb.falseAutoResizingMaskTranslation()
    tb.contentMode = .scaleAspectFit
    tb.setImage(UIImage(named: "play"), for: .normal)
    //    tb.setTitle("Play", for: .normal)
    tb.addTarget(self, action: #selector(play), for: .touchUpInside)
    tb.setTitleColor(UIColor(red: 85 / 255, green: 215 / 255, blue: 130 / 250, alpha: 1.0), for: .normal)
    tb.setTitleColor(.black, for: .highlighted)
    tb.setTitleColor(.darkGray, for: .disabled)
    tb.titleLabel?.font = UIFont(name: "Okomito-Medium", size: 29 / 2)
    return tb
  }()
  
  var flashButton: UIButton = {
    let tb = UIButton()
    tb.falseAutoResizingMaskTranslation()
    tb.contentMode = .scaleAspectFit
    tb.setImage(UIImage(named: "flashlight"), for: .normal)
    //    tb.setTitle("Play", for: .normal)
    tb.addTarget(self, action: #selector(flashlightAction), for: .touchUpInside)
    tb.setTitleColor(UIColor(red: 85 / 255, green: 215 / 255, blue: 130 / 250, alpha: 1.0), for: .normal)
    tb.setTitleColor(.black, for: .highlighted)
    tb.setTitleColor(.darkGray, for: .disabled)
    tb.titleLabel?.font = UIFont(name: "Okomito-Medium", size: 29 / 2)
    return tb
  }()
  
  let copyButton: UIButton = {
    let tb = UIButton()
    tb.falseAutoResizingMaskTranslation()
    tb.contentMode = .scaleAspectFit
    tb.setImage(UIImage(named: "clipboard"), for: .normal)
    //    tb.setTitle("Play", for: .normal)
    tb.addTarget(self, action: #selector(copyText), for: .touchUpInside)
    tb.setTitleColor(UIColor(red: 85 / 255, green: 215 / 255, blue: 130 / 250, alpha: 1.0), for: .normal)
    tb.setTitleColor(.black, for: .highlighted)
    tb.setTitleColor(.darkGray, for: .disabled)
    tb.titleLabel?.font = UIFont(name: "Okomito-Medium", size: 29 / 2)
    return tb
  }()
  
  lazy var selectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.itemSize = CGSize(width: 467 / 2, height: 52 / 2)
    layout.minimumLineSpacing = 0
    let cv = UICollectionView(frame: CGRect(x: 0, y: 0, width: 467 / 2, height: 188 / 2), collectionViewLayout: layout)
    cv.falseAutoResizingMaskTranslation()
    cv.backgroundColor = UIColor(red: 23 / 255.0, green: 23 / 255.0, blue: 23 / 255.0, alpha: 1.0)
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
    
    let customView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 44))
    customView.backgroundColor = UIColor.darkGray
    customView.addSubview(selectionButton)
    
    NSLayoutConstraint.activate([
      selectionButton.leadingAnchor.constraint(equalTo: customView.leadingAnchor, constant: 5),
      selectionButton.trailingAnchor.constraint(equalTo: customView.trailingAnchor, constant: -5),
      selectionButton.topAnchor.constraint(equalTo: customView.topAnchor, constant: 5),
      selectionButton.bottomAnchor.constraint(equalTo: customView.bottomAnchor, constant: -5),
      ])
    
    sectionOneText.inputAccessoryView = customView
    
    view.backgroundColor = UIColor(red: 14 / 255.0, green: 14 / 255.0, blue: 14 / 255.0, alpha: 1.0)
    
    addSubviews(to: view, views: topBackground, lowerHalfArea)
    addSubviews(to: topBackground, views: sectionOneLabel, sectionOneText /* transcribeButton, selectionButton */ )
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
      sectionOneText.heightAnchor.constraint(equalToConstant: 128 / 2),
      sectionOneLabel.trailingAnchor.constraint(equalTo: topBackground.trailingAnchor, constant: -42.8),
      sectionOneLabel.bottomAnchor.constraint(equalTo: sectionOneText.topAnchor, constant: -8),
      
      //      transcribeButton.trailingAnchor.constraint(equalTo: topBackground.trailingAnchor, constant: -42.8),
      //      transcribeButton.topAnchor.constraint(equalTo: sectionOneText.bottomAnchor, constant: 5),
      //
      //      selectionButton.leadingAnchor.constraint(equalTo: topBackground.leadingAnchor, constant: 42.8),
      //      selectionButton.topAnchor.constraint(equalTo: sectionOneText.bottomAnchor, constant: 5),
      
      lowerHalfArea.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      lowerHalfArea.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      lowerHalfArea.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      lowerHalfArea.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.55),
      
      sectionTwoText.centerYAnchor.constraint(equalTo: lowerHalfArea.centerYAnchor),
      sectionTwoText.leadingAnchor.constraint(equalTo: lowerHalfArea.leadingAnchor, constant: 42.8),
      sectionTwoText.trailingAnchor.constraint(equalTo: lowerHalfArea.trailingAnchor, constant: -42.8),
      sectionTwoText.heightAnchor.constraint(equalToConstant: 152 / 2),
      sectionTwoLabel.bottomAnchor.constraint(equalTo: sectionTwoText.topAnchor, constant: -8),
      sectionTwoLabel.leadingAnchor.constraint(equalTo: lowerHalfArea.leadingAnchor, constant: 42.8),
      sectionTwoLabel.trailingAnchor.constraint(equalTo: lowerHalfArea.trailingAnchor, constant: -42.8),
      
      playButton.topAnchor.constraint(equalTo: sectionTwoText.bottomAnchor, constant: 72 / 2),
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
  
  override func touchesBegan(_: Set<UITouch>, with _: UIEvent?) {
    view.endEditing(true)
  }
  
  // Actions / Targets
  
  @objc func selectionAction() {
    transcribeMethodAlert()
  }
  
  func transcribe() {
    
    telegram.substitution = .itu
    
    if lowerHalfArea.isHidden {
      lowerHalfArea.isHidden = false

      switch telegram.method {
      case .toPhrase:
        presentLowerInState(isToMorse: false)
      case .toMorse:
        presentLowerInState(isToMorse: true)
      }
    }
    sectionTwoText.text = telegram.translate(text: sectionOneText.text)!
  }
  
  @objc func play(_ sender: UIButton) {
    if player.items().count == 0 {
      
      let sharedInstance = AVAudioSession.sharedInstance()
      // Needs to be active to notice changes in volume
      try! sharedInstance.setActive(true)
      
      if AVAudioSession.sharedInstance().outputVolume == 0 {
        
       showWarningMessageOn(view, message: NSLocalizedString("volume-message", comment: ""))
        return
      }
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
        continue
        //        print(char)
        //        print("Unknown file.")
      }
    }
    playButton.isEnabled = true
  }
  
  @objc func copyText() {
    showWarningMessageOn(view, message: NSLocalizedString("clipboard-message", comment: ""))
    UIPasteboard.general.string = sectionTwoText.text
  }
  
  func playSound(fileName name: String, ext: String) {
    player.insert(AVPlayerItem(url: Bundle.main.url(forResource: name, withExtension: ext)!), after: player.items().last)
  }
  
  @objc func flashlightAction() {
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
            //            print("Flashing ", time)
            self.useFlashlight(turnOn: false)
          }
        } else if time < 0 {
          self.useFlashlight(turnOn: false)
          //          print("Pause ", time)
          DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + (time * time).squareRoot()) {
          }
        }
      })
    }
  }
  
  func useFlashlight(turnOn: Bool) {
    if let device = AVCaptureDevice.default(for: AVMediaType.video), device.hasTorch {
      do {
        try device.lockForConfiguration()
        try device.setTorchModeOn(level: 1.0)
        if turnOn { device.torchMode = .on } else { device.torchMode = .off }
      } catch {
        //        print("Hello")
      }
    }
  }
  
  func showWarningMessageOn(_ mainView: UIView, message: String) {
    let background: UIView = {
      let bg = UIView()
      bg.backgroundColor = .white
      bg.layer.cornerRadius = 16
      bg.clipsToBounds = true
      bg.translatesAutoresizingMaskIntoConstraints = false
      return bg
    }()
    
    let warningLabel: UILabel = {
      let label = UILabel()
      label.numberOfLines = 0
      label.text = message
      label.textColor = .black
      label.font = UIFont(name: "Okomito-Bold", size: 29)
      label.translatesAutoresizingMaskIntoConstraints = false
      return label
    }()
    
    background.addSubview(warningLabel)
    mainView.addSubview(background)
    
    NSLayoutConstraint.activate([
      background.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
      background.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
      background.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      background.centerYAnchor.constraint(equalTo: view.centerYAnchor),
      
      warningLabel.centerXAnchor.constraint(equalTo: background.centerXAnchor),
      warningLabel.centerYAnchor.constraint(equalTo: background.centerYAnchor),
      warningLabel.leadingAnchor.constraint(equalTo: background.leadingAnchor, constant: 20),
      warningLabel.trailingAnchor.constraint(equalTo: background.trailingAnchor, constant: -20),
      
      background.heightAnchor.constraint(equalTo: warningLabel.heightAnchor, constant: 40),
      ])
    
    UIView.animate(withDuration: 3, animations: {
      background.alpha = 0
    })
  }
  
  func transcribeMethodAlert() {
    let alert = UIAlertController(title: NSLocalizedString("transcribe-alert-title", comment: ""), message: NSLocalizedString("transcribe-alert-message", comment: ""), preferredStyle: .alert)
    
    let a1 = UIAlertAction(title: NSLocalizedString("transcribe-option-to-morse", comment: ""), style: .default) { _ in
      self.telegram.method = .toMorse
      self.selectionButton.setTitle(NSLocalizedString("transcribe-option-to-morse", comment: ""), for: .normal)
    }
    
    let a2 = UIAlertAction(title: NSLocalizedString("transcribe-option-to-phrase", comment: ""), style: .default) { _ in
      self.telegram.method = .toPhrase
      self.selectionButton.setTitle(NSLocalizedString("transcribe-option-to-phrase", comment: ""), for: .normal)
    }
    
    let a3 = UIAlertAction(title: NSLocalizedString("transcribe-option-later", comment: ""), style: .cancel) { _ in
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
    flashButton.isHidden = !isToMorse
    playButton.isHidden = !isToMorse
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
  func collectionView(_: UICollectionView, numberOfItemsInSection _: Int) -> Int {
    return 2
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! SelectionCell
    cell.contentLabel.text = substitutions[indexPath.row]
    return cell
  }
}

extension MainController: UITextViewDelegate {
  func textViewDidChange(_: UITextView) {
    transcribe()
  }
}

extension UIView {
  func falseAutoResizingMaskTranslation() {
    translatesAutoresizingMaskIntoConstraints = false
  }
}

extension UIAlertController {
  func addActions(_ actions: UIAlertAction...) {
    actions.forEach { self.addAction($0) }
  }
}
