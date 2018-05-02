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
    var score = 0
    var topic: Topic?
    var user: User!
    
    // Mark: - IBOutlet
    @IBOutlet weak var rankingButton: UIButton!
    @IBOutlet weak var changeTopicButton: UIButton!
    @IBOutlet weak var playAgainButton: UIButton!
    @IBOutlet weak var quitButton: UIButton!
    @IBOutlet weak var topicLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        topicLabel.text = topic?.name
        scoreLabel.text = "Score: \(score) Point(s)"
        
        rankingButton.layer.cornerRadius = 35
        playAgainButton.layer.cornerRadius = 35
        quitButton.layer.cornerRadius = 35
        changeTopicButton.layer.cornerRadius = 35
        
    }

    
    // Mark: - IBAction
    @IBAction func playAgainDidTap(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
    
    @IBAction func changeTopicDidTap(_ sender: Any) {
        let navController = storyboard?.instantiateViewController(withIdentifier: "NavController") as! UINavigationController
        
        let quizzVC = self.presentingViewController
        let playOrSubmitVC = quizzVC?.presentingViewController
        
        self.dismiss(animated: false, completion: {
            quizzVC?.dismiss(animated: false, completion: {
                playOrSubmitVC?.dismiss(animated: false, completion: nil)
            })
        })
    }
    
    @IBAction func rankingDidTap(_ sender: Any) {
    }
    
    @IBAction func quitDidTap(_ sender: Any) {
    }
}
