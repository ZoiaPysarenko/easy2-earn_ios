//
//  QuizGameCollectionViewController.swift
//  Easy2Learn
//
//  Created by NB-JF on 22.05.20.
//  Copyright © 2020 NB-JF. All rights reserved.
//

import UIKit

private let reuseIdentifier = "quiz-cell"

class QuizGameCollectionViewController: UICollectionViewController {
    
    var vocabularies: [Vocabulary]?
    var newGame: QuizGame?
    var numberOfPages: Int = 0
    var currentPage: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let vocabularies = vocabularies as? [Vocabulary]{
            newGame = QuizGame(vocs: vocabularies)
        }
        
        self.numberOfPages = newGame?.allCards.count ?? 0
        self.currentPage = 0

    }

    func checkIfImagesLoaded(for card: QuizCard, at cell: QuizCardCollectionViewCell){
        if !(card.isMediaInitialized){
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.checkIfImagesLoaded(for: card, at: cell)
            }
        }else{
            let score = self.newGame?.score ?? 0
            cell.populate(with: card, score: score, total: self.newGame?.allCards.count ?? 0)
        }
    }
    
    
    func openNextCard(_ curScore: Int){
        self.newGame?.score = curScore
        if currentPage < numberOfPages - 1{
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0){
                self.currentPage += 1
                let index = IndexPath.init(item: self.currentPage, section: 0)
                self.collectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
                self.collectionView.reloadItems(at: [index])
            }
            
            
        }else{
            let popupService = PopupService()
            var result = ""
            if let score = self.newGame?.score,
                let total = self.newGame?.allCards.count{
                result = "\(score) out of \(total)"
            }
            
            
            
            let popupVC = popupService.popup(title: result, imageName: "champion", secBtnTitle: "Replay"){
                self.newGame?.startGame()
                self.collectionView.reloadData()
                self.currentPage = 0
                let index = IndexPath.init(item: self.currentPage, section: 0)
                self.collectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
                
            }
            
            present(popupVC, animated: true)
        }
    }
    

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return newGame?.allCards.count ?? 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
    
        // Configure the cell
        let emptyCell = QuizCard(category: -1, cardUrl: "", cardWord: "", quizAnswers: [""])
        let currentCard = newGame?.allCards[indexPath.item] ?? emptyCell
        if let cell = cell as? QuizCardCollectionViewCell{
            checkIfImagesLoaded(for: currentCard, at: cell)
            cell.btnClick = openNextCard
            
        }
        return cell
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
