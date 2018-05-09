//
//  ScoreDetailViewController.swift
//  XamXam
//
//  Created by Yamadou Traore on 5/3/18.
//  Copyright © 2018 com.yamadou. All rights reserved.
//

import UIKit

class RankingDetailViewController: UIViewController {
    
    // Mark: -IBOutlet
    @IBOutlet weak var topicNameLabel: UILabel!
    @IBOutlet weak var recordDateLabel: UILabel!
    @IBOutlet weak var recordTimeLabel: UILabel!
    @IBOutlet weak var recordPlayTimeLabel: UILabel!
    @IBOutlet weak var alertView: UIView!
    @IBOutlet weak var closeButton: UIButton!
    
    // Mark: - Property
    var stat: GameStat?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        topicNameLabel.text = stat?.topic
        recordDateLabel.text = stat?.date
        recordTimeLabel.text = stat?.time
        if let playtime = stat?.playTime {
            recordPlayTimeLabel.text = "\(playtime) secondes"
        }
        
        closeButton.layer.cornerRadius = 25
        
        alertView.layer.cornerRadius = 25
        alertView.layer.borderWidth = 1
        alertView.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.5).cgColor
        
        addTapGestureTo(view: self.view, selector: #selector(closeDidTap))
    }
    
    
    @IBAction func closeDidTap(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension RankingDetailViewController: UIGestureRecognizerDelegate {
    
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
