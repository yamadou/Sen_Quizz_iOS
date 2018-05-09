//
//  Score.swift
//  XamXam
//
//  Created by Yamadou Traore on 5/2/18.
//  Copyright © 2018 com.yamadou. All rights reserved.
//

import Foundation
import FirebaseDatabase

struct GameStat {
    var date = Date().toString(dateFormat: "dd/MM/yyy")
    var time = Date().toString(dateFormat: "HH:mm")
    var playerName = "No name"
    var topic = ""
    var score = 0
    var playTime = 0
    var profileImageUrl: String?
    
    init(playerName: String, topic: String, score: Int, playTime: Int, profileImageUrl: String?) {
        self.playerName = playerName
        self.topic = topic
        self.score = score
        self.playTime = playTime
        if profileImageUrl != nil {
            self.profileImageUrl = profileImageUrl
        }
    }
    
    init(snapshot: DataSnapshot) {
        
        let snapshotValue = snapshot.value as! [String: AnyObject]
        date = snapshotValue["date_record"] as! String
        time = snapshotValue["heure_record"] as! String
        playerName = snapshotValue["name_user"] as! String
        topic = snapshotValue["name_theme"] as! String
        score = snapshotValue["score"] as! Int
        playTime = snapshotValue["time_game"] as! Int
        
        guard let profileImageUrl = snapshotValue["profile_image"] else {
            return
        }
        self.profileImageUrl = profileImageUrl as! String
    }
    
    func saveStatsFor(_ user: User) {
        Database.database().reference(withPath: "scores")
            .childByAutoId().setValue(["date_record": date,
                                       "heure_record": time,
                                       "name_user": playerName,
                                       "name_theme": topic,
                                       "score": score,
                                       "profile_image": profileImageUrl,
                                       "time_game": playTime])
    }
}
