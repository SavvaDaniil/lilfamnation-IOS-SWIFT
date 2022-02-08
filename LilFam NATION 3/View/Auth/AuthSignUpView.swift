//
//  AuthSignUpView.swift
//  LilFam NATION 3
//
//  Created by Daniil Savva on 19.01.2022.
//

import UIKit
import CoreData

class AuthSignUpView : UIView, AuthPickerGenderSelectModalViewProtocol, UserRegistrationDelegate {
    
    private var _context: NSManagedObjectContext
    private var _authUserDelegate: AuthUserDelegate
    private var _parentController: UIViewController?
    
    private var _scrollView: UIScrollView?
    private var _inputUsername: UITextField?
    private var _inputPassword: UITextField?
    private var _inputPasswordAgain: UITextField?
    private var _inputFio: UITextField?
    private var _inputPhone: UITextField?
    
    private var _dateOfBirthdayPicker: UIDatePicker?
    private var _btnLikeFieldSex: UIBtnLikeDefTextField?
    private var _genderSelectModalView: AuthGenderSelectModalView?
    private var _gender: Int = 0
    
    private var _inputParentFio: UITextField?
    private var _inputParentPhone: UITextField?
    
    private var _btnRegistration: ButtonDefault?
    
    private let _fieldMarginTop: CGFloat = 20
    private let _fieldMarginLeftRight: CGFloat = 20
    
    
    
    init(context: NSManagedObjectContext, authUserDelegate: AuthUserDelegate, parentController: UIViewController){
        _context = context
        _authUserDelegate = authUserDelegate
        _parentController = parentController
        super.init(frame: CGRect())
        
        /*
        let titleLabel = UILabel(frame: CGRect())
        titleLabel.text = "AuthSignUpView"
        self.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        */
        
        /*
        _scrollView = UIScrollView()
        //_scrollView?.backgroundColor = .gray
        _scrollView!.isScrollEnabled = true
        self.addSubview(_scrollView!)
        
        _scrollView!.translatesAutoresizingMaskIntoConstraints = false
        _scrollView!.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        _scrollView!.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        _scrollView!.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        _scrollView!.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        _scrollView!.contentSize = CGSize(width: parentController.view.frame.width, height: 1200)
        */
        
        
        _inputUsername = UITextFieldDefault("Электронная почта", .emailAddress)
        self.addSubview(_inputUsername!)
        _inputUsername!.translatesAutoresizingMaskIntoConstraints = false
        _inputUsername!.topAnchor.constraint(equalTo: self.topAnchor, constant: 20).isActive = true
        
        //_inputUsername!.widthAnchor.constraint(equalToConstant: 200).isActive = true
        //_inputUsername?.centerXAnchor.constraint(equalTo: _scrollView!.centerXAnchor).isActive = true
        _inputUsername!.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: _fieldMarginLeftRight).isActive = true
        _inputUsername!.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -_fieldMarginLeftRight).isActive = true
        
        
        _inputFio = UITextFieldDefault("ФИО", .default)
        self.addSubview(_inputFio!)
        _inputFio!.translatesAutoresizingMaskIntoConstraints = false
        _inputFio!.topAnchor.constraint(equalTo: _inputUsername!.bottomAnchor, constant: 20).isActive = true
        _inputFio!.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: _fieldMarginLeftRight).isActive = true
        _inputFio!.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -_fieldMarginLeftRight).isActive = true
        
        _inputPhone = UITextFieldDefault("Телефон", .numberPad)
        self.addSubview(_inputPhone!)
        _inputPhone!.translatesAutoresizingMaskIntoConstraints = false
        _inputPhone!.topAnchor.constraint(equalTo: _inputFio!.bottomAnchor, constant: 20).isActive = true
        _inputPhone!.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: _fieldMarginLeftRight).isActive = true
        _inputPhone!.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -_fieldMarginLeftRight).isActive = true
        
        _inputPassword = UITextFieldDefault("Придумайте пароль", .default, true)
        self.addSubview(_inputPassword!)
        _inputPassword!.translatesAutoresizingMaskIntoConstraints = false
        _inputPassword!.topAnchor.constraint(equalTo: _inputPhone!.bottomAnchor, constant: 20).isActive = true
        _inputPassword!.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: _fieldMarginLeftRight).isActive = true
        _inputPassword!.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -_fieldMarginLeftRight).isActive = true
        
        _inputPasswordAgain = UITextFieldDefault("Пароль еще раз", .default, true)
        self.addSubview(_inputPasswordAgain!)
        _inputPasswordAgain!.translatesAutoresizingMaskIntoConstraints = false
        _inputPasswordAgain!.topAnchor.constraint(equalTo: _inputPassword!.bottomAnchor, constant: 20).isActive = true
        _inputPasswordAgain!.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: _fieldMarginLeftRight).isActive = true
        _inputPasswordAgain!.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -_fieldMarginLeftRight).isActive = true
        
        
        
        
        let labelSex = UIFormLabel(text: "Пол:")
        self.addSubview(labelSex)
        labelSex.translatesAutoresizingMaskIntoConstraints = false
        labelSex.topAnchor.constraint(equalTo: _inputPasswordAgain!.bottomAnchor, constant: _fieldMarginTop).isActive = true
        labelSex.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: _fieldMarginLeftRight).isActive = true
        labelSex.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -_fieldMarginLeftRight).isActive = true
        
        
        _btnLikeFieldSex = UIBtnLikeDefTextField(titleText: "- пол не выбран")
        self.addSubview(_btnLikeFieldSex!)
        _btnLikeFieldSex!.translatesAutoresizingMaskIntoConstraints = false
        _btnLikeFieldSex!.topAnchor.constraint(equalTo: labelSex.bottomAnchor, constant:10).isActive = true
        _btnLikeFieldSex!.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: _fieldMarginLeftRight).isActive = true
        _btnLikeFieldSex!.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -_fieldMarginLeftRight).isActive = true
        _btnLikeFieldSex!.addTarget(self, action: #selector(openGenderSelect), for: .touchUpInside)
        
        
        
        
        let labelBirthday = UIFormLabel(text: "Дата рождения:")
        self.addSubview(labelBirthday)
        labelBirthday.translatesAutoresizingMaskIntoConstraints = false
        labelBirthday.topAnchor.constraint(equalTo: _btnLikeFieldSex!.bottomAnchor, constant: _fieldMarginTop).isActive = true
        labelBirthday.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: _fieldMarginLeftRight).isActive = true
        labelBirthday.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -_fieldMarginLeftRight).isActive = true
        
        _dateOfBirthdayPicker = UIDatePicker(frame: CGRect())
        _dateOfBirthdayPicker?.datePickerMode = .date
        _dateOfBirthdayPicker?.locale = Locale(identifier: "ru_RU")
        self.addSubview(_dateOfBirthdayPicker!)
        _dateOfBirthdayPicker!.translatesAutoresizingMaskIntoConstraints = false
        _dateOfBirthdayPicker!.topAnchor.constraint(equalTo: labelBirthday.bottomAnchor, constant: 20).isActive = true
        _dateOfBirthdayPicker!.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: _fieldMarginLeftRight).isActive = true
        _dateOfBirthdayPicker!.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -_fieldMarginLeftRight).isActive = true
        
        _dateOfBirthdayPicker!.contentHorizontalAlignment = .left
        _dateOfBirthdayPicker!.backgroundColor = .gray
        _dateOfBirthdayPicker!.tintColor = .black
        _dateOfBirthdayPicker!.setValue(UIColor.black, forKeyPath: "textColor")
        _dateOfBirthdayPicker!.layer.cornerRadius = 15
        
        
        
        _inputParentFio = UITextFieldDefault("ФИО родителя", .default)
        self.addSubview(_inputParentFio!)
        _inputParentFio!.translatesAutoresizingMaskIntoConstraints = false
        _inputParentFio!.topAnchor.constraint(equalTo: _dateOfBirthdayPicker!.bottomAnchor, constant: 20).isActive = true
        _inputParentFio!.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: _fieldMarginLeftRight).isActive = true
        _inputParentFio!.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -_fieldMarginLeftRight).isActive = true
        
        _inputParentPhone = UITextFieldDefault("Телефон родителя", .numberPad)
        self.addSubview(_inputParentPhone!)
        _inputParentPhone!.translatesAutoresizingMaskIntoConstraints = false
        _inputParentPhone!.topAnchor.constraint(equalTo: _inputParentFio!.bottomAnchor, constant: 20).isActive = true
        _inputParentPhone!.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: _fieldMarginLeftRight).isActive = true
        _inputParentPhone!.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -_fieldMarginLeftRight).isActive = true
        
        
        
        _btnRegistration = ButtonDefault("Зарегистрироваться")
        self.addSubview(_btnRegistration!)
        _btnRegistration!.translatesAutoresizingMaskIntoConstraints = false
        _btnRegistration!.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20).isActive = true
        _btnRegistration!.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        _btnRegistration!.widthAnchor.constraint(equalToConstant: 200).isActive = true
        _btnRegistration!.layer.cornerRadius = 15
        _btnRegistration!.addTarget(self, action: #selector(registration), for: .touchUpInside)
    }
    
    @objc
    private func registration(){
        let username: String? = _inputUsername!.text
        let fio: String? = _inputFio!.text
        let phone: String? = _inputPhone!.text
        let password: String? = _inputPassword!.text
        let passwordAgain: String? = _inputPasswordAgain!.text
        let gender: Int = _gender
        let dateOfBirthday: Date = _dateOfBirthdayPicker!.date
        let parentFio: String? = _inputParentFio!.text
        let parentPhone: String? = _inputParentPhone!.text
        
        if username == "" {
            AlertComponent.callAlertError("Поле 'Логин' обязательно для заполнения", _parentController!)
            return
        }
        if fio == "" {
            AlertComponent.callAlertError("Поле 'ФИО' обязательно для заполнения", _parentController!)
            return
        }
        if phone == "" {
            AlertComponent.callAlertError("Поле 'Телефон' обязательно для заполнения", _parentController!)
            return
        }
        if password == "" {
            AlertComponent.callAlertError("Поле 'пароль' обязательно для заполнения", _parentController!)
            return
        }
        if password != passwordAgain {
            AlertComponent.callAlertError("Пароли не совпадают", _parentController!)
            return
        }
        if gender == 0 {
            AlertComponent.callAlertError("Поле 'пол' обязательно для заполнения", _parentController!)
            return
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.YYYY"
        let dateOfBirthdayStr: String = dateFormatter.string(from: dateOfBirthday)
        
        let userFacade = UserFacade(_context)
        userFacade.registration(userRegistrationDelegate: self, username: username!, fio: fio!, phone: phone!, password: password!, passwordAgain: passwordAgain!, sex: gender, dateOfBirthdayStr: dateOfBirthdayStr, parentFio: parentFio!, parentPhone: parentPhone!)
        _btnRegistration!.isEnabled = false
    }
    
    internal func result(jsonAnswerStatus: JsonAnswerStatus?) {
        _btnRegistration!.isEnabled = true
        
        if jsonAnswerStatus == nil {
            AlertComponent.callAlertError("Неизвестная ошибка на сервере", _parentController!)
            return
        }
        
        if jsonAnswerStatus!.status == "success" && jsonAnswerStatus!.accessToken != nil {
            
            let techDataService = TechDataService(_context)
            if !techDataService.updateAccessToken(jsonAnswerStatus!.accessToken) {
                AlertComponent.callAlertError("Ошибка в приложении при попытке пройти аутентификацию", _parentController!)
            }
            _authUserDelegate.login(accessToken: jsonAnswerStatus!.accessToken!)
            
        } else if jsonAnswerStatus!.status == "error" && jsonAnswerStatus!.errors == "username_already_exist" {
            AlertComponent.callAlertError("Указанный email уже зарегистрирован в базе", _parentController!)
        } else if jsonAnswerStatus!.status == "error" && jsonAnswerStatus!.errors == "need_parent_info" {
            AlertComponent.callAlertError("Для регистрации несовершеннолетних необходима контактная информация с родителями", _parentController!)
        } else {
            AlertComponent.callAlertError("Извините, неизвестная ошибка на сервере", _parentController!)
        }
        
    }
    
    
    
    @objc
    private func openGenderSelect(){
        if _genderSelectModalView == nil {
            setGenderSelectModalView()
        }
        
        _genderSelectModalView!.isHidden = false
    }
    private func setGenderSelectModalView(){
        _genderSelectModalView = AuthGenderSelectModalView(self)
        _genderSelectModalView!.backgroundColor = UIColor(white: 0, alpha: 0.5)
        _genderSelectModalView!.isHidden = true
        self.addSubview(_genderSelectModalView!)
        _genderSelectModalView!.translatesAutoresizingMaskIntoConstraints = false
        _genderSelectModalView!.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        _genderSelectModalView!.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        _genderSelectModalView!.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        _genderSelectModalView!.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    }
    func chooseGender(value: Int, name: String) {
        _gender = value
        _btnLikeFieldSex!.setCustomTitleText(text: name)
        _genderSelectModalView!.isHidden = true
    }
    
    
    required init(coder: NSCoder) {
        fatalError()
    }
    
    
}

