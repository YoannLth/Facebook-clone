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

  // MARK: Outlets
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var postTextField: UITextField!
  @IBOutlet weak var addPhotoImageView: UIImageView!
  
  
  
  
  
  // MARK: Variables
  var posts = [Post]()
  var imagePicker: UIImagePickerController!
  
  
  
  
  
  // MARK: Actions
  @IBAction func signOutButtonPressed(_ sender: Any) {
    do {
      try Auth.auth().signOut()
      KeychainWrapper.standard.removeObject(forKey: Key.KEY_UID)
      performSegue(withIdentifier: Key.FEED_TO_SIGNIN_SEGUE_NAME, sender: nil)
    } catch {
      print(error.localizedDescription)
    }
  }
  
  @IBAction func addImageButtonPressed(_ sender: Any) {
    present(imagePicker, animated: true, completion: nil)
  }
  
  
  
  
  
  // MARK: Functions
  func loadFeed() {
    FirebaseService.sharedInstance.postsRef.observe(DataEventType.value, with: { (snapshot) in
      if let snapshot = snapshot.children.allObjects as? [DataSnapshot] {
        var posts = [Post]()
        for snap in snapshot {
          if let postDict = snap.value as? Dictionary<String, AnyObject> {
            let key = snap.key
            let post = Post(postKey: key, postData: postDict)
            posts.append(post)
          }
        }
        self.posts = posts
        self.tableView.reloadData()
      }
    })
  }
  
  func postToFirebase(imgUrl: String) {
    let post: Dictionary<String, AnyObject> = [
      "caption": postTextField.text! as AnyObject,
      "imageURL": imgUrl as AnyObject,
      "likes": 0 as AnyObject,
      "comments": 0 as AnyObject
    ]
    
    let firebasePost = FirebaseService.sharedInstance.postsRef.childByAutoId()
    firebasePost.setValue(post)
    
    postTextField.text = ""
    addPhotoImageView.image = UIImage(named: "add_photo")
    
    tableView.reloadData()
  }
}





// MARK: Lifecycle
extension FeedVC {
  override func viewDidLoad() {
    tableView.delegate = self
    tableView.dataSource = self
    self.postTextField.delegate = self
    
    loadFeed()
    
    imagePicker = UIImagePickerController()
    imagePicker.allowsEditing = true
    imagePicker.delegate = self
  }
}





// MARK: UITableView
extension FeedVC: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
    return posts.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
    let cell = tableView.dequeueReusableCell(withIdentifier: Key.POST_CELL_IDENTIFIER) as? PostCell
    
    if let postCell = cell {
      let post = posts[indexPath.row]
      postCell.configureCell(post: post)
      
      return postCell
    } else {
      return UITableViewCell()
    }
  }
}





// MARK: UIImagePicker
extension FeedVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
    if let image = info[UIImagePickerControllerEditedImage] as? UIImage {
      addPhotoImageView.image = image
    }
    imagePicker.dismiss(animated: true, completion: nil)
  }
}





// MARK: UITextField
extension FeedVC: UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    if textField == self.postTextField {
      textField.resignFirstResponder()
      
      guard let caption = postTextField.text, caption != "" else {
        return false
      }
      
      guard let image = addPhotoImageView.image else {
        return false
      }
      
      if let imageData = UIImageJPEGRepresentation(image, 0.2) {
        let imgUid = NSUUID().uuidString
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        
        FirebaseService.sharedInstance.postPicturesRef.child(imgUid).putData(imageData, metadata: metadata) { (metadata, error) in
          if error != nil {
            print("Unable to upload image to Firebasee torage")
          } else {
            print("Successfully uploaded image to Firebase storage")
            metadata?.storageReference
            let downloadURL = metadata?.downloadURL()?.absoluteString
            if let url = downloadURL {
              self.postToFirebase(imgUrl: url)
            }
          }
        }
      }
      
      return false
    }
    return true
  }
}
