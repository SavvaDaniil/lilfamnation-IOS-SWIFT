//
//  VisitPrepareTabButtonFactory.swift
//  LilFam NATION 3
//
//  Created by Daniil Savva on 30.01.2022.
//

import UIKit

class VisitPrepareTabButtonFactory {
    
    public func create(parentController: UIViewController, parentView: UIView, titleText: String, indexOfBtnFrom2: Int) -> VisitPrepareTabButton {
        let visitPrepareTabButton = VisitPrepareTabButton(titleText: titleText, index: indexOfBtnFrom2, isActive: (indexOfBtnFrom2 == 0))
        
        if indexOfBtnFrom2 > 1 {
            fatalError("AuthTabButtonFactory только 2 кнопки предусмотрены")
        }
        
        let widthOfBtn: CGFloat = parentController.view.frame.width / 2
        
        parentController.view.addSubview(visitPrepareTabButton)
        visitPrepareTabButton.translatesAutoresizingMaskIntoConstraints = false
        visitPrepareTabButton.topAnchor.constraint(equalTo: parentView.topAnchor).isActive = true
        visitPrepareTabButton.bottomAnchor.constraint(equalTo: parentView.bottomAnchor).isActive = true
        visitPrepareTabButton.widthAnchor.constraint(equalToConstant: widthOfBtn).isActive = true
        
        switch indexOfBtnFrom2 {
        case 0:
            visitPrepareTabButton.leadingAnchor.constraint(equalTo: parentView.leadingAnchor).isActive = true
            break;
        case 1:
            visitPrepareTabButton.trailingAnchor.constraint(equalTo: parentView.trailingAnchor).isActive = true
            break;
        default:
            break;
        }
        
        return visitPrepareTabButton
    }
}
