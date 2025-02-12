//
//  FeedViewController.swift
//  Firebase-Insta-Clone
//
//  Created by Sabri Çetin on 30.05.2024.
//

import UIKit
import Firebase
import Kingfisher


class FeedViewController: UIViewController , UITableViewDelegate , UITableViewDataSource {
    
    
  
    @IBOutlet weak var tableView: UITableView!
    
    var userEmailArray = [String]()
    var userCommentArray = [String]()
    var likeArray = [Int]()
    var userImageArray = [String]()
    var documentIDArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self

        // Do any additional setup after loading the view.
        
        getDataFromFirestore()
    }
    func getDataFromFirestore () {
        let fireSotreDatabase = Firestore.firestore()
        fireSotreDatabase.collection("Posts").order(by: "Date", descending: true).addSnapshotListener { snapshot, error in
            if error != nil {
                print (error?.localizedDescription)
                
            } else {
                if snapshot?.isEmpty != true && snapshot != nil {
                    
                    self.userImageArray.removeAll(keepingCapacity: false)
                    self.userEmailArray.removeAll(keepingCapacity: false)
                    self.userCommentArray.removeAll(keepingCapacity: false)
                    self.likeArray.removeAll(keepingCapacity: false)
                    self.documentIDArray.removeAll(keepingCapacity: false)
                    
                    
                    for document in snapshot!.documents {
                        
                        let documentID = document.documentID
                        self.documentIDArray.append(documentID)
                        
                        if let postedBy = document.get("postedBy") as? String {
                            self.userEmailArray.append(postedBy)
                        }
                        if let postComment = document.get("postComment") as? String {
                            self.userCommentArray.append(postComment)
                        }
                        if let likes = document.get("likes") as? Int {
                            self.likeArray.append(likes)
                        }
                        if let imageUrl1 = document.get("imageUrl1") as? String {
                            self.userImageArray.append(imageUrl1)
                            
                           // print(imageUrl1)
                        }
                    }
                    self.tableView.reloadData()
                }
            }
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userEmailArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! FeedCell
        cell.commentLabel.text = userCommentArray[indexPath.row]
        cell.likeLabel.text = String (likeArray[indexPath.row])
        cell.userEmailLabel.text = userEmailArray[indexPath.row]
        cell.documentIDLabel.text = documentIDArray[indexPath.row]
        
      //  cell.userImageView.image = UIImage(named: "select.png")
        cell.userImageView.kf.setImage(with: URL(string: self.userImageArray[indexPath.row]))
        //cell.userImageView.sd_setImage(with: URL(string: self.userImageArray[indexPath.row]))
        return cell
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 386
    }
}
