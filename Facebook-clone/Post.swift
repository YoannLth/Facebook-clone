//
//  Post.swift
//  Facebook-clone
//
//  Created by yoann lathuiliere on 09/10/2017.
//  Copyright © 2017 yoann lathuiliere. All rights reserved.
//

import Foundation
import Firebase

class Post {
  // MARK: Variables
  private var _caption: String!
  private var _imageUrl: String?
  private var _likes: Int!
  private var _postKey: String!
  private var _comments: Int!
  private var _postInfos: String!
  private var _owner: String!
  private var _postRef: DatabaseReference!
  
  var caption: String {
    return _caption
  }
  
  var imageUrl: String? {
    return _imageUrl
  }
  
  var likes: Int {
    return _likes
  }
  
  var comments: Int {
    return _comments
  }
  
  var postKey: String {
    return _postKey
  }
  
  var postInfos: String {
    return _postInfos
  }
  
  var owner: String {
    return _owner
  }
  
  
  
  
  
  // MARK: Init
  init(caption: String, imageUrl: String, likes: Int) {
    self._caption = caption
    self._imageUrl = caption
    self._likes = likes
  }
  
  init(postKey: String, postData: [String: AnyObject]) {
    self._postKey = postKey
    
    if let caption = postData["caption"] as? String {
      self._caption = caption
    }
    
    if let imageUrl = postData["imageURL"] as? String {
      self._imageUrl = imageUrl
    }
    
    if let likes = postData["likes"] as? Int {
      self._likes = likes
    }
    
    if let comments = postData["comments"] as? Int {
      self._comments = comments
    }
    
    if let infos = postData["infos"] as? String {
      self._postInfos = infos
    }
    
    if let owner = postData["owner"] as? String {
      self._owner = owner
    }
    
    _postRef = FirebaseService.sharedInstance.postsRef.child(_postKey)
  }
  
  
  
  
  
  // MARK: Function
  func adjustLikes(addLike: Bool) {
    if addLike {
      _likes = _likes + 1
    } else {
      _likes = likes - 1
    }
    _postRef.child("likes").setValue(_likes)
  }
}
