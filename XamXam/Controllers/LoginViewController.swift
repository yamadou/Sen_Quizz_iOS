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
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIApplication.shared.statusBarStyle = .default
        
        //Facebook Login button
        let FBloginButton = FBSDKLoginButton()
        view.addSubview(FBloginButton)
        
        var y_axis = imageView.frame.height + 95
        FBloginButton.frame = CGRect(x: 40, y: y_axis, width: view.frame.width - 80, height: 50)
        
        FBloginButton.delegate = self
        
        // Google Sign In Button
        let GoogleSIignInButton = GIDSignInButton()
        view.addSubview(GoogleSIignInButton)

        y_axis = y_axis + FBloginButton.frame.height + 8
        GoogleSIignInButton.frame = CGRect(x: 36, y: y_axis, width: view.frame.width - 72, height: 50)
        
        GIDSignIn.sharedInstance().uiDelegate = self
        
        // Listen to change in Auth State
        Auth.auth().addStateDidChangeListener() { auth, user in
            if user != nil {
                self.performSegue(withIdentifier: self.loginToWelcome, sender: nil)
            } else {
                
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
        
        if result.isCancelled {
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

