//
//  WebService.swift
//  XamXam
//
//  Created by Yamadou Traore on 4/13/18.
//  Copyright © 2018 com.yamadou. All rights reserved.
//

import Foundation
import FirebaseDatabase

class WebService {
    
    // Topics
    class func fetchTopics(_ completion: @escaping ([Topic]) -> Void) {
        let topicsRef = Database.database().reference(withPath: "themes")
    
        topicsRef.observe(.value, with: { snapshot in
            var topics: [Topic] = []
            
            for snap in snapshot.children {
                let topic = Topic(snapshot: snap as! DataSnapshot)
                topics.append(topic)
            }
            
            completion(topics)
        })
    }
    
    // Questions
    class func fetchQuestions(_ completion: @escaping ([Question]) -> Void) {
        let questionsRef = Database.database().reference(withPath: "questions").queryOrdered(byChild: "id_theme")
        
        questionsRef.observe(.value, with: { snapshot in
            var questions: [Question] = []
            
            for snap in snapshot.children {
                let question = Question(snapshot: snap as! DataSnapshot)
                questions.append(question)
            }
            
            completion(questions)
        })
    }
    
    // Responses
    class func fetchResponses(_ completion: @escaping ([Response]) -> Void) {
        let questionsRef = Database.database().reference(withPath: "responses").queryOrdered(byChild: "id_question")
        
        questionsRef.observe(.value, with: { snapshot in
            var responses: [Response] = []
            
            for snap in snapshot.children {
                let response = Response(snapshot: snap as! DataSnapshot)
                responses.append(response)
            }
            
            completion(responses)
        })
    }
    
    // Game Stats
    class func fetchGameStats(_ completion: @escaping ([GameStat]) -> Void) {
        let questionsRef = Database.database().reference(withPath: "scores").queryOrdered(byChild: "name_theme")
        
        questionsRef.observe(.value, with: { snapshot in
            
            var gameStats: [GameStat] = []
            
            for snap in snapshot.children {
                let gameStat = GameStat(snapshot: snap as! DataSnapshot)
                gameStats.append(gameStat)
            }
            
            completion(gameStats)
        })
    }
}




