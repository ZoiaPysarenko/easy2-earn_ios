//
//  GamesListViewController.swift
//  Easy2Learn
//
//  Created by NB-JF on 14.05.20.
//  Copyright © 2020 NB-JF. All rights reserved.
//

import UIKit

class GamesListViewController: UIViewController {
    
    var vocabularies: [Vocabulary]?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "memory-game"{
            let dest = segue.destination as? MemoryGameCollectionViewController
            dest?.vocabularies = vocabularies
        }
        else if segue.identifier == "anagram-game"{
            let dest = segue.destination as? AnagramGameCollectionViewController
            dest?.vocabularies = vocabularies
        }else if segue.identifier == "quiz-game"{
            let dest = segue.destination as? QuizGameCollectionViewController
            dest?.vocabularies = vocabularies
        }
        
    }
    


}
