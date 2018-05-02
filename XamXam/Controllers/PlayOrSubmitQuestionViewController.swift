//
//  PlayOrSubmitQuestionViewController.swift
//  XamXam
//
//  Created by Yamadou Traore on 4/13/18.
//  Copyright © 2018 com.yamadou. All rights reserved.
//

import UIKit

class PlayOrSubmitQuestionViewController: UIViewController {

    // Mark: - Properties
    var user: User!
    var topic: Topic?
    
    // Mark: - IBOutlet
    @IBOutlet weak var alertView: UIView!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var submitQuestionButton: UIButton!
    @IBOutlet weak var topicNameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        alertView.layer.cornerRadius = 25
        
        playButton.layer.masksToBounds = true
        playButton.layer.cornerRadius = 22.5
        
        submitQuestionButton.layer.masksToBounds = true
        submitQuestionButton.layer.cornerRadius = 22.5
        
        addTapGestureTo(view: self.view, selector: #selector(dismissAlert))
        
    }
    
    // Mark: - IBActions
    @IBAction func playDidTap(_ sender: Any) {
    }
    
    @IBAction func submitQuestionDidTap(_ sender: Any) {
    }
    
    // Mark: - Private
    @objc private func dismissAlert() {
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "PlayToQuizz" {
            let destination = segue.destination as! QuizzViewController
            destination.topic = topic
            destination.user = user
        }
    }
    
}

extension PlayOrSubmitQuestionViewController: UIGestureRecognizerDelegate {
    
    // Mark: - UIGestureRecognizerDelegate
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if touch.view == self.view {
            return true
        }
        return false
    }
    
    // Mark: - Private
    private func addTapGestureTo(view: UIView, selector: Selector){
        let tapGesture = UITapGestureRecognizer(target: self, action: selector)
        tapGesture.delegate = self
        tapGesture.numberOfTapsRequired = 1
        tapGesture.numberOfTouchesRequired = 1
        
        view.addGestureRecognizer(tapGesture)
        view.isUserInteractionEnabled = true
    }
}
