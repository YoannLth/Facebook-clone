//
//  PostCell.swift
//  Facebook-clone
//
//  Created by yoann lathuiliere on 08/10/2017.
//  Copyright © 2017 yoann lathuiliere. All rights reserved.
//

import UIKit
import Kingfisher

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
  
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  
  func configureCell(post: Post) {
    postTextField.text = post.caption
    likesLabel.text = "\(post.likes) likes"

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
  }
}
