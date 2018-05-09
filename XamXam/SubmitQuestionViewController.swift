//
//  SubmitQuestionViewController.swift
//  XamXam
//
//  Created by Yamadou Traore on 5/8/18.
//  Copyright © 2018 com.yamadou. All rights reserved.
//

import UIKit

class SubmitQuestionViewController: UIViewController {

    // Mark: IBOutlet
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var questionTextfield: UITextField!
    @IBOutlet weak var responseATextField: UITextField!
    @IBOutlet weak var responseBTextField: UITextField!
    @IBOutlet weak var responseCTextField: UITextField!
    @IBOutlet weak var responseDTextField: UITextField!
    @IBOutlet weak var responseASwitch: UISwitch!
    @IBOutlet weak var responseBSwitch: UISwitch!
    @IBOutlet weak var responseCSwitch: UISwitch!
    @IBOutlet weak var responseDSwitch: UISwitch!
    @IBOutlet weak var cardTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var cardBottomConstraint: NSLayoutConstraint!
    
    // Mark: Properties
    var topic: Topic?
    var question = ""
    var correctAnswer = ""
    var goodAnswerIndex = 0
    var responses: [String] = []
    var cardTopConstraintConstant: CGFloat!
    var cardBottomConstraintConstant: CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUp(questionTextfield)
        setUp(responseATextField)
        setUp(responseBTextField)
        setUp(responseCTextField)
        setUp(responseDTextField)
        
        titleLabel.text = topic?.name
        
        submitButton.layer.masksToBounds = true
        submitButton.layer.cornerRadius = 10
        submitButton.isEnabled = false
        submitButton.backgroundColor = UIColor.gray
        
        cardTopConstraintConstant = cardTopConstraint.constant
        cardBottomConstraintConstant = cardBottomConstraint.constant
        
        addTapGestureTo(view: self.view, selector: #selector(closeWindow))
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        questionTextfield.resignFirstResponder()
        responseATextField.resignFirstResponder()
        responseBTextField.resignFirstResponder()
        responseCTextField.resignFirstResponder()
        responseDTextField.resignFirstResponder()
    }
    
    // Mark: - Private
    private func setUp(_ textfield: UITextField) {
        textfield.delegate = self
        
        textfield.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        
        textfield.layer.masksToBounds = true
        textfield.layer.borderWidth = 0.5
        textfield.layer.cornerRadius = 15
        textfield.layer.borderColor = UIColor(red: 22/255, green: 67/255, blue: 112/255, alpha: 1).cgColor
    }
    
    private func correctAnswerIsChecked() -> Bool {
        if responseASwitch.isOn, let correctAnswer = responseATextField.text{
            self.correctAnswer = correctAnswer
            goodAnswerIndex = 0
            return true
        } else if responseBSwitch.isOn, let correctAnswer = responseBTextField.text {
            self.correctAnswer = correctAnswer
            goodAnswerIndex = 1
            return true
        } else if responseCSwitch.isOn, let correctAnswer = responseCTextField.text{
            self.correctAnswer = correctAnswer
            goodAnswerIndex = 2
            return true
        } else if responseDSwitch.isOn, let correctAnswer = responseDTextField.text{
            self.correctAnswer = correctAnswer
            goodAnswerIndex = 3
            return true
        }
        
        return false
    }
    
    private func switchesCheckedCount() -> Int {
        var count = 0
        if responseASwitch.isOn {
            count += 1
        }
        if responseBSwitch.isOn {
            count += 1
        }
        if responseCSwitch.isOn {
            count += 1
        }
        if responseDSwitch.isOn {
            count += 1
        }
        
        return count
    }
    
    private func showAlert(title: String, handler: @escaping ((UIAlertAction) -> Void)) {
        let alertController = UIAlertController(title: title, message: "", preferredStyle: .alert)
        
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: handler)
        alertController.addAction(defaultAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    private func stayOnPage(action: UIAlertAction){
    }
    
    @objc private func closeWindow(action: UIAlertAction){
        self.dismiss(animated: false, completion: nil)
    }
    
//    @objc private func closeWindow() {
//        self.dismiss(animated: false, completion: nil)
//    }
    
    // Mark: IBAction
    @IBAction func submitFormDidTap(_ sender: Any) {
        guard correctAnswerIsChecked() else {
            showAlert(title: "Sélectionnez la bonne réponse svp!", handler: stayOnPage)
            return
        }
        
        guard switchesCheckedCount() == 1 else {
            showAlert(title: "Sélectionnez une seule bonne réponse svp!", handler: stayOnPage)
            return
        }
        
        // Save Question object && get its id from firebase
        var question = Question(topicUid: (topic?.uid)!, question: self.question)
        var questionUid = question.submitQuestion()
        
        // Save Response objects && get their ids from firebase
        for idx in 0...3 {
            var response = Response(questionUid: questionUid, response: responses[idx])
            var responseUid = response.submitResponse()
            
            if idx == goodAnswerIndex {
                // update good_answer_id field of question
                question.update(goodAnswerUid: responseUid)
            }
        }
        
        showAlert(title: "Merci, votre question a été enregistré avec succès.", handler: closeWindow)
    }
    
    // Mark: Selectors
    @objc private func editingChanged(_ textField: UITextField) {
        if textField.text?.characters.count == 1 {
            if textField.text?.characters.first == " " {
                textField.text = ""
                return
            }
        }
        guard
            let question = questionTextfield.text, question != "",
            let responseA = responseATextField.text, responseA != "",
            let responseB = responseBTextField.text, responseB != "",
            let responseC = responseCTextField.text, responseC != "",
            let responseD = responseDTextField.text, responseD != ""
            else {
                submitButton.isEnabled = false
                submitButton.backgroundColor = UIColor.gray
                return
        }
        
        self.question = question
        
        responses.removeAll()
        
        responses.append(responseA)
        responses.append(responseB)
        responses.append(responseC)
        responses.append(responseD)
        
        submitButton.isEnabled = true
        submitButton.backgroundColor = UIColor(red: 22/255, green: 67/255, blue: 112/255, alpha: 1)
    }
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        
        if let info = notification.userInfo {
            
            let rect: CGRect = info["UIKeyboardFrameEndUserInfoKey"] as! CGRect
            
            self.view.layoutIfNeeded()
            
            UIView.animate(withDuration: 0.25, animations: {
                
                self.view.layoutIfNeeded()
                self.cardBottomConstraint.constant = rect.height + 2
                self.cardTopConstraint.constant = 8
            })
        }
    }
    
    @objc private func keyboardWillHide() {
        self.view.layoutIfNeeded()
        
        UIView.animate(withDuration: 0.25, animations: {
            
            self.view.layoutIfNeeded()
            self.cardBottomConstraint.constant = self.cardBottomConstraintConstant
            self.cardTopConstraint.constant = self.cardTopConstraintConstant
        })
    }
}

// Mark: UITextFieldDelegate
extension SubmitQuestionViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
}

extension SubmitQuestionViewController: UIGestureRecognizerDelegate {
    
    // Mark: - UIGestureRecognizerDelegate
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if touch.view == self.view {
            return true
        }
        return false
    }
    
    // Mark: - Private
    private func addTapGestureTo(view: UIView, selector: Selector){
        let tapGesture = UITapGestureRecognizer(target: self, action: selector)
        tapGesture.delegate = self
        tapGesture.numberOfTapsRequired = 1
        tapGesture.numberOfTouchesRequired = 1
        
        view.addGestureRecognizer(tapGesture)
        view.isUserInteractionEnabled = true
    }
}

