//
//  UploadViewController.swift
//  Firebase-Insta-Clone
//
//  Created by Sabri Çetin on 30.05.2024.
//

import UIKit
import Firebase
import FirebaseStorage

class UploadViewController: UIViewController , UIImagePickerControllerDelegate , UINavigationControllerDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var commentText: UITextField!
    @IBOutlet weak var uploadClick: UIButton!
    
   
    
    override func viewDidLoad() {
        
        
        
        super.viewDidLoad()
        //Kullanıcı fotoğraf yükleme fonkisyonu
        
        imageView.isUserInteractionEnabled = true
        let gesturRecognizer = UITapGestureRecognizer(target: self, action: #selector(chooseImage))
        imageView.addGestureRecognizer(gesturRecognizer)
    }
    
    @objc func chooseImage () {
        
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = .photoLibrary
        present(pickerController, animated: true, completion: nil)
        
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        imageView.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
        
    }
    
    func  makeAlert (titleInput: String , messageInput: String)  {
        
        let alert = UIAlertController.init(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func saveClicked(_ sender: Any) {
        
        //Kullanıcıdan seçtirdiğimiz fotoğrafı Firebase'e kayıt etme fonksiyonu
        let storage = Storage.storage()
        let storageReferance = storage.reference()
        let mediaFolder = storageReferance.child("media")
        
        if let data = imageView.image?.jpegData(compressionQuality: 0.2) {
            
            
            //UUİD ile her fotoğrafı ayrı bir dosya olarak Firebase'e kayıt etme fonksiyonu
            let uuid = UUID().uuidString
            
            let imageReferance = mediaFolder.child("\(uuid).jpg")
            imageReferance.putData(data, metadata: nil) { metadata, error in
                if error != nil {
                    self.makeAlert(titleInput: "ERROR", messageInput: error?.localizedDescription ?? "Error")
                    
                }
                else {
                    imageReferance.downloadURL { [self] url, error in
                        if error == nil {
                            
                            let imageUrl1 = url?.absoluteString
                            print (imageUrl1!)
                            
                            
                            //DATABASE İŞLEMLERİ
                            
                            let firestoreDatabase = Firestore.firestore()
                            
                            var firestoreReferance : DocumentReference? = nil
                            
                            let firestorePost = ["imageUrl1" : imageUrl1! , "postedBy" : Auth.auth().currentUser!.email!, "postComment" :self.commentText.text!, "Date" : FieldValue.serverTimestamp() , "likes" : 0 ]
                            
                            firestoreReferance = firestoreDatabase.collection("Posts").addDocument(data: firestorePost, completion: { (error) in
                                if error != nil {
                                    self.makeAlert(titleInput: "Error ! ", messageInput: error?.localizedDescription ?? "Error" )
                                }
                                else {
                                    
                                    self.imageView.image = UIImage(named: "select.png")
                                    self.commentText.text = ""
                                    self.tabBarController?.selectedIndex = 0
                                    
                                }
                            })
                            
                            
                            
                            
                        }
                    }
                }
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

}
