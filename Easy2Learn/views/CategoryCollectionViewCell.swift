//
//  TopicCollectionViewCell.swift
//  Easy2Learn_V1
//
//  Created by NB-JF on 12.05.20.
//  Copyright © 2020 NB-JF. All rights reserved.
//

import UIKit
import FirebaseStorage
import FirebaseUI

class CategoryCollectionViewCell: UICollectionViewCell {
    
    var category: Category?
    
    @IBOutlet weak var categoryImageView: UIImageView!
    @IBOutlet weak var categoryNameLabel: UILabel!
    
    func populate(with category: Category){
        categoryNameLabel.text = category.name

        let ref = FirebaseDataSource.shared.loadImage(topicId: category.id, imageName: category.coverUrl)
        categoryImageView.sd_setImage(with: ref)
        
    
    }
}
