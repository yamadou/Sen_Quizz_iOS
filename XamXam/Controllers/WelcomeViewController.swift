//
//  WelcomeViewController.swift
//  XamXam
//
//  Created by Yamadou Traore on 4/11/18.
//  Copyright © 2018 com.yamadou. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn
import FirebaseAuth
import AVFoundation
import FBSDKLoginKit
import FirebaseDatabase

class WelcomeViewController: UIViewController {

    // Mark: - Properties
    var user: User!
    let WelcomeToTopic = "WelcomeToTopic"
    
    // Mark: - IBOutlet
    @IBOutlet weak var playButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIApplication.shared.statusBarStyle = .lightContent
        
        playButton.layer.masksToBounds = true
        playButton.layer.cornerRadius = 35
        
        Auth.auth().addStateDidChangeListener { auth, user in
            guard let user = user else {
                 let loginVC = self.storyboard?.instantiateViewController(withIdentifier: "LoginVC") as! LoginViewController
                
                // Programmaticaly logout from facebook
                FBSDKAccessToken.setCurrent(nil)
                FBSDKProfile.setCurrent(nil)
                FBSDKLoginManager().logOut()
                
                // Sign Out of Google after being authenticated
                GIDSignIn.sharedInstance().signOut()
                
                self.present(loginVC, animated: false, completion: nil)
                
                return
            }
            
            self.user = User(authData: user)
        }
    }
    
    // Mark: - IBAction
    @IBAction func logout(_ sender: Any) {
        showLogoutActionSheet()
    }
    
    // Mark: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == WelcomeToTopic {
            let destination = segue.destination as! TopicViewController
            destination.user = user
        }
    }
    
    // Mark: Private
    private func showLogoutActionSheet() {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let logout = UIAlertAction(title: "Déconnexion", style: .destructive, handler: { _ in
            self.disconnectUser()
        })
        let cancel = UIAlertAction(title: "Annuler", style: .cancel)
        
        alertController.addAction(logout)
        alertController.addAction(cancel)
        
        present(alertController, animated: true, completion: nil)
    }
    
    private func disconnectUser() {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
}


