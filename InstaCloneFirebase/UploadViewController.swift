//
//  UploadViewController.swift
//  InstaCloneFirebase
//
//  Created by TRIO UBMS student on 7/14/20.
//  Copyright © 2020 TRIO UBMS student. All rights reserved.
//

import UIKit
import Firebase

class UploadViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tapToSelectButton.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(chooseImage))
        tapToSelectButton.addGestureRecognizer(gestureRecognizer)
        

        // Do any additional setup after loading the view.
    }
    
    func makeAlert(titleInput: String, messageInput: String) {
        let alert = UIAlertController(title: titleInput, message: messageInput , preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func chooseImage() {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = .photoLibrary
        present(pickerController, animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        tapToSelectButton.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
    
    }
    
    @IBOutlet weak var tapToSelectButton: UIImageView!
    @IBOutlet weak var uploadButtonClicked: UIButton!
    @IBOutlet weak var comentTextField: UITextField!
    
    @IBAction func uploadButtonClicked(_ sender: Any) {
        
        let storage = Storage.storage() // Similar to Auth.auth
        let storageReference = storage.reference()
        
        let mediaFolder = storageReference.child("media") // creates a folder inside "media" folder
        
        //Converting Images to a data type
        if let data = tapToSelectButton.image?.jpegData(compressionQuality: 0.5) {
            
            let uuid = UUID().uuidString // creates text
            
            let imageReference = mediaFolder.child("\(uuid).jpg")
            imageReference.putData(data, metadata: nil) { (metadata, error) in
                if error != nil {
                    self.makeAlert(titleInput: "Error", messageInput: error?.localizedDescription ?? "Error")
                } else {
                    // get URL of the uploaded image, to save it to the database
                    imageReference.downloadURL { (url, error) in
                        if error != nil {
                            let imageUrl = url?.absoluteString
                            
                            //DATABASE
                            let firestoreDatabase = Firestore.firestore()
                            
                            var firestoreReference : DocumentReference? = nil
                            
                            let firestorePost = ["imageUrl" : imageUrl!, "postedBy" : Auth.auth().currentUser!.email, "postComment" : self.comentTextField.text!, "date" : FieldValue.serverTimestamp(), "likes" : 0] as [String : Any]

                           
                            
                            firestoreReference = firestoreDatabase.collection("Posts").addDocument(data: firestorePost, completion: { (error) in
                                if error != nil {
                                    self.makeAlert(titleInput: "Error", messageInput: error?.localizedDescription ?? "Error")
                                }else {
                                    self.tapToSelectButton.image = UIImage(named: "TapToSelect.png")
                                    self.comentTextField.text = ""
                                    self.tabBarController?.selectedIndex = 0
                                }
                                
                            
                            
                        })
                        
                        
                }
                
                
                }
                
        }
    }
}
}
}
