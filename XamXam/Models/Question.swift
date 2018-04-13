//
//  Question.swift
//  XamXam
//
//  Created by Yamadou Traore on 4/13/18.
//  Copyright © 2018 com.yamadou. All rights reserved.
//

import Foundation
import FirebaseDatabase

struct Question {
    var uid: String
    var goodAnswerUid: String
    var topicUid: String
    var question = ""
    
    init(snapshot: DataSnapshot) {
        let snapshotValue = snapshot.value as! [String: AnyObject]
        uid = snapshotValue["id"] as! String
        goodAnswerUid = snapshotValue["id_good_answer"] as! String
        topicUid = snapshotValue["id_theme"] as! String
        question = snapshotValue["text_question"] as! String

    }
}
