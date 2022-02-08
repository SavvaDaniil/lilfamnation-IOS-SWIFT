//
//  AuthTabBarCustom.swift
//  LilFam NATION 3
//
//  Created by Daniil Savva on 19.01.2022.
//

import UIKit


class AuthTabBarCustom : UIView {
    
    public var tabButtons: [AuthTabButton] = []
    
    init(){
        super.init(frame: CGRect())
        
        self.backgroundColor = .black
        
    }
    
    required init(coder: NSCoder) {
        fatalError()
    }
    
    
    
    public func changeActiveTabButton(index: Int){
        tabButtons.forEach{authTabButton in
            authTabButton.setIsActive(newActive: false)
        }
        tabButtons[index].setIsActive(newActive: true)
    }
    
}
