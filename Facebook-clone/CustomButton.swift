//
//  RoundedButton.swift
//  Facebook-clone
//
//  Created by yoann lathuiliere on 12/04/2017.
//  Copyright © 2017 yoann lathuiliere. All rights reserved.
//

import UIKit

@IBDesignable
class CustomButton: UIButton, Rounded, Bordered {

  @IBInspectable var cornerRadius: CGFloat = 0 {
    didSet {
      roundCorners(radius: cornerRadius)
    }
  }
  
  @IBInspectable var borderWidth: CGFloat = 0 {
    didSet {
      roundCorners(radius: cornerRadius)
    }
  }
  
  
}
