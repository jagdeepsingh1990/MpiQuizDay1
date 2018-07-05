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
    @IBOutlet weak var correctAnswerLabel: UILabel!
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
    let btnColor = UIColor(hex: 0x005D65)
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
        
        correctAnswerLabel.text = ""
         buttnColor()
        updatequestion()
        updateUI()
        // Do any additional setup after loading the view.
    }
// timer action
    @objc func timerAction() {
       
        
        questionNumber += 1
        buttnColor()
        updatequestion()
    }
    // MARK: - Options Button
    
    
    
    @IBAction func answeredButton(_ sender: UIButton) {
        
       
        if sender.tag == selectedAnswer {
            self.view.addSubview(animationView)
            animationView.play{ (finished) in
                DispatchQueue.main.async {
                    self.animationView.removeFromSuperview()

                }
            }
            score += 1
        }else{
            self.view.addSubview(animationView2)
             DispatchQueue.main.async {
            if self.option_A.tag == self.selectedAnswer {
                self.option_A.backgroundColor = UIColor.green
               self.correctAnswerLabel.text = self.option_A.titleLabel?.text
                
            } else if self.option_B.tag == self.selectedAnswer {
                self.option_B.backgroundColor = UIColor.green
                 self.correctAnswerLabel.text = self.option_B.titleLabel?.text
            } else if self.option_C.tag == self.selectedAnswer {
                self.option_C.backgroundColor = UIColor.green
                 self.correctAnswerLabel.text = self.option_C.titleLabel?.text
            } else {
               self.option_D.backgroundColor = UIColor.green
                self.correctAnswerLabel.text = self.option_D.titleLabel?.text
            }
            
            }
            
            animationView2.play{ (finished) in
                DispatchQueue.main.async {
                    self.animationView2.removeFromSuperview()
                    
                }
            }
        
        }
        buttondisable()
        
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
            
            buttonIsEnabled()
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
    
    
     // MARK: - buttons methods
    func buttonIsEnabled() {
        option_A.isEnabled = true
        option_B.isEnabled = true
        option_C.isEnabled = true
        option_D.isEnabled = true
    }
    
    func buttondisable() {
        option_A.isEnabled = false
        option_B.isEnabled = false
        option_C.isEnabled = false
        option_D.isEnabled = false
    }
    
    func buttnColor() {
            option_A.backgroundColor = btnColor
            option_B.backgroundColor = btnColor
            option_C.backgroundColor = btnColor
            option_D.backgroundColor = btnColor
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


extension UIColor {
    
    convenience init(hex: Int) {
        let components = (
            R: CGFloat((hex >> 16) & 0xff) / 255,
            G: CGFloat((hex >> 08) & 0xff) / 255,
            B: CGFloat((hex >> 00) & 0xff) / 255
        )
        self.init(red: components.R, green: components.G, blue: components.B, alpha: 1)
    }
    
}
