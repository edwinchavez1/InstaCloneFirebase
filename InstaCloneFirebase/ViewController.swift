//
//  ViewController.swift
//  InstaCloneFirebase
//
//  Created by TRIO UBMS student on 7/6/20.
//  Copyright © 2020 TRIO UBMS student. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let currentUser = Auth.auth().currentUser
        
        if currentUser != nil { //Checks if there is a current user
            self.performSegue(withIdentifier: "toFeedVC", sender: nil)
        }
        
    }
    
    
    // write makeAlert() function
    func makeAlert(titleInput: String, messageInput: String) {
        let alert = UIAlertController(title: titleInput, message: messageInput , preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
    
    
    
    
    //connects buttons and labels and textfields
    
    @IBOutlet weak var instaCloneNameLabel: UILabel!
    
    @IBOutlet weak var userNameTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    @IBAction func signInButton(_ sender: Any) {
        
        if userNameTextField.text != "" && passwordTextField.text != "" {
            
            Auth.auth().signIn(withEmail: userNameTextField.text!, password: passwordTextField.text!) { (authdata, error) in
                
                if error != nil {
                    self.makeAlert(titleInput: "Error", messageInput: error?.localizedDescription ?? "Error")
                }
                else {
                    self.performSegue(withIdentifier: "toFeedVC", sender: nil)
                }
                
            }
            
            
            
        }else {
            makeAlert(titleInput: "Error", messageInput: "Email or Password Missing")
        }
        
        
    }
    @IBAction func registerButton(_ sender: Any) { //if both fields are NOT empty then the registration can continue
        
        if userNameTextField.text != "" && passwordTextField.text != "" {
            Auth.auth().createUser(withEmail: userNameTextField.text!, password: passwordTextField.text!) { (authdata, error) in
                
                if error != nil { //if error is Not Nil, proceed to next step
                    // alert popup here
                    self.makeAlert(titleInput: "Error", messageInput: error?.localizedDescription ?? "Error")
                    
                    
                } else { // if error is Nil, proceed to next step
                    self.performSegue(withIdentifier: "toFeedVC", sender: nil)
                }
                
               
                
            }
            
            
            
            
            
            
        } else {
            makeAlert(titleInput:"Error",messageInput:"Email or Password Missing")
            
            //Moved to makeAlert function
            /*
            let alert = UIAlertController(title: "Error", message: "Email or Password missing" , preferredStyle: UIAlertController.Style.alert)
            let okButton = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil)
            alert.addAction(okButton)
            self.present(alert, animated: true, completion: nil)
            */
        }
        
            
        
        
        
    }
    
}

