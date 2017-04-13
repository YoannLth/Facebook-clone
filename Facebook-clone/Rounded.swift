//
//  Dropshadow.swift
//  tacos pop
//
//  Created by yoann lathuiliere on 31/03/2017.
//  Copyright © 2017 yoann lathuiliere. All rights reserved.
//

import UIKit

protocol Rounded {}

extension Rounded where Self: UIView {
  
  func roundCorners(radius: CGFloat) {
    layer.cornerRadius = radius
  }
  
}
