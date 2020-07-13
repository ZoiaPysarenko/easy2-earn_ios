//
//  Vocabulary.swift
//  Easy2Learn
//
//  Created by NB-JF on 12.05.20.
//  Copyright © 2020 NB-JF. All rights reserved.
//

import Foundation

class Vocabulary: FirebaseModel{
    
    let category: Int
    let id: Int
    let name: String
    let quiz: [String]
    let url: String
    let word: String
    
    var dict: [String : Any]{
        let dict = ["category": category,
                    "id": id,
                    "name": name,
                    "quiz": quiz,
                    "url": url,
                    "word": word
            ] as [String : Any]
        
        return dict
    }
    
    init(category: Int, id: Int, name: String, quiz: [String], url: String, word: String){
        self.category = category
        self.id = id
        self.name = name
        self.quiz = quiz
        self.url = url
        self.word = word
    }

    required init?(dict: [String : Any]) {
        guard let category = dict["category"] as? Int,
              let id = dict["id"] as? Int,
              let name = dict["name"] as? String,
              let quiz = dict["quiz"] as? [String],
              let url = dict["url"] as? String,
              let word = dict["word"] as? String
            else {return nil}
        
        self.category = category
        self.id = id
        self.name = name
        self.quiz = quiz
        self.url = url
        self.word = word
    }

}
