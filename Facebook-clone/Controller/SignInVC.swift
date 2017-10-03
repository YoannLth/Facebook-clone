//
//  ViewController.swift
//  Facebook-clone
//
//  Created by yoann lathuiliere on 09/04/2017.
//  Copyright © 2017 yoann lathuiliere. All rights reserved.
//

import UIKit
import FacebookLogin
import FBSDKCoreKit
import FBSDKLoginKit
import Font_Awesome_Swift
import Firebase
import FirebaseAuth

class SignInVC: UIViewController {

  @IBOutlet weak var facebookLoginButton: CustomButton!
  @IBOutlet weak var emailTextField: CustomTextField!
  @IBOutlet weak var passwordTextField: CustomTextField!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    configureFBButton()
  }


  @IBAction func facebookLoginButtonPressed(_ sender: Any) {
    let facebookLogin = FBSDKLoginManager()
    
    facebookLogin.logIn(withReadPermissions: ["email"], from: self) { (result, error) in
      if error != nil {
        print("Yoann: Unable to authenticate with Facebook - \(error)")
      } else if result?.isCancelled == true {
        print("Yoann: User cancelled Facebook authentication")
      } else {
        print("Yoann: Successfully authenticated with Facebook")
        let credential = FacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
        self.firebaseAuth(credential)
      }
    }
  }
  
  @IBAction func loginButtonPressed(_ sender: Any) {
  }
  
  func firebaseAuth(_ credential: AuthCredential) {
    Auth.auth().signIn(with: credential) { (user, error) in
      if error != nil {
        print("Yoann: Unable to authenticate with Firebase - \(error)")
      }
      else {
        print("Yoann: Successfully authenticated with Firebase")
      }
    }
  }
  
  // TODO: Move in view
  func configureFBButton() {
    facebookLoginButton.setFAText(prefixText: "Continue with Facebook ", icon: .FAFacebookOfficial, postfixText: "", size: 25, forState: .normal)
    facebookLoginButton.setFATitleColor(color: .white, forState: .normal)
  }
}
