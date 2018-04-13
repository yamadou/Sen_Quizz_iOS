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
    
}