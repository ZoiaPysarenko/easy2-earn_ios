//
//  DatabaseModel.swift
//  Easy2Learn
//
//  Created by NB-JF on 12.05.20.
//  Copyright © 2020 NB-JF. All rights reserved.
//

import Foundation
import FirebaseDatabase
//import FirebaseStorage

class FirebaseDataSource{
    var categories: [Category] = []
    var vocabularies: [Vocabulary] = []
    
    private init(){}
    
    static let shared = FirebaseDataSource()
    
//    init(categories: [Category], vocabularies: [Vocabulary]){
//        self.categories = categories
//        self.vocabularies = vocabularies
//    }
}

extension FirebaseDataSource{
    static var categoriesRef: DatabaseReference{
        return Database.database().reference().child("categories")
    }
    
    static var vocabulariesRef: DatabaseReference{
        return Database.database().reference().child("vocabularies")
    }
    
    func loadTopics(callback: @escaping ([Category]) -> Void){
        FirebaseDataSource.categoriesRef.observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSArray ?? []
            var topics: [Category] = []
            
            for i in 0..<value.count{
                guard let categoryDict = value[i] as? [String : Any],
                      let category = Category(dict: categoryDict)
                    else{return}
                topics.append(category)
            }
            
            callback(topics)
            
        }){
            (error) in
            print(error.localizedDescription)
        }
    }

}



