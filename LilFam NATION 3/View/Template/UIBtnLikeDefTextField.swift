//
//  UIBtnLikeDefTextField.swift
//  LilFam NATION 3
//
//  Created by Daniil Savva on 20.01.2022.
//

import UIKit

class UIBtnLikeDefTextField : UIButton {
    
    private var _titleLabel: UILabel?
    
    init(titleText: String){
        super.init(frame: CGRect())
        
        //self.backgroundColor = .blue
        
        let fieldBorder = UIView(frame: CGRect())
        fieldBorder.backgroundColor = .gray
        self.addSubview(fieldBorder)
        fieldBorder.translatesAutoresizingMaskIntoConstraints = false
        fieldBorder.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 4).isActive = true
        fieldBorder.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        fieldBorder.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        fieldBorder.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        
        _titleLabel = UILabel(frame: CGRect())
        _titleLabel?.text = titleText
        _titleLabel?.textColor = .white
         self.addSubview(_titleLabel!)
        _titleLabel!.translatesAutoresizingMaskIntoConstraints = false
        _titleLabel!.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        _titleLabel!.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        _titleLabel!.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        _titleLabel!.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        
    }
    
    public func setCustomTitleText(text: String){
        _titleLabel?.text = text
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("")
    }
    
}

