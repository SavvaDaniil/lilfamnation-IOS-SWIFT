//
//  ProfileViewFactory.swift
//  LilFam NATION 3
//
//  Created by Daniil Savva on 22.01.2022.
//

import UIKit
import CoreData

class ProfileViewFactory {
    
    private var _context: NSManagedObjectContext
    init(context: NSManagedObjectContext){
        _context = context
    }
    
    public func create(parentController: UIViewController, userProfileDelegate: UserProfileDelegate) -> ProfileView {
        let profileView = ProfileView(context: _context, parentController: parentController, userProfileDelegate: userProfileDelegate)
        parentController.view.addSubview(profileView)
        profileView.translatesAutoresizingMaskIntoConstraints = false
        profileView.topAnchor.constraint(equalTo: parentController.view.topAnchor).isActive = true
        profileView.bottomAnchor.constraint(equalTo: parentController.view.bottomAnchor).isActive = true
        profileView.leadingAnchor.constraint(equalTo: parentController.view.leadingAnchor).isActive = true
        profileView.trailingAnchor.constraint(equalTo: parentController.view.trailingAnchor).isActive = true
        
        return profileView
    }
}
