//
//  Topic.swift
//  XamXam
//
//  Created by Yamadou Traore on 4/12/18.
//  Copyright © 2018 com.yamadou. All rights reserved.
//

import Foundation
import FirebaseDatabase

struct Topic {
    var uid: String
    var name = ""
    var imageName = ""
    
    init(snapshot: DataSnapshot) {
        let snapshotValue = snapshot.value as! [String: AnyObject]
        uid = snapshotValue["id"] as! String
        guard let name = snapshotValue["name"],
            let imageName = snapshotValue["image"] else {
            return
        }
        self.name = name as! String
        self.imageName = imageName as! String
        //imageName = "https://www.gettyimages.ie/gi-resources/images/Homepage/Hero/UK/CMS_Creative_164657191_Kingfisher.jpg"
    }
}


