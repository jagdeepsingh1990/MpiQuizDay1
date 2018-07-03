//
//  QuestionModel.swift
//  Spellquiz
//
//  Created by Jagdeep on 02/07/18.
//  Copyright © 2018 biroke. All rights reserved.
//

import Foundation

class Question {
    let questionImage: String
    let questionText: String
    let optionA: String
    let optionB:String
    let optionC:String
    let optionD: String
    let correctAnswer: Int
    
    init(imgae :String,question:String,option_A:String,option_B:String,option_C:String,option_D:String,rightAnswer:Int) {
        questionImage = imgae
        questionText = question
        optionA = option_A
        optionB = option_B
        optionC = option_C
        optionD = option_D
        correctAnswer = rightAnswer
    }
}
