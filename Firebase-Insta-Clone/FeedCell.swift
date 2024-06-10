//
//  FeedCell.swift
//  Firebase-Insta-Clone
//
//  Created by Sabri Çetin on 4.06.2024.
//

import UIKit
import Firebase

class FeedCell: UITableViewCell {
    
    
    
    @IBOutlet weak var userEmailLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var userImageView: UIImageView!
    
    @IBOutlet weak var documentIDLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    
    @IBAction func likeButtonClicked(_ sender: Any) {
        
        let firestoreDatabase = Firestore.firestore()
        
        if let likecCount = Int(likeLabel.text!) {
            
            let likeStore = ["likes": likecCount + 1] as [String : Any]
            
            firestoreDatabase.collection("Posts").document(documentIDLabel.text!).setData(likeStore , merge: true)

        }
        
        
        
        
        
        
        
    }
    
    
    
}
