//
//  CircleView.swift
//  Facebook-clone
//
//  Created by yoann lathuiliere on 09/10/2017.
//  Copyright © 2017 yoann lathuiliere. All rights reserved.
//

import UIKit

class CircleView: UIImageView {
  
  override func layoutSubviews() {
    layer.cornerRadius = self.frame.width / 2
    clipsToBounds = true
  }
}
