//
//  LeftSideMenuFactory.swift
//  LilFam NATION 3
//
//  Created by Daniil Savva on 13.01.2022.
//

import UIKit
import CoreData

class LeftSideMenuFactory {
    
    private let startingYPos: CGFloat = {
        var heightToReturn: CGFloat = 0.0
             for window in UIApplication.shared.windows {
                 if let height = window.windowScene?.statusBarManager?.statusBarFrame.height, height > heightToReturn {
                     heightToReturn = height
                 }
             }
        return heightToReturn
    }()
    
    private var _context: NSManagedObjectContext
    init(context: NSManagedObjectContext){
        _context = context
    }
    
    public func create(parentController: UIViewController, leftSlideMenuDelegate: LeftSlideMenuDelegate) -> LeftSideMenu {
        
        let leftSideMenu = LeftSideMenu(context: _context, parentController: parentController, leftSlideMenuDelegate: leftSlideMenuDelegate)
        parentController.view.addSubview(leftSideMenu)
        leftSideMenu.translatesAutoresizingMaskIntoConstraints = false
        
        //leftSideMenu.topAnchor.constraint(equalTo: parentController.view.topAnchor, constant: startingYPos + GlobalVariables.titleHeight).isActive = true
        leftSideMenu.topAnchor.constraint(equalTo: parentController.view.safeTopAnchor).isActive = true
        leftSideMenu.trailingAnchor.constraint(equalTo: parentController.view.leadingAnchor).isActive = true
        leftSideMenu.leadingAnchor.constraint(equalTo: parentController.view.trailingAnchor, constant: -parentController.view.frame.width * 2).isActive = true
        leftSideMenu.bottomAnchor.constraint(equalTo: parentController.view.bottomAnchor).isActive = true
        
        return leftSideMenu
    }
}
