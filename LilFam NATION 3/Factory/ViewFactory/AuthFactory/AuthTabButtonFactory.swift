//
//  AuthTabButtonFactory.swift
//  LilFam NATION 3
//
//  Created by Daniil Savva on 19.01.2022.
//

import UIKit

class AuthTabButtonFactory {
    
    public func create(parentController: UIViewController, parentView: UIView, titleText: String, indexOfBtnFrom3: Int) -> AuthTabButton {
        let authTabButton = AuthTabButton(titleText: titleText, index: indexOfBtnFrom3, isActive: (indexOfBtnFrom3 == 0))
        
        if indexOfBtnFrom3 > 2 {
            fatalError("AuthTabButtonFactory только 3 кнопки предусмотрены")
        }
        
        let widthOfBtn: CGFloat = parentController.view.frame.width / 3
        
        parentController.view.addSubview(authTabButton)
        authTabButton.translatesAutoresizingMaskIntoConstraints = false
        authTabButton.topAnchor.constraint(equalTo: parentView.topAnchor).isActive = true
        authTabButton.bottomAnchor.constraint(equalTo: parentView.bottomAnchor).isActive = true
        authTabButton.widthAnchor.constraint(equalToConstant: widthOfBtn).isActive = true
        
        switch indexOfBtnFrom3 {
        case 0:
            authTabButton.leadingAnchor.constraint(equalTo: parentView.leadingAnchor).isActive = true
            break;
        case 1:
            authTabButton.centerXAnchor.constraint(equalTo: parentView.centerXAnchor).isActive = true
            break;
        case 2:
            authTabButton.trailingAnchor.constraint(equalTo: parentView.trailingAnchor).isActive = true
            break;
        default:
            break;
        }
        
        return authTabButton
    }
}
