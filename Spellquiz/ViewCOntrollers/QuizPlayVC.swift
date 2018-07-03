//
//  QuizPlayVC.swift
//  Spellquiz
//
//  Created by Jagdeep on 02/07/18.
//  Copyright © 2018 biroke. All rights reserved.
//

import UIKit

class QuizPlayVC: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var questionCounter: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var progressView: UIView!
    @IBOutlet weak var imageView: UIView!
    @IBOutlet weak var questionImg: UIImageView!
    @IBOutlet weak var questionLabel: UILabel!
    
     // MARK: - Options Buttons
    
    @IBOutlet weak var option_A: UIButton!
    @IBOutlet weak var option_B: UIButton!
    @IBOutlet weak var option_C: UIButton!
    @IBOutlet weak var option_D: UIButton!
    
     // MARK: - Variables
    let quizquestion5 = questionBank()
    var questionNumber:Int = 0
    var score:Int = 0
    var selectedAnswer:Int = 0
    
    //ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        updatequestion()
        updateUI()
        // Do any additional setup after loading the view.
    }

  
    // MARK: - Options Button
    
    
    
    @IBAction func answeredButton(_ sender: UIButton) {
        
        if sender.tag == selectedAnswer {
            ProgressHUD.showSuccess("Correct")
            score += 1
        }else{
         ProgressHUD.showError("Wrong")
        }
        questionNumber += 1
        updatequestion()
        
    }
    
    // MARK: - Methods
    func updatequestion() {
        if questionNumber <= quizquestion5.list.count  - 1{
            if (quizquestion5.list[questionNumber].questionImage) != "" {
            questionImg.image = UIImage(named: (quizquestion5.list[questionNumber].questionImage))
            }
            questionLabel.text = quizquestion5.list[questionNumber].questionText
            option_A.setTitle(quizquestion5.list[questionNumber].optionA, for: .normal)
            option_B.setTitle(quizquestion5.list[questionNumber].optionB, for: .normal)
            option_C.setTitle(quizquestion5.list[questionNumber].optionC, for: .normal)
            option_D.setTitle(quizquestion5.list[questionNumber].optionD, for: .normal)
            selectedAnswer = quizquestion5.list[questionNumber].correctAnswer
            
            self.updateUI()
            
        }else {
            let alertviewController = UIAlertController(title: "great", message: "You have done with question", preferredStyle: .alert)
            let alert = UIAlertAction(title: "Ok", style: .default , handler : { action in
                self.restartQuiz()
            })
            alertviewController.addAction(alert)
            self.present(alertviewController, animated: true, completion: nil)
        }
    }
    
    override func viewDidLayoutSubviews() {
        updateUI()
    }
    func updateUI() {
        DispatchQueue.main.async {
         
            self.scoreLabel.text = "Score : \(self.score)"
            self.questionCounter.text = "\(self.questionNumber + 1) / \(self.quizquestion5.list.count) "
            self.progressView.frame.size.width = (self.view.frame.size.width / CGFloat(self.quizquestion5.list.count)) * CGFloat(self.questionNumber + 1)
    
        }
    }
    func restartQuiz() {
        score = 0
        questionNumber = 0
        updatequestion()
        
    }
    
}

