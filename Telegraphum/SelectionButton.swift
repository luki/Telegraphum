//
//  Se.ec.swift
//  Telegraphum
//
//  Created by L on 24/06/2017.
//  Copyright © 2017 Lukas Mueller. All rights reserved.
//

import UIKit

class SelectionButton: UIButton {
  
  let sectionOneLabel: UILabel = {
    let label = UILabel()
    label.falseAutoResizingMaskTranslation()
    label.font = UIFont(name: "Okomito-Medium", size: 29/2)
    label.textColor = UIColor(red: 166/255.0, green: 166/255.0, blue: 166/255.0, alpha: 1)
    label.text = "Plaintext"
    return label
  }()
  
  let arrowImage: UIImageView = {
    let ai = UIImageView()
    ai.contentMode = .scaleAspectFit
    ai.falseAutoResizingMaskTranslation()
    return ai
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    addSubview(sectionOneLabel)
    addSubview(arrowImage)
    
    NSLayoutConstraint.activate([
        sectionOneLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
        sectionOneLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
        sectionOneLabel.heightAnchor.constraint(equalToConstant: 29),
        arrowImage.leadingAnchor.constraint(equalTo: sectionOneLabel.trailingAnchor, constant: 5),
        arrowImage.centerYAnchor.constraint(equalTo: arrowImage.centerYAnchor)
    ])
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
