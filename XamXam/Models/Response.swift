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
    var uid = ""
    var questionUid = ""
    var response = ""
    
    init(snapshot: DataSnapshot) {
        let snapshotValue = snapshot.value as! [String: AnyObject]
        if let uid = snapshotValue["id"] {
            self.uid = uid as! String
        }
        if let questionUid = snapshotValue["id_question"] {
            self.questionUid = questionUid as! String
        }
        if let response = snapshotValue["text_response"] {
            self.response = response as! String
        }
    }
    
    init(questionUid: String, response: String) {
        self.uid = ""
        self.questionUid = questionUid
        self.response = response
    }
    
    mutating func submitResponse() -> String {
        var responseRef = Database.database().reference(withPath: "responses")
            .childByAutoId()
        responseRef.setValue(["id": responseRef.key,
                              "id_question": questionUid,
                              "text_response": response])
        
        self.uid = responseRef.key
        return responseRef.key
    }
}
