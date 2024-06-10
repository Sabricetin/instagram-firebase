//
//  ViewController.swift
//  Firebase-Insta-Clone
//
//  Created by Sabri Çetin on 30.05.2024.
//

import UIKit
import Firebase


class ViewController: UIViewController {
    
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }

    @IBAction func sigInClicked(_ sender: Any) {
        
        //Kullanıcı giriş yapma fonkisiyonu
        
        if emailText.text != "" && passwordText.text != "" {
            
            Auth.auth().signIn(withEmail: emailText.text!, password: passwordText.text!) { authdata, error in
                if error != nil {
                    
                    self.makeAlert(titleInput: "ERROR", massageInput: error?.localizedDescription ?? "ERROR !")

                    
                } else {
                    self.performSegue(withIdentifier: "toFeedVC", sender: nil)

                }
            }
            
            
        } else {

            makeAlert(titleInput: "ERROR", massageInput: "Username/Password ?")


        }
        
      
    }
    
    @IBAction func SignUpClicked(_ sender: Any) {
        
        
        //Signup butonuna tıkladığımızda email ile kayıt olma kodu firebase ile
        
        if  emailText.text !=  "" && passwordText.text != "" {
            Auth.auth().createUser(withEmail: emailText.text!, password: passwordText.text!) { authdata, error in
                if error != nil {
                    
                    self.makeAlert(titleInput: "ERROR", massageInput: error?.localizedDescription ?? "ERROR !")
                    
                } else  {
                    self.performSegue(withIdentifier: "toFeedVC", sender: nil)
                }
            }
        } else   {
                makeAlert(titleInput: "ERROR", massageInput: "Username/Password ?")
                
        }
        
        //Uyarı mesajları Fonksiyon içine yazdık
       
    }
    
    func makeAlert(titleInput:String , massageInput:String) {
        let alert = UIAlertController(title: titleInput, message: massageInput, preferredStyle: UIAlertController.Style.alert)
        
        let okbutton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okbutton)
        self.present(alert, animated: true, completion: nil)
    }
}
