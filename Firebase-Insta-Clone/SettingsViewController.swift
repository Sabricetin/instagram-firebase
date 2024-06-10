//
//  SettingsViewController.swift
//  Firebase-Insta-Clone
//
//  Created by Sabri Çetin on 30.05.2024.
//

import UIKit
import Firebase
class SettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func logoutcliked(_ sender: Any) {
        
        // Hem ana ekrandan hem Firebase'tan Çıkış yapma butonu
    
        do {
            try  Auth.auth().signOut()
            self.performSegue(withIdentifier: "toViewController", sender: nil)
        } catch {
            print ("ERROR!")
        }
       
        
    }
    
}
