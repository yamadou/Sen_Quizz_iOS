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
    var name: String
    var imageUrl: String
    
    init(snapshot: DataSnapshot) {
        let snapshotValue = snapshot.value as! [String: AnyObject]
        uid = snapshotValue["id"] as! String
        name = snapshotValue["name"] as! String
        imageUrl = "https://www.gettyimages.ie/gi-resources/images/Homepage/Hero/UK/CMS_Creative_164657191_Kingfisher.jpg"
        //imageUrl = snapshotValue["image"] as! String
    }
}

//class Dog: Object {
//    @objc dynamic var uid = ""
//    @objc dynamic var name = ""
//    @objc dynamic var image = ""
//
//    override static func primaryKey() -> String? {
//        return "uid"
//    }
//
//    required convenience init(snapshot: DataSnapshot) {
//        self.init()
//
//        let snapshotValue = snapshot.value as! [String: AnyObject]
//        uid = snapshotValue["id"] as! String
//        name = snapshotValue["name"] as! String
//        image = "https://www.gettyimages.ie/gi-resources/images/Homepage/Hero/UK/CMS_Creative_164657191_Kingfisher.jpg"
//        //image = snapshotValue["image"] as! String
//    }
//}

