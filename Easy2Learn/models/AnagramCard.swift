//
//  AnagramCard.swift
//  Easy2Learn
//
//  Created by NB-JF on 19.05.20.
//  Copyright © 2020 NB-JF. All rights reserved.
//

import Foundation

class AnagramCard{
    let category: Int
    let cardWord: String
    let cardUrl: String
    var shuffledWord: String{
        shuffleWord(word: cardWord)
    }
    var defaultImageUrl: URL?
    var answerImageUrl: URL?
    
    let congrMessage: String?
    let errorMessage: String?
    
    var isMediaInitialized: Bool
    
    
    init(category: Int, cardWord: String, cardUrl: String){
        self.category = category
        self.cardWord = cardWord
        self.cardUrl = cardUrl
        self.isMediaInitialized = false
        
        var congrMessages = ["Awesome!", "Amazing!", "Wonderful!", "Well done!", "Good job!", "Impressive", "Perfect!"]
        self.congrMessage = congrMessages.randomElement()
        
        var errorMessages = ["Uuups :(", "Try again", "Sorry. It's wrong", "Check again"]
        self.errorMessage = errorMessages.randomElement()

        
        FirebaseDataSource.shared.loadImage(topicId: "general", imageName: "question2").downloadURL { (url, error) in
            self.defaultImageUrl = url
            self.isMediaInitialized = true
        }
        
        FirebaseDataSource.shared.loadImage(topicId: category, imageName: cardUrl).downloadURL { (url, error) in
            self.answerImageUrl = url
        }
    }
    
    func shuffleWord(word: String) -> String{
        var result = ""
        let shuffledItem = word.shuffled()
        for i in 0..<shuffledItem.count{
            result.append(shuffledItem[i])
        }
        if result != word{
            return result
        }else{
            return shuffleWord(word: word)
        }
        
    }
 
    
}


