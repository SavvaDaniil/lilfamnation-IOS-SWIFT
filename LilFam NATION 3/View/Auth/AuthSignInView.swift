//
//  AuthSignIn.swift
//  LilFam NATION 3
//
//  Created by Daniil Savva on 19.01.2022.
//

import UIKit
import CoreData

class AuthSignInView : UIView, UserLoginResultDelegate {
    
    private var _context: NSManagedObjectContext
    private var _authUserDelegate: AuthUserDelegate?
    private var _parentController: UIViewController?
    
    private var _labelHeader: UILabel?
    private var _inputUsername: UITextField?
    private var _inputPassword: UITextField?
    private var _btnSignIn: UIButton?
    
    init(context: NSManagedObjectContext, authUserDelegate: AuthUserDelegate, parentController: UIViewController){
        _context = context
        _authUserDelegate = authUserDelegate
        _parentController = parentController
        super.init(frame: CGRect())
        /*
        let titleLabel = UILabel(frame: CGRect())
        titleLabel.text = "AuthSignInView"
        self.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        */
        
        let topMargin: CGFloat = parentController.view.frame.height / 4
        
        /*
        _labelHeader = UILabel(frame: CGRect())
        _labelHeader!.textColor = .black
        _labelHeader!.text = "Вход"
        _labelHeader!.textAlignment = .center
        _labelHeader!.font = UIFont(name: GlobalVariables.fontGothamProLightSrc, size: 20)
        self.addSubview(_labelHeader!)
        _labelHeader!.translatesAutoresizingMaskIntoConstraints = false
        _labelHeader!.topAnchor.constraint(equalTo: self.topAnchor, constant: topMargin).isActive = true
        _labelHeader!.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        _labelHeader!.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        */
        
        
        
        
        //UITextField(frame: CGRect())
        //UITextFieldDefault("Логин", .default)
        _inputUsername = UITextFieldDefault("Логин", .default)
        self.addSubview(_inputUsername!)
        _inputUsername?.translatesAutoresizingMaskIntoConstraints = false
        _inputUsername!.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        //_inputUsername!.topAnchor.constraint(equalTo: _labelHeader!.bottomAnchor, constant: 20).isActive = true
        _inputUsername!.topAnchor.constraint(equalTo: self.topAnchor, constant: topMargin).isActive = true
        _inputUsername!.heightAnchor.constraint(equalToConstant: 20).isActive = true
        _inputUsername!.widthAnchor.constraint(equalToConstant: 200).isActive = true
        
        _inputPassword = UITextFieldDefault("Пароль", .default, true)
        self.addSubview(_inputPassword!)
        _inputPassword?.translatesAutoresizingMaskIntoConstraints = false
        _inputPassword!.topAnchor.constraint(equalTo: _inputUsername!.bottomAnchor, constant: 20).isActive = true
        _inputPassword!.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        _inputPassword!.heightAnchor.constraint(equalToConstant: 20).isActive = true
        _inputPassword!.widthAnchor.constraint(equalToConstant: 200).isActive = true
        
        
        
        _btnSignIn = ButtonDefault("Войти")
        self.addSubview(_btnSignIn!)
        _btnSignIn?.translatesAutoresizingMaskIntoConstraints = false
        _btnSignIn!.topAnchor.constraint(equalTo: _inputPassword!.bottomAnchor, constant: 20).isActive = true
        _btnSignIn!.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        _btnSignIn!.heightAnchor.constraint(equalToConstant: 30).isActive = true
        _btnSignIn!.widthAnchor.constraint(equalToConstant: 200).isActive = true
        _btnSignIn!.addTarget(self, action: #selector(login), for: .touchUpInside)
    }
    
    @objc
    private func login(){
        let username: String = _inputUsername!.text ?? ""
        let password: String = _inputPassword!.text ?? ""
        
        if username == "" || password == "" {
            AlertComponent.callAlertError("Введите пожалуйста логин и пароль", _parentController!)
            return
        }
        
        let userFacade: UserFacade = UserFacade(_context)
        userFacade.login(username, password, self)
        _btnSignIn!.isEnabled = false
    }
    
    internal func result(jsonAnswerStatus: JsonAnswerStatus?) {
        _btnSignIn!.isEnabled = true
        
        if jsonAnswerStatus == nil {
            AlertComponent.callAlertError("Неизвестная ошибка на сервере", _parentController!)
            return
        }
        
        if jsonAnswerStatus!.status == "success" && jsonAnswerStatus!.accessToken != nil {
            let techDataService = TechDataService(self._context)
            if !techDataService.updateAccessToken(jsonAnswerStatus!.accessToken) {
                AlertComponent.callAlertError("Ошибка в приложении при попытке пройти аутентификацию", _parentController!)
                return
            }
            _authUserDelegate?.login(accessToken: jsonAnswerStatus!.accessToken!)
            
        } else if jsonAnswerStatus!.status == "error" && jsonAnswerStatus!.errors == "wrong" {
            AlertComponent.callAlertError("Логин или пароль введны неверно", _parentController!)
        } else {
            AlertComponent.callAlertError("Извините, неизвестная ошибка на сервере", _parentController!)
        }
    }
    
    
    required init(coder: NSCoder) {
        fatalError()
    }
}
