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
    var uid = ""
    var name = ""
    var imageName = ""
    
    init(snapshot: DataSnapshot) {
        let snapshotValue = snapshot.value as! [String: AnyObject]
        guard
            let uid = snapshotValue["id"],
            let name = snapshotValue["name"],
            let imageName = snapshotValue["image"] else {
            return
        }
        
        self.uid = uid as! String
        self.name = name as! String
        self.imageName = imageName as! String
    }
}


