//
//  ContactsController.swift
//  LilFam NATION 3
//
//  Created by Daniil Savva on 26.03.2021.
//

import UIKit

class ContactsController : UIViewController {
    
    //MARK: - Properties
    private var _btnOpenSite: ButtonDefault?
    private var _btnOpenVk: ButtonDefault?
    private var _btnOpenInstagram: ButtonDefault?
    private var _btnOpenBranchTimiryazevskaya: ButtonDefault?
    private let _maxWidth: CGFloat = 200
    
    
    // MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        let controllerBackgroundImageFactory = ControllerBackgroundImageFactory()
        controllerBackgroundImageFactory.createAndAdd(parentController: self)
        
        _btnOpenSite = ButtonDefault("Посетить наш сайт")
        self.view.addSubview(_btnOpenSite!)
        setWidthOfButtonDefault(btn: _btnOpenSite!)
        _btnOpenSite!.addTarget(self, action: #selector(openSite), for: .touchUpInside)
        
        _btnOpenVk = ButtonDefault("Vkontakte")
        self.view.addSubview(_btnOpenVk!)
        setWidthOfButtonDefault(btn: _btnOpenVk!, topView: _btnOpenSite!)
        _btnOpenVk!.addTarget(self, action: #selector(openVk), for: .touchUpInside)
        
        _btnOpenInstagram = ButtonDefault("Instagram")
        self.view.addSubview(_btnOpenInstagram!)
        setWidthOfButtonDefault(btn: _btnOpenInstagram!, topView: _btnOpenVk!)
        _btnOpenInstagram!.addTarget(self, action: #selector(openInstagram), for: .touchUpInside)
        
        
        //MARK: under main buttons
        
        let labelBranchTimiryazevskaya = UILabel(frame: CGRect())
        labelBranchTimiryazevskaya.font = UIFont(name: GlobalVariables.fontGothamProMediumSrc, size: 14)
        labelBranchTimiryazevskaya.textColor = .white
        labelBranchTimiryazevskaya.text = "Филиал Тимирязевская:"
        
        self.view.addSubview(labelBranchTimiryazevskaya)
        labelBranchTimiryazevskaya.translatesAutoresizingMaskIntoConstraints = false
        labelBranchTimiryazevskaya.topAnchor.constraint(equalTo: _btnOpenInstagram!.bottomAnchor, constant: 40).isActive = true
        labelBranchTimiryazevskaya.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 8).isActive = true
        labelBranchTimiryazevskaya.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -8).isActive = true
        
        _btnOpenBranchTimiryazevskaya = ButtonDefault("Написать нам")
        self.view.addSubview(_btnOpenBranchTimiryazevskaya!)
        _btnOpenBranchTimiryazevskaya!.translatesAutoresizingMaskIntoConstraints = false
        _btnOpenBranchTimiryazevskaya!.topAnchor.constraint(equalTo: labelBranchTimiryazevskaya.bottomAnchor, constant: 20).isActive = true
        _btnOpenBranchTimiryazevskaya!.widthAnchor.constraint(equalToConstant: 200).isActive = true
        _btnOpenBranchTimiryazevskaya!.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 8).isActive = true
        _btnOpenBranchTimiryazevskaya!.addTarget(self, action: #selector(openInstagram), for: .touchUpInside)
        
        
        
        let labelBranchVeresaeva = UILabel(frame: CGRect())
        labelBranchVeresaeva.font = UIFont(name: GlobalVariables.fontGothamProMediumSrc, size: 14)
        labelBranchVeresaeva.textColor = .white
        labelBranchVeresaeva.text = "Филиал Вересаева:"
        
        self.view.addSubview(labelBranchVeresaeva)
        labelBranchVeresaeva.translatesAutoresizingMaskIntoConstraints = false
        labelBranchVeresaeva.topAnchor.constraint(equalTo: _btnOpenBranchTimiryazevskaya!.bottomAnchor, constant: 40).isActive = true
        labelBranchVeresaeva.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 8).isActive = true
        labelBranchVeresaeva.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -8).isActive = true
        
        
        let labelBranchVeresaevaPhone = UILabel(frame: CGRect())
        labelBranchVeresaevaPhone.font = UIFont(name: GlobalVariables.fontGothamProLightSrc, size: 12)
        labelBranchVeresaevaPhone.textColor = .white
        labelBranchVeresaevaPhone.text = "8(495) 589-27-20 - ресепшн"
        
        self.view.addSubview(labelBranchVeresaevaPhone)
        labelBranchVeresaevaPhone.translatesAutoresizingMaskIntoConstraints = false
        labelBranchVeresaevaPhone.topAnchor.constraint(equalTo: labelBranchVeresaeva.bottomAnchor, constant: 20).isActive = true
        labelBranchVeresaevaPhone.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 8).isActive = true
        labelBranchVeresaevaPhone.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -8).isActive = true
    }
    
    private func setWidthOfButtonDefault(btn: ButtonDefault, topView: ButtonDefault? = nil){
        
        btn.translatesAutoresizingMaskIntoConstraints = false
        if topView == nil {
            btn.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 20).isActive = true
        } else {
            btn.topAnchor.constraint(equalTo: topView!.bottomAnchor, constant: 20).isActive = true
        }
        
        if self.view.frame.width > 300 {
            btn.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 8).isActive = true
            btn.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -8).isActive = true
        } else {
            btn.widthAnchor.constraint(equalToConstant: _maxWidth).isActive = true
            btn.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        }
    }
    
    
    @objc
    private func openSite(){
        let webURL = URL(string: "https://studio.lilfamnation.com")!
        UIApplication.shared.open(webURL)
    }
    @objc
    private func openVk(){
        let Username = "lilfam"
        let appURL = URL(string: "vk://vk.com/\(Username)")!
        let application = UIApplication.shared

        if application.canOpenURL(appURL) {
            application.open(appURL)
        } else {
            let webURL = URL(string: "https://vk.com/\(Username)")!
            application.open(webURL)
        }
    }
    @objc
    private func openInstagram(){
        let Username = "studio.lilfam.nation"
        let appURL = URL(string: "instagram://user?username=\(Username)")!
        let application = UIApplication.shared

        if application.canOpenURL(appURL) {
            application.open(appURL)
        } else {
            let webURL = URL(string: "https://instagram.com/\(Username)")!
            application.open(webURL)
        }
    }
    
    
}
