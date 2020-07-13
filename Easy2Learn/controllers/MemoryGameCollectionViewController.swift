//
//  MemoryGameCollectionViewController.swift
//  Easy2Learn
//
//  Created by NB-JF on 14.05.20.
//  Copyright © 2020 NB-JF. All rights reserved.
//

import UIKit

private let reuseIdentifier = "memory-card-cell"

class MemoryGameCollectionViewController: UICollectionViewController {

    var vocabularies: [Vocabulary]?
    var newGame: MemoryGame?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let layout = collectionViewLayout as? UICollectionViewFlowLayout else {return}
        let w = collectionView.frame.size.width / 3
        layout.sectionInset = .init(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumInteritemSpacing = 0
        layout.itemSize = CGSize(width: w, height: w)
        
        if let vocabularies = vocabularies as? [Vocabulary]{
            newGame = MemoryGame(vocs: vocabularies)
        }
        

        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return newGame?.pack.count ?? 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)        
    
        // Configure the cell
        if let cell = cell as? MemoryCardCollectionViewCell{
            
            let emptyCard: MemoryCard = MemoryCard(cardId: -1, cardValue: "", isImage: false, category: -1)
            let currentCard = newGame?.pack[indexPath.row] ?? emptyCard
            checkIfImagesLoaded(for: currentCard, at: cell)
            
            cell.populate(with: currentCard)
        }        
        
        return cell
    }
    
    
    func checkIfImagesLoaded(for card: MemoryCard, at cell: MemoryCardCollectionViewCell){
        if !(card.isMediaInitialized){
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.checkIfImagesLoaded(for: card, at: cell)
            }
        }else{
            cell.populate(with: card)
        }
    }
  
    
    
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            newGame?.cardClicked(at: indexPath.item,
                                 card: newGame?.pack[indexPath.item] ?? MemoryCard(cardId: -1,
                                                                                   cardValue: "",
                                                                                   isImage: false,
                                                                                   category: -1),
        
        
                                     callback: checkIfReloadCallback(index1:index2:))

    }
    
    func checkIfReloadCallback(index1 ind1: Int, index2 ind2: Int){
        var paths: [IndexPath] = []
        if ind2 != -1 {
            let path2 = IndexPath(item: ind2, section: 0)
            paths.append(path2)
        }
        if ind1 != -1{
            let path1 = IndexPath(item: ind1, section: 0)
            paths.append(path1)
        }
        collectionView.reloadItems(at: paths)
        
        if newGame?.cardsShown.count == newGame?.pack.count{
            newGame?.isPlaying = false
            print("Game Over")
            let popupService = PopupService()
            let popupVC = popupService.popup(title: "Congratulations!", imageName: "champion", secBtnTitle: "Replay"){
                //TODO: restart the game
                self.newGame?.startGame()
                self.collectionView.reloadData()
            }
            
            present(popupVC, animated: true)
            
        }
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


