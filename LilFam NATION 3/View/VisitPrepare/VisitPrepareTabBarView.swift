//
//  VisitPrepareTabView.swift
//  LilFam NATION 3
//
//  Created by Daniil Savva on 29.01.2022.
//

import UIKit


class VisitPrepareTabBarView : UIView {
    
    public var tabButtons: [VisitPrepareTabButton] = []
    
    init(){
        super.init(frame: CGRect())
        self.backgroundColor = .black
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    public func changeActiveTabButton(index: Int){
        tabButtons.forEach{visitPrepareTabButton in
            visitPrepareTabButton.setIsActive(newActive: false)
        }
        tabButtons[index].setIsActive(newActive: true)
    }
}
