//
//  Constants.swift
//  Facebook-clone
//
//  Created by yoann lathuiliere on 04/10/2017.
//  Copyright © 2017 yoann lathuiliere. All rights reserved.
//

import Foundation

struct Key {
  static let KEY_UID = "uid"
  static let SIGNIN_TO_FEED_SEGUE_NAME = "goToFeed"
  static let FEED_TO_SIGNIN_SEGUE_NAME = "goToSignIn"
  static let POST_CELL_IDENTIFIER = "PostCell"
  
  struct Firebase {
    static let POSTS_REF = "posts"
    static let USERS_REF = "users"
    static let EMAIL_PROVIDER_KEY = "email"
  }
}
