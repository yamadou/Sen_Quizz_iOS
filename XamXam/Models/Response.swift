//
//  Response.swift
//  XamXam
//
//  Created by Yamadou Traore on 4/13/18.
//  Copyright © 2018 com.yamadou. All rights reserved.
//

import Foundation
import FirebaseDatabase

struct Response {
    var uid: String
    var questionUid: String
    var response = ""
    
    init(snapshot: DataSnapshot) {
        let snapshotValue = snapshot.value as! [String: AnyObject]
        uid = snapshotValue["id"] as! String
        questionUid = snapshotValue["id_question"] as! String
        response = snapshotValue["text_response"] as! String
    }
}
