//
//  UIFormLabel.swift
//  LilFam NATION 3
//
//  Created by Daniil Savva on 20.01.2022.
//

import UIKit

class UIFormLabel : UILabel {
    
    init(text: String, size: Int = 16){
        super.init(frame: CGRect())
        
        self.text = text
        self.textColor = .white
        self.font = UIFont(name: GlobalVariables.fontGothamProLightSrc, size: 16)
        self.textAlignment = .left
    }
    
    required init?(coder: NSCoder) {
        fatalError("")
    }
}
