//
//  QuizCardCollectionViewCell.swift
//  Easy2Learn
//
//  Created by NB-JF on 22.05.20.
//  Copyright © 2020 NB-JF. All rights reserved.
//

import UIKit

class QuizCardCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    var cellCard: QuizCard?
    var btnClick: ((_ curScore: Int) -> Void)?
    var curScore: Int = 0
    
    
    @IBOutlet var answerButtons: [UIButton]!
    
    @IBAction func answerBtnTapped(_ sender: UIButton) {
        
        
        if sender.title(for: .normal) == cellCard?.cardWord{
            titleLabel.text = cellCard?.congrMessage
            titleLabel.textColor = UIColor(rgb: 0x10791E)
            
            sender.backgroundColor = UIColor(rgb: 0x10791E)
            self.curScore += 1
            
            for btn in answerButtons{
                btn.isEnabled = false
            }
            
        }else{
            titleLabel.text = cellCard?.errorMessage
            titleLabel.textColor = #colorLiteral(red: 0.8078431373, green: 0.02745098039, blue: 0.06666666667, alpha: 1)
            
            sender.backgroundColor =  #colorLiteral(red: 0.8078431373, green: 0.02745098039, blue: 0.06666666667, alpha: 1)
            for btn in answerButtons{
                if btn.title(for: .normal) == cellCard?.cardWord{
                    btn.backgroundColor = UIColor(rgb: 0x10791E)
                }
                btn.isEnabled = false
            }
            
        }

        self.btnClick?(self.curScore)
    
    }
    

    
    
    func populate(with card: QuizCard, score: Int, total: Int){
        self.cellCard = card
        self.curScore = score
        
        titleLabel.text = "Choose correct option"
        titleLabel.textColor = UIColor(rgb: 0x5D8ADB)
        
        scoreLabel.text = "\(score)/\(total)"
        
        imageView.sd_setImage(with: card.questImageUrl)
        
        for i in 0..<answerButtons.count{
            answerButtons[i].setTitle(card.quizAnswers[i], for: .normal)
            answerButtons[i].backgroundColor = UIColor(rgb: 0x5D8ADB)
            answerButtons[i].isEnabled = true
        }
    }
    
}
