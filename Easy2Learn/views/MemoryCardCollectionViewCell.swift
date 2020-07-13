//
//  MemoryCardCollectionViewCell.swift
//  Easy2Learn
//
//  Created by NB-JF on 15.05.20.
//  Copyright © 2020 NB-JF. All rights reserved.
//

import UIKit
import FirebaseUI

class MemoryCardCollectionViewCell: UICollectionViewCell {
    
    //var isMediaInitialized = false
    
    //didSet = once the button is not nil -> do
    @IBOutlet weak var memoryCardButton: UIButton!{
        //story board check box
        didSet{
            memoryCardButton.isUserInteractionEnabled = false
        }
    }
    
    @IBOutlet weak var coverButton: UIButton!{
        //story board check box
        didSet{
            coverButton.isUserInteractionEnabled = false
        }
    }
   
    
    func setMediaData(with card: MemoryCard){
        
        card.isMediaInitialized = true

       
    }
    
    
    //V3
    func populate(with card: MemoryCard){
        if !card.isCardShown{
            self.memoryCardButton.isHidden = true
            self.coverButton.isHidden = false
            self.coverButton.setTitle(nil, for: .normal)
            self.coverButton.sd_setBackgroundImage(with: card.coverUrl, for: .normal)
            UIView.transition(with: self, duration: 0.3, options: .transitionFlipFromRight, animations: nil, completion: nil)
        }else{
            if card.isVisible{
                self.coverButton.isHidden = true
                self.memoryCardButton.isHidden = false
                if card.isImage{
                    self.memoryCardButton.setTitle(nil, for: .normal)
                    self.memoryCardButton.sd_setBackgroundImage(with: card.frontUrl, for: .normal)
                    UIView.transition(with: self, duration: 0.3, options: .transitionFlipFromRight, animations: nil, completion: nil)
                }else{
                    self.memoryCardButton.setTitle(card.cardValue, for: .normal)
                    self.memoryCardButton.sd_setBackgroundImage(with: nil, for: .normal)
                    UIView.transition(with: self, duration: 0.3, options: .transitionFlipFromRight, animations: nil, completion: nil)
                }
                
            }else{
                self.coverButton.isHidden = true
                self.memoryCardButton.isHidden = true
            }

        }
    }
    
}
    



