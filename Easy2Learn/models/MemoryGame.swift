//
//  MemoryGame.swift
//  Easy2Learn
//
//  Created by NB-JF on 15.05.20.
//  Copyright © 2020 NB-JF. All rights reserved.
//

import UIKit


class MemoryGame{
    var pack: [MemoryCard]
    var cardsShown: [MemoryCard]
    var isPlaying: Bool
    var lastClicked: Int
    var openedCards: Int
    
    init(vocs: [Vocabulary]){
        
        func fillCardsPack(vocs: [Vocabulary]){
            for i in 0..<vocs.count{
                let wordCard = MemoryCard(cardId: vocs[i].id, cardValue: vocs[i].word, isImage: false, category: vocs[i].category)
                let imageCard = MemoryCard(cardId: vocs[i].id, cardValue: vocs[i].url, isImage: true, category: vocs[i].category)
                self.pack.append(wordCard)
                self.pack.append(imageCard)
            }
        }
        
        self.pack = []
        self.cardsShown = []
        self.isPlaying = false
        self.lastClicked = -1
        self.openedCards = 0
        
        fillCardsPack(vocs: vocs)
        startGame()
    }
    

    
}

extension MemoryGame{
    
    func shufflePack(){
        self.pack = pack.shuffled()
    }

    func startGame(){
        self.cardsShown = []
        for i in 0..<pack.count{
            pack[i].isVisible = true
            pack[i].isCardShown = false
        }
        shufflePack()  
        self.isPlaying = true
    }
    
    func cardClicked(at position: Int, card clickedCard: MemoryCard, callback: @escaping (_ index1: Int, _ index2: Int) -> Void){
        
        if !clickedCard.isVisible{
            return
        }
        
        if openedCards < 2{
            //if not the same card
            if position != lastClicked{
                self.lastClicked = position
                clickedCard.isCardShown = true
                openedCards += 1
                if cardsShown.count % 2 == 0{
                    self.cardsShown.append(clickedCard)
                }else{
                    checkIfMatched(card: clickedCard, at: position, callback: callback)
                }
            }else{
                self.lastClicked = -1
                clickedCard.isCardShown = false
                self.cardsShown.removeLast()
                openedCards -= 1
            }
            
            callback(position, -1)
        }
    }
    
    func checkIfMatched(card clickedCard: MemoryCard, at secElemPosition: Int, callback: @escaping (_ index1: Int, _ index2: Int) -> Void){
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            if clickedCard.equals(to: self.cardsShown[self.cardsShown.count - 1]){
                 
                 self.cardsShown[self.cardsShown.count - 1].isVisible = false
                 clickedCard.isVisible = false
                
                let idx1 = self.pack.firstIndex { (card) -> Bool in
                    return card.cardId ==  self.cardsShown[self.cardsShown.count - 1].cardId  && card.isImage == self.cardsShown[self.cardsShown.count - 1].isImage
                }
                
                 self.cardsShown.append(clickedCard)
                 self.openedCards = 0
                 self.lastClicked = -1

                callback(idx1 ?? -1, secElemPosition)
                
                
                
            }else{
                 self.cardsShown[self.cardsShown.count - 1].isCardShown = false
                 clickedCard.isCardShown = false
                
                 let idx1 = self.pack.firstIndex { (card) -> Bool in
                     return card.cardId ==  self.cardsShown[self.cardsShown.count - 1].cardId  && card.isImage == self.cardsShown[self.cardsShown.count - 1].isImage
                 }
                
                 self.cardsShown.removeLast()
                 self.openedCards = 0
                 self.lastClicked = -1
                
                 callback(idx1 ?? -1, secElemPosition)
                
                
             }
        }
    }
    
    

}


   //1. if isPlaying == true{
    //2. if cardsShown.count != pack.count && cardsShown.count == 0 shuffle
        //3.  //when we click on Card: check if 1st or 2nd card
          //if 2nd:  // is not the same card
                     //check if equal
                     //close or leave open, //if equal - leave open, if not - close both and remove from cardsShownList
    //2. else isPlayng = false, finish the game,
                        
//}
    
        
       //isEqual - packShown.removeLast()
//       func isEqual(_ secCard: MemoryCard) -> Bool{
//           return secCard.cardId == cardId //????
//       }
