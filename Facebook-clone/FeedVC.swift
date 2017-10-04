//
//  FeedVC.swift
//  Facebook-clone
//
//  Created by yoann lathuiliere on 04/10/2017.
//  Copyright © 2017 yoann lathuiliere. All rights reserved.
//

import UIKit
import Firebase
import SwiftKeychainWrapper

class FeedVC: UIViewController {

  @IBAction func signOutButtonPressed(_ sender: Any) {
    do {
      try Auth.auth().signOut()
      KeychainWrapper.standard.removeObject(forKey: Key.KEY_UID)
      performSegue(withIdentifier: Key.FEED_TO_SIGNIN_SEGUE_NAME, sender: nil)
    } catch {
      print(error.localizedDescription)
    }
  }
  
  override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}
