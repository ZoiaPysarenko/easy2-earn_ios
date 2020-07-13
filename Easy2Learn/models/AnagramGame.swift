//
//  AnagramGame.swift
//  Easy2Learn
//
//  Created by NB-JF on 19.05.20.
//  Copyright © 2020 NB-JF. All rights reserved.
//

import Foundation

class AnagramGame{
    var allCards: [AnagramCard]
     
    init(vocs: [Vocabulary]){
        
        func fillAllCards(vocs: [Vocabulary]){
            for i in 0..<vocs.count{
                let card = AnagramCard(category: vocs[i].category, cardWord: vocs[i].word, cardUrl: vocs[i].url)
                self.allCards.append(card)
            }
        }
        
        self.allCards = []
        
        fillAllCards(vocs: vocs)
        
    }

}

extension AnagramGame{
    
    //shuffleThePack
    func shufflePack(){
        self.allCards = allCards.shuffled()
    }
    
    //start the game
    func startGame(){
        shufflePack()
    }
  
    
    
}
