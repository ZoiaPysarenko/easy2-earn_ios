//
//  DictionaryViewController.swift
//  Easy2Learn
//
//  Created by NB-JF on 13.05.20.
//  Copyright © 2020 NB-JF. All rights reserved.
//

import UIKit

class DictionaryViewController: UIViewController {
    
    var vocabularies: [Vocabulary]?
    
    @IBAction func startGamesButton(_ sender: UIButton) {
        
        
        //performSegue("")
        let sb = UIStoryboard(name: "Games", bundle: .main)
        if let vc = sb.instantiateViewController(withIdentifier: "GamesListViewController") as? GamesListViewController{
            vc.modalPresentationStyle = .fullScreen
            vc.vocabularies = self.vocabularies ?? []
            //present(vc, animated: true)
            self.navigationController?.pushViewController(vc, animated: true)
        }
        

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
        
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "vocabulary-gallery"{
            let dest = segue.destination as? VocabularyCollectionViewController
            dest?.vocabularies = vocabularies
        }
        
    }
}
