//
//  Class5Questions.swift
//  Spellquiz
//
//  Created by Jagdeep on 02/07/18.
//  Copyright © 2018 biroke. All rights reserved.
//

import Foundation

class questionBank {
    var list = [Question]()
    init() {
        list.append(Question(imgae: "", question: "When driving to an unfamiliar area, you:", option_A: "can depend on road signs to help you find your way", option_B: "should use a map and plan your trip", option_C: "only have to know generally where your destination is", option_D: "should always choose the most direct route", rightAnswer: 2))
        list.append(Question(imgae: "", question: "Which of the following influences your driving actions most?", option_A: "your experience", option_B: "your age", option_C: "your attitude towards driving", option_D: "your reaction time", rightAnswer: 3))
        list.append(Question(imgae: "RoadSign_11", question: "This sign means:", option_A: "municipal road ends", option_B: "road ends - exit right or left ", option_C: "roads meet", option_D: "overpass ahead", rightAnswer: 2))
        
        
        list.append(Question(imgae: "RoadSign_12", question: "This sign means:", option_A: "slippery when wet", option_B: "bridge ahead", option_C: "broken road surface", option_D: " bump ahead", rightAnswer: 4))
    }
}
