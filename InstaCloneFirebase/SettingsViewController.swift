//
//  SettingsViewController.swift
//  InstaCloneFirebase
//
//  Created by TRIO UBMS student on 7/14/20.
//  Copyright © 2020 TRIO UBMS student. All rights reserved.
//

import UIKit
import Firebase
class SettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func logoutButton(_ sender: Any) {
        do {
            try Auth.auth().signOut()
        } catch {
            print("Error")
        }
        self.performSegue(withIdentifier: "toViewController", sender: nil)
        
        
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
