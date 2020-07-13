//
//  VocabularyCollectionViewCell.swift
//  Easy2Learn
//
//  Created by NB-JF on 14.05.20.
//  Copyright © 2020 NB-JF. All rights reserved.
//

import UIKit

class VocabularyCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var vocabularyImageView: UIImageView!
    @IBOutlet weak var vocabularyWordLabel: UILabel!
    
    func populate(vocItem: Vocabulary){
        vocabularyWordLabel.text = vocItem.name
        
        let ref = FirebaseDataSource.shared.loadImage(topicId: vocItem.category, imageName: vocItem.url)
        vocabularyImageView.sd_setImage(with: ref)
    }
    
    
}
