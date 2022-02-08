//
//  UITextFieldDefault.swift
//  LilFam NATION 3
//
//  Created by Daniil Savva on 20.01.2022.
//

import UIKit


class UITextFieldDefault : UITextField {
    
    init(_ placeholder: String, _ keyboardType: UIKeyboardType, _ secureTextEntry: Bool = false){
        super.init(frame: CGRect())
        
        self.textColor = .white
        //self.backgroundColor = .white
        
        self.attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: [NSAttributedString.Key.foregroundColor: UIColor(white: 1, alpha: 0.3)]
        )
        self.font = UIFont(name: GlobalVariables.fontGothamProLightSrc, size: 20)
        //self.borderStyle = UITextField.BorderStyle.roundedRect
        self.borderStyle = .none
        self.autocorrectionType = UITextAutocorrectionType.no
        //fieldLogin.keyboardType = UIKeyboardType.default
        self.keyboardType = keyboardType
        self.isSecureTextEntry = secureTextEntry
        
        self.returnKeyType = UIReturnKeyType.done
        self.clearButtonMode = UITextField.ViewMode.whileEditing
        self.contentVerticalAlignment = .center
        //fieldLogin.bounds.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
        //self.bounds.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 4, right: 0))
        
        let fieldBorder = UIView(frame: CGRect())
        fieldBorder.backgroundColor = .gray
        self.addSubview(fieldBorder)
        fieldBorder.translatesAutoresizingMaskIntoConstraints = false
        fieldBorder.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 4).isActive = true
        fieldBorder.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        fieldBorder.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        fieldBorder.heightAnchor.constraint(equalToConstant: 1).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("")
    }
}
