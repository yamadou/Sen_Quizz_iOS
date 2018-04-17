//
//  QuizzViewController.swift
//  XamXam
//
//  Created by Yamadou Traore on 4/13/18.
//  Copyright © 2018 com.yamadou. All rights reserved.
//
import UIKit
import NotificationBannerSwift

class QuizzViewController: UIViewController {

    // Mark: - Properties
    var remainingTime = 0
    var topic: Topic?
    var currentQuestion: Question?
    var currentQuestionResponses: [Response] = []
    var buttonTapped = UIButton()
    var goodAnswerButton = UIButton()
    var questions: [Question] = []
    var filteredQuestions: [Question] = []
    var responses: [Response] = []
    var banner: NotificationBanner?
    
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
            self.generateNewQuestion()
            
            DispatchQueue.main.async {
                self.setUpQuestionLabelAndAnswersBtn()
                self.showQuestion()
            }
        })
        
        remainingTime = 60
        let timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.m), userInfo: nil, repeats: true)
    }
    
    @objc private func m() {
        remainingTime -= 1
        
        if(remainingTime < 10) {
            remainingTimeLabel.textColor = UIColor.red
        }
        
        if(remainingTime == 0) {
            let vc = storyboard?.instantiateViewController(withIdentifier: "mmm")
            self.present(vc!, animated: false, completion: nil)
        }
        
        remainingTimeLabel.text = "\(remainingTime)"
    }

    // Mark: - @IBAction
    @IBAction func choiceADidTap(_ sender: Any) {
        buttonTapped = choiceAButton
        disableButtons()
        compareAnswers()
    }
    
    @IBAction func choiceBDidTap(_ sender: Any) {
        buttonTapped = choiceBbutton
        disableButtons()
        compareAnswers()
    }
    
    @IBAction func choiceCDidTap(_ sender: Any) {
        buttonTapped = choiceCbutton
        disableButtons()
        compareAnswers()
    }
    
    @IBAction func choiceDDidTap(_ sender: Any) {
        buttonTapped = choiceDButton
        disableButtons()
        compareAnswers()
    }
    
    @IBAction func dismiss(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // Mark: - API Calls
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
    
    // Mark: - Quizz Question & Responses
    private func generateNewQuestion() {
        let rand = Int(arc4random_uniform(UInt32(filteredQuestions.count)))
        
        currentQuestion = filteredQuestions[rand]
        currentQuestionResponses = responses.filter{ $0.questionUid == currentQuestion!.uid}
        
        filteredQuestions.remove(at: rand)
    }
    
    private func getGoodAnswerButton() -> UIButton {
        
        var idx = 0
        // store the index of the good Answer in the variable idx
        for response in currentQuestionResponses {
            if response.uid == currentQuestion?.goodAnswerUid {
                break
            }
            
            idx += 1
        }
        
        switch idx {
        case 0:
            return choiceAButton
        case 1:
            return choiceBbutton
        case 2:
            return choiceCbutton
        default:
            return choiceDButton
        }
    }
    
    private func compareAnswers() {
        
        goodAnswerButton = getGoodAnswerButton()
        
        if buttonTapped == goodAnswerButton {
            showCorrectAnswer()
            showBanner(title: "Bravo!", subtitle: "Super réponse!")
            
        } else {
            buttonTapped.backgroundColor = UIColor.red.withAlphaComponent(0.7)
            buttonTapped.layer.borderWidth = 0
            
            showBanner(title: "Dommage!", subtitle: "Pourtant, c'était facile!")
            
            var timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.showCorrectAnswer), userInfo: nil, repeats: false)
        }
    }
    
    @objc private func showCorrectAnswer() {
        goodAnswerButton.backgroundColor = UIColor.green.withAlphaComponent(0.7)
        goodAnswerButton.layer.borderWidth = 0
    }
    
    private func applyQuestionFilter() {
        filteredQuestions = questions.filter{ $0.topicUid == topic!.uid }
    }
    
    // Mark: - UI Set Up
    private func showQuestion() {
        questionLabel.isHidden = !questionLabel.isHidden
        answersStackView.isHidden = !answersStackView.isHidden
        activityIndicator.isAnimating ? activityIndicator.stopAnimating() : activityIndicator.startAnimating()
    }
    
    
    private func setUpQuestionLabelAndAnswersBtn() {
        questionLabel.text = currentQuestion?.question
        
        choiceAButton.setTitle(currentQuestionResponses[0].response, for: .normal)
        choiceBbutton.setTitle(currentQuestionResponses[1].response, for: .normal)
        choiceCbutton.setTitle(currentQuestionResponses[2].response, for: .normal)
        choiceDButton.setTitle(currentQuestionResponses[3].response, for: .normal)
        setUpButtons()
    }
    
    private func setUpButton(_ button: UIButton) {
        button.layer.borderWidth = 2
        button.isEnabled = true
        button.backgroundColor = UIColor.white
        button.layer.borderColor = UIColor(red: 22/255, green: 67/255, blue: 112/255, alpha: 1).cgColor
    }
    
    private func setUpButtons() {
        setUpButton(choiceAButton)
        setUpButton(choiceBbutton)
        setUpButton(choiceCbutton)
        setUpButton(choiceDButton)
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
        
        setUpButtons()
        
        banner = NotificationBanner(title: "", subtitle: "", style: .success, colors: CustomBannerColors())
        banner?.titleLabel?.textAlignment = .center
        banner?.subtitleLabel?.textAlignment = .center
    }
    
    private func disableButtons() {
        choiceAButton.isEnabled =  false
        choiceBbutton.isEnabled = false
        choiceCbutton.isEnabled = false
        choiceDButton.isEnabled = false
    }
    
    // Mark: - Banner
    private func showBanner(title: String, subtitle: String) {
        
        banner?.titleLabel?.text = title
        banner?.subtitleLabel?.text = subtitle
        
        banner?.show(bannerPosition: .bottom)
        let timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(self.dismissBanner), userInfo: nil, repeats: false)
    }
    
    @objc private func dismissBanner() {
        // Generate & show a new question after banner's been dismissed
        banner?.dismiss()
        
        generateNewQuestion()
        setUpQuestionLabelAndAnswersBtn()
    }
}


// Mark: - BannerColorsProtocol
class CustomBannerColors: BannerColorsProtocol {
    
    internal func color(for style: BannerStyle) -> UIColor {
        switch style {
        default:
            return UIColor(red: 22/255, green: 67/255, blue: 112/255, alpha: 1)
        }
    }
}


