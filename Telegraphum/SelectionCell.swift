//
//  SelectionCell.swift
//  Telegraphum
//
//  Created by L on 6/23/17.
//  Copyright © 2017 Lukas Mueller. All rights reserved.
//
import UIKit

class SelectionCell: UICollectionViewCell {
  
  let contentLabel: UILabel = {
    let label = UILabel()
    label.falseAutoResizingMaskTranslation()
    label.font = UIFont(name: "Okomito-Regular", size: 29/2)
    label.textColor = UIColor(red: 217/255.0, green: 217/255.0, blue: 217/255.0, alpha: 1)
    //    label.backgroundColor = .white
    return label
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    addSubview(contentLabel)
    NSLayoutConstraint.activate([
      contentLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 33/2),
      contentLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -33/2),
      contentLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
      contentLabel.heightAnchor.constraint(equalToConstant: 29/2)
      ])
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
