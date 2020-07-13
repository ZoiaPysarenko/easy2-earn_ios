//
//  AnagramGameCollectionViewController.swift
//  Easy2Learn
//
//  Created by NB-JF on 19.05.20.
//  Copyright © 2020 NB-JF. All rights reserved.
//

import UIKit

private let reuseIdentifier = "anagram-cell"

class AnagramGameCollectionViewController: UICollectionViewController {
    
    var vocabularies: [Vocabulary]?
    var newGame: AnagramGame?
    var numberOfPages: Int = 0
    var currentPage: Int = 0
    

    override func viewDidLoad() {
        super.viewDidLoad()
 
        if let vocabularies = vocabularies as? [Vocabulary]{
            newGame = AnagramGame(vocs: vocabularies)
        }
        
        self.numberOfPages = newGame?.allCards.count ?? 0
        self.currentPage = 0
        
        
    }
    
    func checkIfImagesLoaded(for card: AnagramCard, at cell: AnagramCardCollectionViewCell){
        if !(card.isMediaInitialized){
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.checkIfImagesLoaded(for: card, at: cell)
            }
        }else{
            cell.populate(with: card)
        }
    }
    
    func openNextCard(){
        if currentPage < numberOfPages - 1{
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0){
                self.currentPage += 1
                let index = IndexPath.init(item: self.currentPage, section: 0)
                self.collectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
            }
            
        }else{
            print("Game Over")
            let popupService = PopupService()
            let popupVC = popupService.popup(title: "Congratulations!", imageName: "champion", secBtnTitle: "Replay"){
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
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return newGame?.allCards.count ?? 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
    
        // Configure the cell
        let emptyCell = AnagramCard(category: -1, cardWord: "",cardUrl: "")
        let currentCard = newGame?.allCards[indexPath.item] ?? emptyCell
        if let cell = cell as? AnagramCardCollectionViewCell{
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


extension AnagramGameCollectionViewController: UICollectionViewDelegateFlowLayout{
   
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
//        let size = UIScreen.main.bounds
//        return CGSize(width: size.width, height: size.height)
//    }
//
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets{
//        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat{
//        return 0
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat{
//
//        return 0
//    }
    
    
    
    
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize{}
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize{
//
//    }
    
    
}

