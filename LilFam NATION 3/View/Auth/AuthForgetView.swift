//
//  AuthForgetView.swift
//  LilFam NATION 3
//
//  Created by Daniil Savva on 19.01.2022.
//

import UIKit
import CoreData

class AuthForgetView : UIView, UserForgetDelegate {
    
    private var _context: NSManagedObjectContext
    private var _authUserDelegate: AuthUserDelegate?
    private var _parentController: UIViewController
    
    private var _forget_id: Int = 0
    
    private var _labelDesc: UILabel?
    private var _forgetStep: Int = 0
    private var _inputUsername: UITextField?
    private var _btnForgetStep1: UIButton?
    
    private var _inputCode: UITextField?
    private var _btnForgetStep2: UIButton?
    private var _btnForgetCansel: UIButton?
    
    init(context: NSManagedObjectContext, authUserDelegate: AuthUserDelegate, parentController: UIViewController){
        _context = context
        _authUserDelegate = authUserDelegate
        _parentController = parentController
        super.init(frame: CGRect())
        
        /*
        let titleLabel = UILabel(frame: CGRect())
        titleLabel.text = "AuthForgetView"
        self.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        */
        
        let topMargin: CGFloat = parentController.view.frame.height / 4
        
        _labelDesc = UILabel(frame: CGRect())
        _labelDesc?.text = "Введите свою почту"
        _labelDesc?.numberOfLines = 4
        _labelDesc!.font = UIFont(name: GlobalVariables.fontGothamProLightSrc, size: 20)
        _labelDesc!.textAlignment = .center
        _labelDesc!.textColor = .black
        self.addSubview(_labelDesc!)
        _labelDesc!.translatesAutoresizingMaskIntoConstraints = false
        _labelDesc!.topAnchor.constraint(equalTo: self.topAnchor, constant: topMargin).isActive = true
        _labelDesc!.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        _labelDesc!.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true
        
        
        _inputUsername = UITextFieldDefault("Ваша почта", .default)
        self.addSubview(_inputUsername!)
        _inputUsername?.translatesAutoresizingMaskIntoConstraints = false
        _inputUsername!.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        _inputUsername!.topAnchor.constraint(equalTo: _labelDesc!.bottomAnchor, constant: 20).isActive = true
        _inputUsername!.heightAnchor.constraint(equalToConstant: 20).isActive = true
        _inputUsername!.widthAnchor.constraint(equalToConstant: 200).isActive = true
        
        
        _btnForgetStep1 = ButtonDefault("Отправить код")
        self.addSubview(_btnForgetStep1!)
        _btnForgetStep1?.translatesAutoresizingMaskIntoConstraints = false
        _btnForgetStep1!.topAnchor.constraint(equalTo: _inputUsername!.bottomAnchor, constant: 20).isActive = true
        _btnForgetStep1!.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        _btnForgetStep1!.heightAnchor.constraint(equalToConstant: 30).isActive = true
        _btnForgetStep1!.widthAnchor.constraint(equalToConstant: 200).isActive = true
        _btnForgetStep1!.addTarget(self, action: #selector(forgetStep1), for: .touchUpInside)
        
        
        
        
        
        _labelDesc?.text = "Введите код из\nотправленного вам письма"
        _labelDesc!.font = UIFont(name: GlobalVariables.fontGothamProLightSrc, size: 14)
        
        _inputCode = UITextFieldDefault("6-ти значный код", .default)
        _inputCode?.textAlignment = .center
        self.addSubview(_inputCode!)
        _inputCode?.translatesAutoresizingMaskIntoConstraints = false
        _inputCode!.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        _inputCode!.topAnchor.constraint(equalTo: _labelDesc!.bottomAnchor, constant: 20).isActive = true
        _inputCode!.heightAnchor.constraint(equalToConstant: 20).isActive = true
        _inputCode!.widthAnchor.constraint(equalToConstant: 200).isActive = true
        
        
        _btnForgetStep2 = ButtonDefault("Отправить")
        self.addSubview(_btnForgetStep2!)
        _btnForgetStep2?.translatesAutoresizingMaskIntoConstraints = false
        _btnForgetStep2!.topAnchor.constraint(equalTo: _inputCode!.bottomAnchor, constant: 20).isActive = true
        _btnForgetStep2!.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        _btnForgetStep2!.heightAnchor.constraint(equalToConstant: 30).isActive = true
        _btnForgetStep2!.widthAnchor.constraint(equalToConstant: 200).isActive = true
        _btnForgetStep2!.addTarget(self, action: #selector(forgetStep2), for: .touchUpInside)
        
        
        _btnForgetCansel = ButtonDefault("Отмена")
        self.addSubview(_btnForgetCansel!)
        _btnForgetCansel?.translatesAutoresizingMaskIntoConstraints = false
        _btnForgetCansel!.topAnchor.constraint(equalTo: _btnForgetStep2!.bottomAnchor, constant: 16).isActive = true
        _btnForgetCansel!.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        _btnForgetCansel!.heightAnchor.constraint(equalToConstant: 30).isActive = true
        _btnForgetCansel!.widthAnchor.constraint(equalToConstant: 200).isActive = true
        _btnForgetCansel!.addTarget(self, action: #selector(forgetCanselStep2), for: .touchUpInside)
        
        changeStateOfForget(step: 0)
    }
    
    required init(coder: NSCoder) {
        fatalError()
    }
    
    private func changeStateOfForget(step: Int){
        switch step {
        case 0:
            _forgetStep = 0
            _labelDesc?.text = "Введите свою почту"
            _labelDesc!.font = UIFont(name: GlobalVariables.fontGothamProLightSrc, size: 20)
            
            _inputUsername?.isHidden = false
            _btnForgetStep1?.isHidden = false
            
            _inputCode?.isHidden = true
            _btnForgetStep2!.isHidden = true
            _btnForgetCansel!.isHidden = true
            break;
        case 1:
            _forgetStep = 1
            _labelDesc?.text = "Введите код из отправленного вам письма.\nПосле ввода вам на почту будет отправлен\n автоматически сгенерированный пароль"
            _labelDesc!.font = UIFont(name: GlobalVariables.fontGothamProLightSrc, size: 14)
            
            _inputUsername?.isHidden = true
            _btnForgetStep1!.isHidden = true
            
            _inputCode?.isHidden = false
            _btnForgetStep2?.isHidden = false
            _btnForgetCansel?.isHidden = false
            break;
        case 2:
            /*
            _inputUsername?.isHidden = true
            _btnForgetStep1!.isHidden = true
            
            _inputCode?.isHidden = true
            _btnForgetStep2?.isHidden = true
            _btnForgetCansel?.isHidden = true
             */
            break;
        default:
            break;
        }
    }
    
    @objc
    private func forgetStep1(){
        let username = _inputUsername!.text ?? ""
        if username == "" {
            AlertComponent.callAlertError("Введите свою почту", _parentController)
            return
        }
        
        let userFacade: UserFacade = UserFacade(_context)
        userFacade.forget(userForgetDelegate: self, step: 0, username: username, code: nil)
        _btnForgetStep1?.isEnabled = false
    }
    
    
    @objc
    private func forgetCanselStep2(){
        changeStateOfForget(step: 0)
        _inputCode?.text = nil
    }
    
    
    @objc
    private func forgetStep2(){
        let code = _inputCode!.text ?? ""
        if code == "" {
            AlertComponent.callAlertError("Введите отправленный код", _parentController)
            return
        }
        
        let userFacade: UserFacade = UserFacade(_context)
        userFacade.forget(userForgetDelegate: self, step: 1, username: nil, code: code, forget_id: _forget_id)
        _btnForgetStep1?.isEnabled = false
    }
    
    
    func result(jsonAnswerStatus: JsonAnswerStatus?) {
        _btnForgetStep1?.isEnabled = true
        
        if jsonAnswerStatus == nil {
            AlertComponent.callAlertError("Неизвестная ошибка на сервере", _parentController)
            return
        }
        
        if jsonAnswerStatus!.status == "success" {
            if _forgetStep == 0 && jsonAnswerStatus!.id_of_user != 0 {
                _forget_id = jsonAnswerStatus!.id_of_user!
                changeStateOfForget(step: 1)
            } else if _forgetStep == 1 && jsonAnswerStatus!.accessToken != nil {
                let techDataService = TechDataService(self._context)
                if !techDataService.updateAccessToken(jsonAnswerStatus!.accessToken) {
                    AlertComponent.callAlertError("Ошибка в приложении при попытке пройти аутентификацию", _parentController)
                    return
                }
                _authUserDelegate?.login(accessToken: jsonAnswerStatus!.accessToken!)
            } else {
                AlertComponent.callAlertError("Извините, неизвестная ошибка", _parentController)
            }
        } else if jsonAnswerStatus!.status == "error" && jsonAnswerStatus!.errors == "not_found" {
            AlertComponent.callAlertError("Электронная почта не найдена", _parentController)
        } else if jsonAnswerStatus!.status == "error" && jsonAnswerStatus!.errors == "max_limit_try" {
            AlertComponent.callAlertError("Лимит попыток счерпан, подождите пожалуйста 20 минут", _parentController)
        } else if jsonAnswerStatus!.status == "error" && jsonAnswerStatus!.errors == "wrong_max_limit" {
            AlertComponent.callAlertError("Количество попыток исчерпано", _parentController)
        } else if jsonAnswerStatus!.status == "error" && jsonAnswerStatus!.errors == "wrong_2" {
            AlertComponent.callAlertError("Код введен неверно. Осталось попыток: 1", _parentController)
        } else if jsonAnswerStatus!.status == "error" && jsonAnswerStatus!.errors == "wrong_1" {
            AlertComponent.callAlertError("Код введен неверно. Осталось попыток: 2", _parentController)
        } else if jsonAnswerStatus!.status == "error" && jsonAnswerStatus!.errors == "wrong" {
            AlertComponent.callAlertError("Код введен неверно. Осталось попыток: 3", _parentController)
        } else {
            AlertComponent.callAlertError("Извините, неизвестная ошибка на сервере", _parentController)
        }
    }
}

