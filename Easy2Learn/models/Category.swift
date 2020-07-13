//
//  Category.swift
//  Easy2Learn
//
//  Created by NB-JF on 12.05.20.
//  Copyright © 2020 NB-JF. All rights reserved.
//

import Foundation


class Category: FirebaseModel{
    
    let id: Int
    let name: String
    let coverUrl: String

    //From Object to JSON - for writing in DB
    var dict: [String : Any]{
        let dict = ["id": id,
                    "name": name,
                    "coverUrl": coverUrl
            ] as [String : Any]
        
        return dict
    }
    
    init(id: Int, name: String, coverUrl: String){
        self.coverUrl = coverUrl
        self.id = id
        self.name = name
    }
    
    //From JSON to Object - for reading from DB
    required init?(dict: [String : Any]) {
        guard let id = dict["id"] as? Int,
              let name = dict["name"] as? String,
              let coverUrl = dict["coverUrl"] as? String
            else{return nil}
        
        self.id = id
        self.name = name
        self.coverUrl = coverUrl
    }
    
    
    

}
