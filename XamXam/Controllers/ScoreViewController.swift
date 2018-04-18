//
//  ScoreViewController.swift
//  XamXam
//
//  Created by Yamadou Traore on 4/18/18.
//  Copyright © 2018 com.yamadou. All rights reserved.
//

import UIKit

class ScoreViewController: UIViewController {
    
    //Mark: - Property
    var topic: Topic?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func playAgain(_ sender: Any) {
        let quizzVC = storyboard?.instantiateViewController(withIdentifier: "QuizzVC") as! QuizzViewController
        quizzVC.topic = topic
        self.present(quizzVC, animated: false, completion: nil)
    }
}
