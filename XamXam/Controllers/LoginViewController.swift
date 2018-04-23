//
//  ViewController.swift
//  XamXam
//
//  Created by Yamadou Traore on 4/11/18.
//  Copyright © 2018 com.yamadou. All rights reserved.
//

import UIKit
import Firebase
import FBSDKCoreKit
import FBSDKLoginKit
import FirebaseAuth
import GoogleSignIn

class LoginViewController: UIViewController {
    
    // Mark: - Constants
    let loginToWelcome = "LoginToWelcome"
    
    // Mark: - @IBOutlet
    @IBOutlet weak var loginButton: FBSDKLoginButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIApplication.shared.statusBarStyle = .default
        
        //Facebook Login button
        loginButton.delegate = self
        
        // Google Sign In
        GIDSignIn.sharedInstance().uiDelegate = self
        
        Auth.auth().addStateDidChangeListener() { auth, user in
            if user != nil {
                self.performSegue(withIdentifier: self.loginToWelcome, sender: nil)
            }
        }
    }
    
}

// Mark: - Facebook Login
extension LoginViewController: FBSDKLoginButtonDelegate {
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
    }
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        if let error = error {
            print(error.localizedDescription)
            return
        }
        
        let credential = FacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
        
        // Authenticate with firebase
        Auth.auth().signIn(with: credential) { (user, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
        }
    }
}

// Mark: - Google Login
extension LoginViewController: GIDSignInUIDelegate {}

// Logging Out
//let firebaseAuth = Auth.auth()
//do {
//    try firebaseAuth.signOut()
//} catch let signOutError as NSError {
//    print ("Error signing out: %@", signOutError)
//}

