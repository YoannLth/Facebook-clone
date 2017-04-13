//
//  Dropshadow.swift
//  tacos pop
//
//  Created by yoann lathuiliere on 31/03/2017.
//  Copyright © 2017 yoann lathuiliere. All rights reserved.
//

import UIKit

protocol Bordered {}

extension Bordered where Self: UIView {
  
  func addBorder(width: CGFloat) {
    layer.borderWidth = width
  }
  
  func changeBorderColor(color: UIColor?) {
    layer.borderColor = color?.cgColor
  }
}
