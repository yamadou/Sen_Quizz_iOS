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
    var uid = ""
    var goodAnswerUid = ""
    var topicUid = ""
    var question = ""
    
    init(snapshot: DataSnapshot) {
        let snapshotValue = snapshot.value as! [String: AnyObject]
        
        guard let uid = snapshotValue["id"],
            let goodAnswerUid = snapshotValue["id_good_answer"],
                let topicUid = snapshotValue["id_theme"],
                    let question = snapshotValue["text_question"] else{
            return
        }
        
        self.uid = uid as! String
        self.goodAnswerUid = goodAnswerUid as! String
        self.topicUid = topicUid as! String
        self.question = question as! String    
    }
    
    init(topicUid: String, question: String) {
        self.topicUid = topicUid
        self.question = question
    }
    
    mutating func submitQuestion() -> String {
        var questionRef = Database.database().reference(withPath: "questions")
            .childByAutoId()
        questionRef.setValue([ "id": questionRef.key,
                               "id_good_answer": goodAnswerUid,
                               "id_theme": topicUid,
                               "text_question": question])
        
        self.uid = questionRef.key
        return questionRef.key
    }
    
    func update(goodAnswerUid: String) {
        Database.database().reference(withPath: "questions").child(uid).updateChildValues(["id_good_answer": goodAnswerUid])
    }
}
