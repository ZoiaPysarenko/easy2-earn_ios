//
//  QuizCard.swift
//  Easy2Learn
//
//  Created by NB-JF on 22.05.20.
//  Copyright © 2020 NB-JF. All rights reserved.
//

import Foundation


class QuizCard{
    let category: Int
    let cardUrl: String
    let cardWord: String
    let quizAnswers: [String]
    
    var questImageUrl: URL?
    
    let congrMessage: String?
    let errorMessage: String?
    
    var isMediaInitialized: Bool
    
    init(category: Int, cardUrl: String, cardWord: String, quizAnswers: [String]){
        self.category = category
        self.cardUrl = cardUrl
        self.cardWord = cardWord
        let shufflesAnswers = quizAnswers.shuffled()
        self.quizAnswers = shufflesAnswers
        self.isMediaInitialized = false
        
        var congrMessages = ["Awesome!", "Amazing!", "Wonderful!", "Well done!", "Good job!", "Impressive", "Perfect!"]
        self.congrMessage = congrMessages.randomElement()
        
        var errorMessages = ["Uuups :(", "Try again", "Sorry. It's wrong", "Check again"]
        self.errorMessage = errorMessages.randomElement()

        FirebaseDataSource.shared.loadImage(topicId: category, imageName: cardUrl).downloadURL { (url, error) in
                   self.questImageUrl = url
                   self.isMediaInitialized = true
        }
        
    }
    
}
