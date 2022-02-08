//
//  NavogationBar.swift
//  LilFam NATION 3
//
//  Created by Daniil Savva on 12.01.2022.
//

import Foundation
import UIKit


class NavigationBar : UINavigationBar {
    
    private var _parentController: UIViewController?
    private let _navItem = UINavigationItem()
    
    init(parentController: UIViewController, title: String? = nil, leftBarButtonItem: UIBarButtonItem? = nil){
        _parentController = parentController
        super.init(frame: CGRect())
        
        //self.backgroundColor = .blue
        self.barStyle = .black
        //self.barTintColor = UIColor(red: 103/255, green: 70/255, blue: 167/255, alpha: 1)
        //self.isTranslucent = false
        self.isTranslucent = false
        self.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: GlobalVariables.fontGothamProMediumSrc, size: 18)!]
        
        if title != nil {
            _navItem.title = title
        }
        
        if leftBarButtonItem != nil {
            _navItem.leftBarButtonItem = leftBarButtonItem
        }
        
        
        self.items = [_navItem]
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    public func setTitle(title: String?) -> (){
        if title != nil {
            self._navItem.title = title
        } else {
            self._navItem.title = nil
        }
    }
    
}
