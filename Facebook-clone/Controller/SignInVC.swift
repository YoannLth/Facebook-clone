//
//  ViewController.swift
//  Facebook-clone
//
//  Created by yoann lathuiliere on 09/04/2017.
//  Copyright © 2017 yoann lathuiliere. All rights reserved.
//

import UIKit
import FBSDKLoginKit

class SignInVC: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    
    let loginButton = LoginButton(readPermissions: [ .PublicProfile ])
    loginButton.center = view.center
    
    view.addSubview(loginButton)
  }


}
