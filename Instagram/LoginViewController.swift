//
//  LoginViewController.swift
//  Instagram
//
//  Created by Sang Saephan on 3/7/17.
//  Copyright © 2017 Sang Saephan. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onSignIn(_ sender: Any) {
        
        PFUser.logInWithUsername(inBackground: usernameTextField.text!, password: passwordTextField.text!) { (user: PFUser?, error: Error?) in
            if user != nil {
                print("Login successful!")
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
                self.usernameTextField.text = ""
                self.passwordTextField.text = ""
            }
        }
    }
    
    @IBAction func onSignUp(_ sender: Any) {
        
        let newUser = PFUser()
        newUser.username = usernameTextField.text
        newUser.password = passwordTextField.text
        
        newUser.signUpInBackground { (success: Bool, error: Error?) in
            if success {
                print("User created!")
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
                self.usernameTextField.text = ""
                self.passwordTextField.text = ""
            } else {
                print(error!.localizedDescription)
            }
        }
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
