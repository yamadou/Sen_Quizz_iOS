//
//  QuizzViewController.swift
//  XamXam
//
//  Created by Yamadou Traore on 4/13/18.
//  Copyright © 2018 com.yamadou. All rights reserved.
//

import UIKit

class QuizzViewController: UIViewController {

    // Mark: - Properties
    var topicUid = ""
    var questions: [Question] = []
    var filteredQuestions: [Question] = []
    var responses: [Response] = []
    var filteredResponses: [Response] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchQuestions()
        fetchResponses()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if questions.count != 0 {
            applyFilter()
        }
    }
    
    // Mark: - Private
    private func fetchQuestions() {
        WebService.fetchQuestions({ questions in
            self.questions = questions
            self.applyFilter()
        })
    }
    
    private func fetchResponses() {
        WebService.fetchResponses({ responses in
            self.responses = responses
        })
    }
    
    @IBAction func dismiss(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    private func applyFilter() {
        filteredQuestions = questions.filter{ $0.topicUid == topicUid }
    }
}
