//
//  ProfileView.swift
//  LilFam NATION 3
//
//  Created by Daniil Savva on 22.01.2022.
//

import UIKit
import CoreData

class ProfileView : UIView, AuthPickerGenderSelectModalViewProtocol {
    
    private var _context: NSManagedObjectContext
    private var _parentController: UIViewController
    private var _userProfileDelegate: UserProfileDelegate?
    
    private var _inputUsername: UITextField?
    private var _inputFio: UITextField?
    private var _inputPhone: UITextField?
    
    private var _dateOfBirthdayPicker: UIDatePicker?
    private var _btnLikeFieldSex: UIBtnLikeDefTextField?
    private var _genderSelectModalView: AuthGenderSelectModalView?
    private var _gender: Int = 0
    
    private var _inputPasswordCurrent: UITextField?
    private var _inputPasswordNew: UITextField?
    
    private var _inputParentFio: UITextField?
    private var _inputParentPhone: UITextField?
    
    private var _btnSave: ButtonDefault?
    
    private let _fieldMarginTop: CGFloat = 20
    private let _fieldMarginLeftRight: CGFloat = 20
    
    init(context: NSManagedObjectContext , parentController: UIViewController, userProfileDelegate: UserProfileDelegate){
        _context = context
        _parentController = parentController
        _userProfileDelegate = userProfileDelegate
        super.init(frame: CGRect())
        
        
        
        _inputUsername = UITextFieldDefault("Электронная почта", .emailAddress)
        self.addSubview(_inputUsername!)
        _inputUsername!.translatesAutoresizingMaskIntoConstraints = false
        _inputUsername!.topAnchor.constraint(equalTo: self.topAnchor, constant: 20).isActive = true
        
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
        
        
        
        
        
        let labelSex = UIFormLabel(text: "Пол:")
        self.addSubview(labelSex)
        labelSex.translatesAutoresizingMaskIntoConstraints = false
        labelSex.topAnchor.constraint(equalTo: _inputPhone!.bottomAnchor, constant: _fieldMarginTop).isActive = true
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
        
        
        
        
        _inputPasswordCurrent = UITextFieldDefault("Текущий пароль", .default, true)
        self.addSubview(_inputPasswordCurrent!)
        _inputPasswordCurrent!.translatesAutoresizingMaskIntoConstraints = false
        _inputPasswordCurrent!.topAnchor.constraint(equalTo: _inputParentPhone!.bottomAnchor, constant: 20).isActive = true
        _inputPasswordCurrent!.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: _fieldMarginLeftRight).isActive = true
        _inputPasswordCurrent!.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -_fieldMarginLeftRight).isActive = true
        
        _inputPasswordNew = UITextFieldDefault("Новый пароль", .default, true)
        self.addSubview(_inputPasswordNew!)
        _inputPasswordNew!.translatesAutoresizingMaskIntoConstraints = false
        _inputPasswordNew!.topAnchor.constraint(equalTo: _inputPasswordCurrent!.bottomAnchor, constant: 20).isActive = true
        _inputPasswordNew!.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: _fieldMarginLeftRight).isActive = true
        _inputPasswordNew!.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -_fieldMarginLeftRight).isActive = true
        
        
        _btnSave = ButtonDefault("Сохранить")
        self.addSubview(_btnSave!)
        _btnSave!.translatesAutoresizingMaskIntoConstraints = false
        _btnSave!.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20).isActive = true
        _btnSave!.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        _btnSave!.widthAnchor.constraint(equalToConstant: 200).isActive = true
        _btnSave!.layer.cornerRadius = 15
        _btnSave!.addTarget(self, action: #selector(save), for: .touchUpInside)
    }
    
    
    required init(coder: NSCoder) {
        fatalError()
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
    
    
    public func setUserData(
        username: String?,
        fio: String?,
        phone: String?,
        sex: Int,
        dateOfBirthday: String?
    ){
        _inputUsername!.text = username
        _inputFio!.text = fio
        _inputPhone!.text = phone
        
        _gender = sex
        switch sex {
        case 1:
            _btnLikeFieldSex!.setCustomTitleText(text: "Женский")
            break;
        case 2:
            _btnLikeFieldSex!.setCustomTitleText(text: "Мужской")
            break;
        default:
            _btnLikeFieldSex!.setCustomTitleText(text: "- пол не выбран")
            break;
        }
        if dateOfBirthday != nil {
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "ru_RU") // set locale to reliable US_POSIX
            dateFormatter.dateFormat = "yyyy-MM-dd"
            _dateOfBirthdayPicker!.date = dateFormatter.date(from:dateOfBirthday!)!
        }
        
        clearPasswordFields()
    }
    
    public func clearPasswordFields(){
        _inputPasswordCurrent!.text = nil
        _inputPasswordNew!.text = nil
    }
    
    
    @objc
    private func save(){
        let username: String = _inputUsername!.text ?? ""
        if username == "" {
            AlertComponent.callAlertError("Укажите пожалуйста электронную почту", _parentController)
            return
        }
        let fio: String? = _inputFio!.text
        let phone: String? = _inputPhone!.text
        let sex = _gender
        
        let dateOfBirthday = _dateOfBirthdayPicker!.date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.YYYY"
        let dateOfBirthdayStr: String = dateFormatter.string(from: dateOfBirthday)
        
        let parentFio: String? = _inputParentFio!.text
        let parentPhone: String? = _inputParentPhone!.text
        
        let passwordCurrent: String = _inputPasswordCurrent!.text ?? ""
        let passwordNew: String = _inputPasswordNew!.text ?? ""
        if passwordNew != "" {
            if passwordCurrent == "" {
                AlertComponent.callAlertError("Введите пожалуйста текущий пароль", _parentController)
                return
            }
        }
        
        let userFacae = UserFacade(_context)
        userFacae.save(
            userProfileDelegate: _userProfileDelegate!,
            username: username,
            fio: fio,
            phone: phone,
            sex: sex,
            dateOfBirthday: dateOfBirthdayStr,
            parentFio: parentFio,
            parentPhone: parentPhone,
            passwordCurrent: passwordCurrent,
            passwordNew : passwordNew
        )
    }
    
    
}
