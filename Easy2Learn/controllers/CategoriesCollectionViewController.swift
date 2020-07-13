//
//  TopicsCollectionViewController.swift
//  Easy2Learn_V1
//
//  Created by NB-JF on 12.05.20.
//  Copyright © 2020 NB-JF. All rights reserved.
//

import UIKit

private let reuseIdentifier = "category-cell"

class CategoriesCollectionViewController: UICollectionViewController {
    
    var categories: [Category] = []
    var vocabularies: [Vocabulary] = []
    
    @IBAction func unwindToCategoriesMenu(_ sender: UIStoryboardSegue){}

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //get categories from DB
        FirebaseDataSource.shared.loadCategories { (categ) in
            self.categories = categ
            self.collectionView.reloadData()
        }
        
        //get all vocabularies from DB
        FirebaseDataSource.shared.loadVocabularies{ (vocab) in
            self.vocabularies = vocab
        }
        
        
        
        
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        //self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
    }
    

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return categories.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
    
        // Configure the cell
        if let cell = cell as? CategoryCollectionViewCell{
            cell.populate(with: categories[indexPath.row])
        }
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let curCategoryId = categories[indexPath.row].id
        var vocabulariesByCat: [Vocabulary] = []
        vocabulariesByCat = vocabularies.filter({ (voc) -> Bool in
            voc.category == curCategoryId
        })
        performSegue(withIdentifier: "category-dictionary", sender: vocabulariesByCat)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let dest = segue.destination as? DictionaryViewController,
              let vocabularies = sender as? [Vocabulary]
        else {return}
        
        dest.vocabularies = vocabularies
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
