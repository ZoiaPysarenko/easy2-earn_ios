//
//  MemoryCard.swift
//  Easy2Learn
//
//  Created by NB-JF on 14.05.20.
//  Copyright © 2020 NB-JF. All rights reserved.
//

import UIKit
import FirebaseStorage
import FirebaseUI

class MemoryCard{
    let cardId: Int
    let cardValue: String
    let isImage: Bool
    let category: Int
    var isCardShown: Bool
    var isVisible: Bool
    var isMediaInitialized: Bool
    
    var frontUrl: URL?
    var coverUrl: URL?
    
       
    
    init(cardId: Int, cardValue: String, isImage: Bool, category: Int){
        self.cardId = cardId
        self.cardValue = cardValue
        self.isImage = isImage
        self.category = category
        self.isCardShown = false
        self.isVisible = true
        self.isMediaInitialized = false
        
        if self.isImage{
            FirebaseDataSource.shared.loadImage(topicId: category, imageName: cardValue).downloadURL { (url, error) in
                self.frontUrl = url
            }
        }
        
        FirebaseDataSource.shared.loadImage(topicId: "general", imageName: "question").downloadURL { (url, error) in
            self.coverUrl = url
            self.isMediaInitialized = true
        }
    }
}

extension MemoryCard{
   
    //check if equals to current card
    func equals(to card: MemoryCard) -> Bool{
        return card.cardId == self.cardId
    }

  
}
