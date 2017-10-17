//
//  PostCell.swift
//  Facebook-clone
//
//  Created by yoann lathuiliere on 08/10/2017.
//  Copyright © 2017 yoann lathuiliere. All rights reserved.
//

import UIKit
import Kingfisher
import Firebase

class PostCell: UITableViewCell {
  
  @IBOutlet weak var profilePictureImageView: UIImageView!
  @IBOutlet weak var ownerNameLabel: UILabel!
  @IBOutlet weak var postInfosLabel: UILabel!
  @IBOutlet weak var postImageView: UIImageView!
  @IBOutlet weak var postTextField: UITextView!
  @IBOutlet weak var likeImageView: UIImageView!
  @IBOutlet weak var likesLabel: UILabel!
  @IBOutlet weak var commentsLabel: UILabel!
  @IBOutlet weak var commentImageView: UIImageView!
  
  var likeRef: DatabaseReference!
  var post: Post!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    let tap = UITapGestureRecognizer(target: self, action: #selector(likeTapped))
    tap.numberOfTapsRequired = 1
    likeImageView.addGestureRecognizer(tap)
    likeImageView.isUserInteractionEnabled = true
  }
  
  func configureCell(post: Post) {
    self.post = post
    
    postTextField.text = post.caption
    likesLabel.text = "\(post.likes) likes"
    commentsLabel.text = "\(post.comments) comments"
    postInfosLabel.text = post.postInfos

    likeRef = FirebaseService.sharedInstance.currentUserRef.child("likes").child(post.postKey)
    
    if let imageURL = post.imageUrl {
      let ref = storage.storage.reference(forURL: imageURL)
      
      ref.downloadURL(completion: { (url, error) in
        if error != nil {
          print("error: \(error)")
        }
        
        if let imageURL = url {
          self.postImageView.kf.setImage(with: imageURL)
        }
      })
    }
    
    FirebaseService.sharedInstance.getUserById(id: post.owner) { (avatarURL, username) in
      self.profilePictureImageView.kf.setImage(with: URL(string: avatarURL))
      self.ownerNameLabel.text = username
    }
    
    likeRef.observeSingleEvent(of: .value, with: { (snapshot) in
      if let _ = snapshot.value as? NSNull {
        self.likeImageView.image = UIImage(named: "like")
      } else {
        self.likeImageView.image = UIImage(named: "filled_like")
      }
    })
  }
  
  func likeTapped(sender: UITapGestureRecognizer) {
    likeRef.observeSingleEvent(of: .value, with: { (snapshot) in
      if let _ = snapshot.value as? NSNull {
        self.likeImageView.image = UIImage(named: "filled_like")
        self.post.adjustLikes(addLike: true)
        self.likeRef.setValue(true)
      } else {
        self.likeImageView.image = UIImage(named: "like")
        self.post.adjustLikes(addLike: false)
        self.likeRef.removeValue()
      }
    })
  }
}
