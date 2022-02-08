//
//  AuthTabBarCustomFactory.swift
//  LilFam NATION 3
//
//  Created by Daniil Savva on 19.01.2022.
//

import UIKit

class AuthTabBarCustomFactory {
    
    private var _parentController: UIViewController?
    private var _authTabBarCustomProtocol: AuthTabBarCustomProtocol?
    private var _authTabButtonFactory = AuthTabButtonFactory()
    
    
    public func create(
        parentController: UIViewController,
        authTabBarCustomProtocol: AuthTabBarCustomProtocol
    ) -> AuthTabBarCustom {
        _parentController  = parentController
        _authTabBarCustomProtocol = authTabBarCustomProtocol
        
        let authTabBarCustom = AuthTabBarCustom()
        parentController.view.addSubview(authTabBarCustom)
        authTabBarCustom.translatesAutoresizingMaskIntoConstraints = false
        authTabBarCustom.bottomAnchor.constraint(equalTo: parentController.view.bottomAnchor).isActive = true
        authTabBarCustom.leadingAnchor.constraint(equalTo: parentController.view.leadingAnchor).isActive = true
        authTabBarCustom.trailingAnchor.constraint(equalTo: parentController.view.trailingAnchor).isActive = true
        authTabBarCustom.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        let btnSignIn = _authTabButtonFactory.create(parentController: parentController, parentView: authTabBarCustom, titleText: "Войти", indexOfBtnFrom3: 0)
        btnSignIn.addTarget(self, action: #selector(changeTab), for: .touchUpInside)
        
        let btnSignUp = _authTabButtonFactory.create(parentController: parentController, parentView: authTabBarCustom, titleText: "Регистрация", indexOfBtnFrom3: 1)
        btnSignUp.addTarget(self, action: #selector(changeTab), for: .touchUpInside)
        
        let btnForget = _authTabButtonFactory.create(parentController: parentController, parentView: authTabBarCustom, titleText: "Забыли пароль", indexOfBtnFrom3: 2)
        btnForget.addTarget(self, action: #selector(changeTab), for: .touchUpInside)
        
        authTabBarCustom.tabButtons.append(btnSignIn)
        authTabBarCustom.tabButtons.append(btnSignUp)
        authTabBarCustom.tabButtons.append(btnForget)
        
        return authTabBarCustom
    }
    
    @objc
    private func changeTab(sender: AuthTabButton){
        //sender.setIsActive(newActive: true)
        _authTabBarCustomProtocol?.changeTab(didSelect: sender.getIndex())
    }
    
    private func changeBtnTabActive(index: UInt8){
        
    }
    
}
