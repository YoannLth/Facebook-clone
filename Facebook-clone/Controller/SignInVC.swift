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
  @IBOutlet weak var scrollView: UIScrollView!
  var activeField: UITextField?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    configureFBButton()
    
    self.emailTextField.delegate = self
    self.passwordTextField.delegate = self
    registerForKeyboardNotifications()
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
    print("Button pressed")
    if let email = emailTextField.text, let password = passwordTextField.text {
      Auth.auth().signIn(withEmail: email, password: password, completion: { (_, error) in
        if error == nil {
          print("Successfully authenticated with Email")
        } else {
          Auth.auth().createUser(withEmail: email, password: password, completion: { (_, error) in
            if error != nil {
              print("Impossible to create user with Email - \(error)")
            }
          })
        }
      })
    }
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







extension SignInVC : UITextFieldDelegate {
  // TODO: Hide when keyboard tapped elsewhere
  
  func registerForKeyboardNotifications() {
    //Adding notifies on keyboard appearing
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWasShown(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillBeHidden(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
  }
  
  func deregisterFromKeyboardNotifications() {
    //Removing notifies on keyboard appearing
    NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
    NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
  }
  
  func keyboardWasShown(notification: NSNotification) {
    //Need to calculate keyboard exact size due to Apple suggestions
    self.scrollView.isScrollEnabled = true
    var info = notification.userInfo!
    let keyboardSize = (info[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue.size
    let contentInsets: UIEdgeInsets = UIEdgeInsetsMake(0.0, 0.0, keyboardSize!.height, 0.0)
    
    self.scrollView.contentInset = contentInsets
    self.scrollView.scrollIndicatorInsets = contentInsets
    
    var aRect: CGRect = self.view.frame
    aRect.size.height -= keyboardSize!.height
    if let activeField = self.activeField {
      if (!aRect.contains(activeField.frame.origin)) {
        self.scrollView.scrollRectToVisible(activeField.frame, animated: true)
      }
    }
  }
  
  func keyboardWillBeHidden(notification: NSNotification) {
    //Once keyboard disappears, restore original positions
    var info = notification.userInfo!
    let keyboardSize = (info[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue.size
    let contentInsets : UIEdgeInsets = UIEdgeInsetsMake(0.0, 0.0, -keyboardSize!.height, 0.0)
    self.scrollView.contentInset = contentInsets
    self.scrollView.scrollIndicatorInsets = contentInsets
    self.view.endEditing(true)
    self.scrollView.isScrollEnabled = false
  }
  
  func textFieldDidBeginEditing(_ textField: UITextField) {
    activeField = textField
  }
  
  func textFieldDidEndEditing(_ textField: UITextField) {
    activeField = nil
  }
}
