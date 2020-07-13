//
//  AnagramCardCollectionViewCell.swift
//  Easy2Learn
//
//  Created by NB-JF on 19.05.20.
//  Copyright © 2020 NB-JF. All rights reserved.
//

import UIKit

class AnagramCardCollectionViewCell: UICollectionViewCell {
   
    @IBOutlet weak var taskLabel: UILabel!
    @IBOutlet weak var shuffledWordLabel: UILabel!
    @IBOutlet weak var answerTextField: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var showHintButton: UIButton!
    @IBOutlet weak var checkAnswer: UIButton!
    
    var cellCard: AnagramCard?
    var btnClick: (()->Void)?
    

    @IBAction func showHintButton(_ sender: UIButton) {
        imageView.sd_setImage(with: cellCard?.answerImageUrl)
    }

    @IBAction func checkAnswer(_ sender: UIButton) {
        if answerTextField.text == cellCard?.cardWord{
            taskLabel.text = cellCard?.congrMessage
            taskLabel.textColor = UIColor(rgb: 0x10791E)
            imageView.sd_setImage(with: cellCard?.answerImageUrl)
            self.btnClick?()
        }else{
            taskLabel.text = cellCard?.errorMessage
            taskLabel.textColor = #colorLiteral(red: 0.8078431373, green: 0.02745098039, blue: 0.06666666667, alpha: 1) //CE0711
            taskLabel.font.withSize(36)
            
            answerTextField.text = ""
            answerTextField.layer.borderColor = #colorLiteral(red: 0.8078431373, green: 0.02745098039, blue: 0.06666666667, alpha: 1)
        }
    }

    func populate(with card: AnagramCard){
        taskLabel.text = "Guess word"
        taskLabel.textColor = UIColor(rgb: 0x5D8ADB)
        taskLabel.font.withSize(32)
        shuffledWordLabel.text = card.shuffledWord
        answerTextField.text = ""
        imageView.sd_setImage(with: card.defaultImageUrl)
        self.cellCard = card
        
    }
}
