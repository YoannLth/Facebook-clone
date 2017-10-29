//
//  FirebaseService.swift
//  Facebook-clone
//
//  Created by yoann lathuiliere on 09/10/2017.
//  Copyright © 2017 yoann lathuiliere. All rights reserved.
//

import Foundation
import Firebase
import SwiftKeychainWrapper

let db = Database.database().reference()
let storage = Storage.storage().reference()

class FirebaseService {
  
  // MARK: - Variables
  static let sharedInstance = FirebaseService()
  private var _postsRef = db.child(Key.Firebase.POSTS_REF)
  private var _usersRef = db.child(Key.Firebase.USERS_REF)
  private var _baseRef = db
  private var _postPicturesRef = storage.child(Key.Firebase.POST_PICTURES_REF)
  
  var postsRef: DatabaseReference {
    return _postsRef
  }
  
  var usersRef: DatabaseReference {
    return _usersRef
  }
  
  var baseRef: DatabaseReference {
    return _baseRef
  }
  
  var postPicturesRef: StorageReference {
    return _postPicturesRef
  }
  
  var currentUserRef: DatabaseReference {
    let uid = KeychainWrapper.standard.string(forKey: Key.KEY_UID)
    let user = usersRef.child(uid!)
    return user
  }
  
  
  
  
  // MARK: - Initializer
  private init(){}
  
  
  
  
  
  // MARK: - Functions
  func createFirebaseDBUser(uid: String, userData: Dictionary<String, String>) {
    _usersRef.child(uid).updateChildValues(userData)
  }
  
  func getUserById(id: String, completionHandler: @escaping (_ avatarURL: String, _ username: String) -> ()) {
    let ref = _usersRef.child(id)
    
    ref.observeSingleEvent(of: .value, with: { (snapshot) in
      if let userDict = snapshot.value as? [String:Any] {
        //Do not cast print it directly may be score is Int not string
        if let avatarURL = userDict["avatar"] as? String, let username = userDict["username"] as? String {
          completionHandler(avatarURL, username)
        }
      }
    })
  }
}
