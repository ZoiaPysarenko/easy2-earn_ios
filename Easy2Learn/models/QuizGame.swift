//
//  QuizGame.swift
//  Easy2Learn
//
//  Created by NB-JF on 22.05.20.
//  Copyright © 2020 NB-JF. All rights reserved.
//

import Foundation

class QuizGame{
    var allCards: [QuizCard]
    var score: Int
     
    init(vocs: [Vocabulary]){
        
        func fillAllCards(vocs: [Vocabulary]){
            for i in 0..<vocs.count{
                let card = QuizCard(category: vocs[i].category, cardUrl: vocs[i].url, cardWord: vocs[i].word, quizAnswers: vocs[i].quiz)
                self.allCards.append(card)
            }
        }
        
        self.allCards = []
        self.score = 0
        
        fillAllCards(vocs: vocs)
        
    }
}

extension QuizGame{
    //shuffleThePack
    func shufflePack(){
        self.allCards = allCards.shuffled()
    }
    
    //start the game
    func startGame(){
        shufflePack()
        score = 0
    }
}
