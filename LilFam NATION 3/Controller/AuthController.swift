//
//  AuthController.swift
//  LilFam NATION 3
//
//  Created by Daniil Savva on 14.01.2022.
//

import Foundation
import UIKit


class AuthController : UIViewController, AuthTabBarCustomProtocol, AuthUserDelegate {
    
    
    private var _context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    private var _authUserDelegate: AuthUserDelegate?
    
    private let _navigationBarFactory: NavigationBarFactory = NavigationBarFactory()
    private var _navigationBar: NavigationBar?
    
    private let _authTabBarCustomFactory = AuthTabBarCustomFactory()
    private var _authTabBarCustom: AuthTabBarCustom?
    
    //private let _tabBar: UITabBar = UITabBar()
    private var _authViewFactory: AuthViewFactory?
    private var _authSignInView: AuthSignInView?
    private var _authSignUpView: AuthSignUpView?
    private var _authForgetView: AuthForgetView?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.view.backgroundColor = .black
        let controllerBackgroundImageFactory = ControllerBackgroundImageFactory()
        controllerBackgroundImageFactory.createAndAdd(parentController: self)
        
        _navigationBar = _navigationBarFactory.createWithOnlyButtonBack(parentController: self, titleText: "Аутентификация")
        
        _authTabBarCustom = _authTabBarCustomFactory.create(parentController: self, authTabBarCustomProtocol: self)
        
        _authViewFactory = AuthViewFactory(context: _context, authUserDelegate: self)
        _authSignInView = _authViewFactory!.createSignInView(parentController: self, topView: _navigationBar!, bottomView: _authTabBarCustom!, isHidden: false)
        _authSignUpView = _authViewFactory!.createSignUpView(parentController: self, topView: _navigationBar!, bottomView: _authTabBarCustom!)
        _authForgetView = _authViewFactory!.createForgetView(parentController: self, topView: _navigationBar!, bottomView: _authTabBarCustom!)
        
    }
    
    public func setupAuthUserDelegate(authUserDelegate: AuthUserDelegate){
        _authUserDelegate = authUserDelegate
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
    
    
    internal func changeTab(didSelect tag: Int) {
        _authTabBarCustom!.changeActiveTabButton(index: tag)
        switch tag  {
            case 0:
            hideAllViews()
            _authSignInView?.isHidden = false
                break
            case 1:
            hideAllViews()
            _authSignUpView?.isHidden = false
                break
            case 2:
            hideAllViews()
            _authForgetView?.isHidden = false
                break
            default:
                break
        }
    }
    
    private func hideAllViews(){
        _authSignInView?.isHidden = true
        _authSignUpView?.isHidden = true
        _authForgetView?.isHidden = true
    }
    
    
    internal func login(accessToken: String) {
        _authUserDelegate?.login(accessToken: accessToken)
        self.dismissToRight()
    }
    
    internal func logout() {
        
    }
    
}
