//
//  RankingCell.swift
//  XamXam
//
//  Created by Yamadou Traore on 5/2/18.
//  Copyright © 2018 com.yamadou. All rights reserved.
//

import UIKit

class RankingCell: UITableViewCell {

    @IBOutlet weak var playerNameLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak internal var profileImageView: UIImageView!
    @IBOutlet weak internal var medalImageView: UIImageView!
    
    var model: Model? {
        didSet {
            guard let model = model else {
                return
            }
            
            playerNameLabel.text = model.playerName
            scoreLabel.text = "\(model.score) PTS"
            
            if model.index == 0 {
                medalImageView.image = UIImage(named: "goldMedal")
            } else if model.index == 1 {
                medalImageView.image = UIImage(named: "silverMedal")
            } else if model.index == 2 {
                medalImageView.image = UIImage(named: "bronzeMedal")
            } else {
                medalImageView.image = UIImage(named: "")
            }
            
            profileImageView.layer.borderWidth = 1.0
            profileImageView.layer.masksToBounds = false
            profileImageView.layer.borderColor = UIColor.darkGray.cgColor
            profileImageView.layer.cornerRadius = profileImageView.frame.size.width / 2
            profileImageView.clipsToBounds = true
            
            self.layer.borderWidth = 1
            self.layer.masksToBounds = true
            self.layer.cornerRadius = 5
            self.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.5).cgColor
            self.clipsToBounds = true
        }
    }
}

extension RankingCell {
    struct Model {
        var playerName = "No Name"
        var score = 0
        var profileImageUrl = ""
        var index = 0
        
        init(stat: GameStat, index: Int) {
            self.index = index
            if let playerName = stat.playerName {
                self.playerName = playerName
            }
            if let score = stat.score {
                self.score = score
            }
            if let profileImageUrl = stat.profileImageUrl {
                self.profileImageUrl = profileImageUrl
            }
        }
    }
}
