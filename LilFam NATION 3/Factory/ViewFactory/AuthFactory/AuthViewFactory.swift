//
//  AuthViewFactory.swift
//  LilFam NATION 3
//
//  Created by Daniil Savva on 19.01.2022.
//

import UIKit
import CoreData

class AuthViewFactory {
    
    private var _context: NSManagedObjectContext
    private var _authUserDelegate: AuthUserDelegate
    init(context: NSManagedObjectContext, authUserDelegate: AuthUserDelegate){
        _context = context
        _authUserDelegate = authUserDelegate
    }
    
    public func createSignInView(parentController: UIViewController, topView: UIView, bottomView: UIView, isHidden: Bool = true) -> AuthSignInView {
        let view = AuthSignInView(context:_context, authUserDelegate: _authUserDelegate, parentController: parentController)
        parentController.view.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.topAnchor.constraint(equalTo: topView.bottomAnchor).isActive = true
        view.bottomAnchor.constraint(equalTo: bottomView.topAnchor).isActive = true
        view.leadingAnchor.constraint(equalTo: parentController.view.leadingAnchor).isActive = true
        view.trailingAnchor.constraint(equalTo: parentController.view.trailingAnchor).isActive = true
        view.isHidden = isHidden
        
        return view
    }
    
    public func createSignUpView(parentController: UIViewController, topView: UIView, bottomView: UIView, isHidden: Bool = true) -> AuthSignUpView {
        let view = AuthSignUpView(context:_context, authUserDelegate: _authUserDelegate, parentController: parentController)
        parentController.view.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.topAnchor.constraint(equalTo: topView.bottomAnchor).isActive = true
        view.bottomAnchor.constraint(equalTo: bottomView.topAnchor).isActive = true
        view.leadingAnchor.constraint(equalTo: parentController.view.leadingAnchor).isActive = true
        view.trailingAnchor.constraint(equalTo: parentController.view.trailingAnchor).isActive = true
        view.isHidden = isHidden
        
        return view
    }
    
    public func createForgetView(parentController: UIViewController, topView: UIView, bottomView: UIView, isHidden: Bool = true) -> AuthForgetView {
        let view = AuthForgetView(context:_context, authUserDelegate: _authUserDelegate, parentController: parentController)
        parentController.view.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.topAnchor.constraint(equalTo: topView.bottomAnchor).isActive = true
        view.bottomAnchor.constraint(equalTo: bottomView.topAnchor).isActive = true
        view.leadingAnchor.constraint(equalTo: parentController.view.leadingAnchor).isActive = true
        view.trailingAnchor.constraint(equalTo: parentController.view.trailingAnchor).isActive = true
        view.isHidden = isHidden
        
        return view
    }
    
    
}
