//
//  AuthGenderSelectModalView.swift
//  LilFam NATION 3
//
//  Created by Daniil Savva on 20.01.2022.
//

import UIKit


class AuthGenderSelectModalView : UIView, UIPickerViewDelegate, UIPickerViewDataSource {
    
    private let _arrayOfGenders: [(value: Int, name: String)] = [
        (value:0, name: "- пол не выбран"),
        (value:1, name: "Женский"),
        (value:2, name: "Мужской")
    ]
    
    private var _block: UIView?
    //private var pickerTextField : UITextField?
    private var _pickerView: UIPickerView?
    private var _authPickerGenderSelectModalViewProtocol: AuthPickerGenderSelectModalViewProtocol
    private var _selectedRowFromPicker: Int = 0
    
    init(_ authPickerGenderSelectModalViewProtocol: AuthPickerGenderSelectModalViewProtocol){
        _authPickerGenderSelectModalViewProtocol = authPickerGenderSelectModalViewProtocol
        super.init(frame: CGRect())
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        _block = UIView(frame: CGRect())
        _block!.layer.cornerRadius = 10
        _block!.layer.borderColor = GlobalVariables.blockDefaultBorderColor.cgColor
        _block!.layer.borderWidth = 1
        _block!.backgroundColor = GlobalVariables.grayColor
        self.addSubview(_block!)
        _block!.translatesAutoresizingMaskIntoConstraints = false
        _block!.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        _block!.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        _block!.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true
        _block!.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        
        
        _pickerView = UIPickerView()
        _pickerView!.delegate = self
        _pickerView!.dataSource = self
        
        //pickerTextField.inputView = pickerView
        
        _block!.addSubview(_pickerView!)
        _pickerView!.translatesAutoresizingMaskIntoConstraints = false
        _pickerView!.topAnchor.constraint(equalTo: _block!.topAnchor, constant: 20).isActive = true
        _pickerView!.bottomAnchor.constraint(equalTo: _block!.bottomAnchor, constant: -60).isActive = true
        _pickerView!.leadingAnchor.constraint(equalTo: _block!.leadingAnchor, constant: 20).isActive = true
        _pickerView!.trailingAnchor.constraint(equalTo: _block!.trailingAnchor, constant: -20).isActive = true
        
        
        let btnSuccess = ButtonDefault("Выбрать", true)
        _block!.addSubview(btnSuccess)
        btnSuccess.translatesAutoresizingMaskIntoConstraints = false
        btnSuccess.bottomAnchor.constraint(equalTo: _block!.bottomAnchor, constant: -20).isActive = true
        btnSuccess.centerXAnchor.constraint(equalTo: _block!.centerXAnchor).isActive = true
        btnSuccess.widthAnchor.constraint(equalToConstant: 100).isActive = true
        btnSuccess.layer.cornerRadius = 15
        btnSuccess.addTarget(self, action: #selector(chooseGender), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("")
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return _arrayOfGenders.count
    }
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView
    {
        let pickerLabel = UILabel()
        pickerLabel.textColor = GlobalVariables.activeColor
        pickerLabel.text = _arrayOfGenders[row].name
        pickerLabel.font = UIFont(name: GlobalVariables.fontGothamProLightSrc, size: 20)
        pickerLabel.textAlignment = NSTextAlignment.center
        return pickerLabel
    }
     
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        _selectedRowFromPicker = row
    }
    
    @objc
    private func chooseGender(){
        _authPickerGenderSelectModalViewProtocol.chooseGender(value: _arrayOfGenders[self._selectedRowFromPicker].value, name:_arrayOfGenders[self._selectedRowFromPicker].name)
    }
    
}
