//
//  PopupViewController.swift
//  Easy2Learn
//
//  Created by NB-JF on 18.05.20.
//  Copyright © 2020 NB-JF. All rights reserved.
//

import UIKit

class PopupViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var secondButton: UIButton!
    
    
    var popupTitle = String()
    var popupImageName = String()
    var secondButtonTitle = String()
    
    var secondButtonAction: (() -> Void)?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
    }
    
    func setupView(){
        titleLabel.text = popupTitle
        secondButton.setTitle(secondButtonTitle, for: .normal)
        
        FirebaseDataSource.shared.loadImage(topicId: "general", imageName: popupImageName).downloadURL { (url, error) in
            self.imageView.sd_setImage(with: url)
        }
    }
    
    @IBAction func didTapMenuButton(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    @IBAction func didTapReplayButton(_ sender: UIButton) {
        dismiss(animated: true)
        
        secondButtonAction?()
    }

}

