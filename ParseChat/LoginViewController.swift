//
//  LoginViewController.swift
//  ParseChat
//
//  Created by Rahul Pandey on 10/27/16.
//  Copyright © 2016 Rahul Pandey. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onLoginButton(_ sender: AnyObject) {
        print("login button tap")
        var user = try? PFUser.logIn(withUsername: usernameField.text!, password: passwordField.text!)
//        PFUser user = PFUser.current()
        if let user = user {
            print("logged in as: \(user.email)")
            self.performSegue(withIdentifier: "Chat", sender: self)
        } else {
            print("could not login: \(user)")
            let alertController = UIAlertController(title: "Failure", message: "Failed to login", preferredStyle: .alert)
            let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
                // dismiss by default
            }
            alertController.addAction(OKAction)
            present(alertController, animated: true, completion: {
                // empty
            })
        }
        
    }
    
    
    @IBAction func onSignupClicked(_ sender: AnyObject) {
        print("signup tap")
        let user = PFUser()
        user.username = usernameField.text
        user.password = passwordField.text
//        user.email = "email@example.com"
        
        user.signUpInBackground {
            (succeeded: Bool, error: Error?) -> Void in
            if let error = error {
                print("error: \(error.localizedDescription)")
//                let errorString = error.userInfo["error"] as? String
                // Show the errorString somewhere and let the user try again.
                let alertController = UIAlertController(title: "Failure", message: "Failed to signup", preferredStyle: .alert)
                let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
                    // dismiss by default
                }
                alertController.addAction(OKAction)
                self.present(alertController, animated: true, completion: {
                    // empty
                })
            } else {
                self.performSegue(withIdentifier: "Chat", sender: self)
                // Hooray! Let them use the app now.
                print("signed up")
                
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
