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

  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var addPhotoImageView: UIImageView!
  
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
    tableView.delegate = self
    tableView.dataSource = self
    
  }
}



extension FeedVC: UITableViewDataSource{
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
    return 1
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
    let cell = tableView.dequeueReusableCell(withIdentifier: Key.POST_CELL_IDENTIFIER) as? PostCell
    
    if let postCell = cell {
      postCell.backgroundColor = UIColor.clear
      return postCell
    } else {
      return UITableViewCell()
    }
  }
}


extension FeedVC: UITableViewDelegate{
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    // code to perform when a cell is pressed
  }
}
