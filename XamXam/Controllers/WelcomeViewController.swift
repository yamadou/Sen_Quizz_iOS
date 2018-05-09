//
//  WelcomeViewController.swift
//  XamXam
//
//  Created by Yamadou Traore on 4/11/18.
//  Copyright © 2018 com.yamadou. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import AVFoundation
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
            guard let user = user else { return }
            self.user = User(authData: user)
        }
    }
    
    // Mark: - IBAction
    @IBAction func logout(_ sender: Any) {
        
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
    
    // Mark: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == WelcomeToTopic {
            let destination = segue.destination as! TopicViewController
            destination.user = user
        }
    }
}
