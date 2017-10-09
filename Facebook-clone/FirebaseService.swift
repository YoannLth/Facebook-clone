//
//  FirebaseService.swift
//  Facebook-clone
//
//  Created by yoann lathuiliere on 09/10/2017.
//  Copyright © 2017 yoann lathuiliere. All rights reserved.
//

import Foundation
import Firebase

let db = Database.database().reference()

class FirebaseService {
  static let sharedInstance = FirebaseService()
  
  private init(){}
  
  private var _postsRef = db.child(Key.Firebase.POSTS_REF)
  private var _usersRef = db.child(Key.Firebase.USERS_REF)
  private var _baseRef = db
  
  var postsRef: DatabaseReference {
    return _postsRef
  }
  
  var usersRef: DatabaseReference {
    return _usersRef
  }
  
  var baseRef: DatabaseReference {
    return _baseRef
  }
  
  func createFirebaseDBUser(uid: String, userData: Dictionary<String, String>) {
    _usersRef.child(uid).updateChildValues(userData)
  }
}
