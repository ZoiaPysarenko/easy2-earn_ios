//
//  DatabaseModel.swift
//  Easy2Learn
//
//  Created by NB-JF on 12.05.20.
//  Copyright © 2020 NB-JF. All rights reserved.
//

import Foundation
import FirebaseDatabase
import FirebaseStorage

class FirebaseDataSource{
    var categories: [Category] = []
    var vocabularies: [Vocabulary] = []
    
    private init(){}
    
    static let shared = FirebaseDataSource()
    
}

extension FirebaseDataSource{
    static var categoriesRef: DatabaseReference{
        return Database.database().reference().child("categories")
    }
    
    static var vocabulariesRef: DatabaseReference{
        return Database.database().reference().child("vocabularies")
    }
    
    //Storage of images
    var imageRef: StorageReference{
//        return Storage.storage().reference().child("images").child(topicId).child(imgName + ".jpg")
        return Storage.storage().reference().child("images")
    }
}

extension FirebaseDataSource{
    
    func loadImage(topicId: Any, imageName: String) -> StorageReference{
        return imageRef.child("\(topicId)").child(imageName + ".jpg")
    }
    
  
    func loadCategories(callback: @escaping ([Category]) -> Void){
        FirebaseDataSource.categoriesRef.observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSArray ?? []
            var categories: [Category] = []
            
            for i in 0..<value.count{
                guard let categoryDict = value[i] as? [String : Any],
                      let category = Category(dict: categoryDict)
                    else{return}
                categories.append(category)
            }
            
            callback(categories)
            
        }){
            (error) in
            print(error.localizedDescription)
        }
    }
    
    func loadVocabularies(callback: @escaping ([Vocabulary]) -> Void){
        FirebaseDataSource.vocabulariesRef.observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSArray ?? []
            var vocabularies: [Vocabulary] = []
            for i in 0..<value.count{
                guard let vocabularyDict = value[i] as? [String : Any],
                      let vocabularyItem = Vocabulary(dict: vocabularyDict)
                    else {return}
                vocabularies.append(vocabularyItem)
            }
            callback(vocabularies)
        }){
            (error) in
            print(error.localizedDescription)
        }
    }
    
    
}


