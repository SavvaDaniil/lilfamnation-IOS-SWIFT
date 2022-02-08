//
//  ButtonDefault.swift
//  LilFam NATION 3
//
//  Created by Daniil Savva on 20.01.2022.
//

import UIKit


class ButtonDefault : UIButton {
    private var _text: String
    private var _label: UILabel?
    private var _isBlackColor: Bool
    
    init(_ text: String, _ isBlackColor: Bool = false){
        _text = text
        _isBlackColor = isBlackColor
        super.init(frame: CGRect())
        
        self.layer.borderColor = UIColor(white: (isBlackColor ? 0 : 1), alpha: 1).cgColor
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 5
        /*
        self.layer.shadowColor = GlobalVariables.activeColor.cgColor
        self.layer.shadowOpacity = 1
        self.layer.shadowOffset = .zero
        self.layer.shadowRadius = 5
        */
        
        _label = UILabel(frame: CGRect())
        _label!.text = text
        _label!.textColor = UIColor(white: (isBlackColor ? 0 : 1), alpha: 1)
        _label!.font = UIFont(name: GlobalVariables.fontGothamProLightSrc, size: 16)
        self.addSubview(_label!)
        _label!.translatesAutoresizingMaskIntoConstraints = false
        _label!.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        _label!.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("")
    }
    
    public func setCustomLabel(text: String){
        _text = text
        _label!.text = text
    }
    
    public func setActive(value: Bool){
        if value {
            self.layer.borderColor = UIColor(white: (_isBlackColor ? 0 : 1), alpha: 1).cgColor
            _label!.textColor = UIColor(white: (_isBlackColor ? 0 : 1), alpha: 1)
        } else {
            self.layer.borderColor = UIColor(red: 255/255, green: 0, blue: 0, alpha: 1).cgColor
            _label!.textColor = UIColor(red: 255/255, green: 0, blue: 0, alpha: 1)
        }
    }
}
