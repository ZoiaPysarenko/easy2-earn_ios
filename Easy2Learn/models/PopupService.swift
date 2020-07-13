//
//  PopupService.swift
//  Easy2Learn
//
//  Created by NB-JF on 18.05.20.
//  Copyright © 2020 NB-JF. All rights reserved.
//

import UIKit

class PopupService{
    
    func popup(title: String, imageName: String, secBtnTitle: String, completion secBtnAction: @escaping () -> Void) -> PopupViewController{
        
        let sb = UIStoryboard(name: "Popup", bundle: .main)
        let popupVC = sb.instantiateViewController(withIdentifier: "PopupViewController") as! PopupViewController
        
        popupVC.popupTitle = title
        popupVC.popupImageName = imageName
        popupVC.secondButtonTitle = secBtnTitle
        
        popupVC.secondButtonAction = secBtnAction
        
        
        return popupVC
    }
    
}
