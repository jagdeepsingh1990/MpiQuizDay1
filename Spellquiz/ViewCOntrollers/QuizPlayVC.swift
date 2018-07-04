//
//  QuizPlayVC.swift
//  Spellquiz
//
//  Created by Jagdeep on 02/07/18.
//  Copyright © 2018 biroke. All rights reserved.
//

import UIKit
import Lottie

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
    var timer = Timer()
    //lottie
    
     let animationView = LOTAnimationView(name: "checked_done_")
     let animationView2 = LOTAnimationView(name: "error")
    
    //ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        animationView.frame = CGRect(x: self.view.frame.size.width/2 - 60, y: self.view.frame.size.height/2 - 60, width: 120, height: 120)
        animationView2.frame =  CGRect(x: self.view.frame.size.width/2 - 60, y: self.view.frame.size.height/2 - 60, width: 120, height: 120)
        
        timer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
        
        updatequestion()
        updateUI()
        // Do any additional setup after loading the view.
    }
// timer action
    @objc func timerAction() {
       updatequestion()
        questionNumber += 1
    }
    // MARK: - Options Button
    
    
    
    @IBAction func answeredButton(_ sender: UIButton) {
        
       
        if sender.tag == selectedAnswer {
           // ProgressHUD.showSuccess("Correct")
             self.view.addSubview(animationView)
            animationView.play{ (finished) in
                DispatchQueue.main.async {
                    self.animationView.removeFromSuperview()

                }
            }
            score += 1
        }else{
            self.view.addSubview(animationView2)
            animationView2.play{ (finished) in
                DispatchQueue.main.async {
                    self.animationView2.removeFromSuperview()
                    
                }
            }
         //ProgressHUD.showError("Wrong")
        }
        //questionNumber += 1
       // updatequestion()
        
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
            timer.invalidate()
            let alertviewController = UIAlertController(title: "Great", message: "You have done with questions", preferredStyle: .alert)
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

