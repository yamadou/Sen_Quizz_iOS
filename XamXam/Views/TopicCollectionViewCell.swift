//
//  TopicCollectionViewCell.swift
//  XamXam
//
//  Created by Yamadou Traore on 4/12/18.
//  Copyright © 2018 com.yamadou. All rights reserved.
//

import UIKit
import SDWebImage

class TopicCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var topicImage: UIImageView!
    @IBOutlet weak var topicTitle: UILabel!
    
    var model: Model? {
        didSet {
            guard let model = model else {
                return
            }
            
            topicTitle.text = model.name
            topicImage.sd_setImage(with: URL(string: model.imageUrl), placeholderImage: UIImage(named: "placeholder.png"))
            
            self.layer.masksToBounds = true
            self.layer.cornerRadius = 5
            self.layer.borderWidth = 1
            self.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.5).cgColor
        }
        
    }
}

extension TopicCollectionViewCell {
    struct Model {
        let uid: String
        let name: String
        let imageUrl: String
        
        init(topic: Topic) {
            uid = topic.uid
            name = topic.name
            imageUrl = topic.imageUrl
        }
    }
}
