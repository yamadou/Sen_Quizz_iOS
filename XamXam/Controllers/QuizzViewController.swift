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
    var topic: Topic?
    var currentQuestion: Question?
    var currentQuestionResponses: [Response] = []
    var questions: [Question] = []
    var filteredQuestions: [Question] = []
    var responses: [Response] = []
    
    // Mark: - IBOutlets
    @IBOutlet weak var questionCountView: UIView!
    @IBOutlet weak var timerView: UIView!
    @IBOutlet weak var remainingTimeLabel: UILabel!
    @IBOutlet weak var questionCountLabel: UILabel!
    @IBOutlet weak var topicLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var choiceAButton: UIButton!
    @IBOutlet weak var choiceBbutton: UIButton!
    @IBOutlet weak var choiceCbutton: UIButton!
    @IBOutlet weak var choiceDButton: UIButton!
    @IBOutlet weak var answersStackView: UIStackView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpUI()
 
        fetchQuestions()
        fetchResponses(completion: {
            self.generateQuestion()
            DispatchQueue.main.async {
                self.showQuestion()
                self.showOrHideUIElements()
            }
        })
    }

    // Mark: - @IBAction
    @IBAction func choiceADidTap(_ sender: Any) {
        generateQuestion()
        showQuestion()
    }
    
    @IBAction func choiceBDidTap(_ sender: Any) {
        generateQuestion()
        showQuestion()
    }
    
    @IBAction func choiceCDidTap(_ sender: Any) {
        generateQuestion()
        showQuestion()
    }
    
    @IBAction func choiceDDidTap(_ sender: Any) {
        generateQuestion()
        showQuestion()
    }
    
    @IBAction func dismiss(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // Mark: - Private
    private func fetchQuestions() {
        WebService.fetchQuestions({ questions in
            self.questions = questions
            self.applyQuestionFilter()
        })
    }
    
    private func fetchResponses(completion: @escaping () -> Void) {
        WebService.fetchResponses({ responses in
            self.responses = responses
            completion()
        })
    }
    
    private func generateQuestion() {
        let rand = Int(arc4random_uniform(UInt32(filteredQuestions.count)))
        
        currentQuestion = filteredQuestions[rand]
        currentQuestionResponses = responses.filter{ $0.questionUid == currentQuestion!.uid}
        
        filteredQuestions.remove(at: rand)
        
    }
  
    private func showQuestion() {
        questionLabel.text = currentQuestion?.question
        choiceAButton.setTitle(currentQuestionResponses[0].response, for: .normal)
        choiceBbutton.setTitle(currentQuestionResponses[1].response, for: .normal)
        choiceCbutton.setTitle(currentQuestionResponses[2].response, for: .normal)
        choiceDButton.setTitle(currentQuestionResponses[3].response, for: .normal)
    }
    
  
    private func applyQuestionFilter() {
        filteredQuestions = questions.filter{ $0.topicUid == topic!.uid }
    }
  
    // Mark: - UI Set Up
    private func showOrHideUIElements() {
        questionLabel.isHidden = !questionLabel.isHidden
        answersStackView.isHidden = !answersStackView.isHidden
        activityIndicator.isAnimating ? activityIndicator.stopAnimating() : activityIndicator.startAnimating()
    }
    
    private func setUpButton(_ button: UIButton) {
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor(red: 22/255, green: 67/255, blue: 112/255, alpha: 1).cgColor
    }
    
    private func setpUpView(_ view: UIView) {
        view.layer.cornerRadius = 10
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    private func setUpUI() {
        topicLabel.text = topic!.name
        
        setpUpView(timerView)
        setpUpView(questionCountView)
        
        setUpButton(choiceAButton)
        setUpButton(choiceBbutton)
        setUpButton(choiceCbutton)
        setUpButton(choiceDButton)
    }
}
