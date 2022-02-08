//
//  AuthTabButton.swift
//  LilFam NATION 3
//
//  Created by Daniil Savva on 19.01.2022.
//

import UIKit

class AuthTabButton : UIButton {
    
    private var _titleText : String
    private var _titleLabel: UILabel?
    private var _index: Int
    private var _isActive: Bool
    
    init(titleText: String, index: Int, isActive: Bool){
        _titleText = titleText
        _index = index
        _isActive = isActive
        
        super.init(frame: CGRect())
        
        //self.layer.cornerRadius = 4
        
        _titleLabel = UILabel(frame: CGRect())
        _titleLabel!.textAlignment = .center
        _titleLabel!.text = titleText
        _titleLabel!.textColor = UIColor(red: 243/255, green: 241/255, blue: 247/255, alpha: 1)
        
        guard let fontGothamProLight10 = UIFont(name: GlobalVariables.fontGothamProLightSrc, size: 12) else {
            fatalError("""
                Failed to load the "GothamPro-Light" font.
                Make sure the font file is included in the project and the font name is spelled correctly.
                """
            )
        }
        _titleLabel!.font = fontGothamProLight10
        
        self.addSubview(_titleLabel!)
        _titleLabel!.translatesAutoresizingMaskIntoConstraints = false
        _titleLabel!.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        _titleLabel!.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        _titleLabel!.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        _titleLabel!.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        
        changeActive()
    }
    
    required init(coder: NSCoder) {
        fatalError()
    }
    
    public func getIndex() -> Int {
        return _index
    }
    
    public func setIsActive(newActive: Bool){
        _isActive = newActive
        changeActive()
    }
    public func getIsActive() -> Bool {
        return _isActive
    }
    
    private func changeActive(){
        if _isActive {
            _titleLabel!.textColor = UIColor(red: 243/255, green: 241/255, blue: 247/255, alpha: 1)
            self.backgroundColor = UIColor(red: 75/255, green: 66/255, blue: 145/255, alpha: 1)
        } else {
            _titleLabel!.textColor = .white
            self.backgroundColor = .black
        }
    }
    
}
