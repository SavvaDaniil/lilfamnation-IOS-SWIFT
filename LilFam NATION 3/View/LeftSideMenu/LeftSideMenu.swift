//
//  LeftSideMenu.swift
//  LilFam NATION 3
//
//  Created by Daniil Savva on 12.01.2022.
//

import UIKit
import CoreData

class LeftSideMenu : UIView {
    
    private let _menuGuest: [LeftSideMenuRowViewModel] = [
        LeftSideMenuRowViewModel(nameIdentity: "signIn", name: "Войти"),
        LeftSideMenuRowViewModel(nameIdentity: "lessons", name: "Группы"),
        LeftSideMenuRowViewModel(nameIdentity: "visits", name: "Мои занятия"),
        LeftSideMenuRowViewModel(nameIdentity: "purchases", name: "История покупок"),
        LeftSideMenuRowViewModel(nameIdentity: "buyAbonement", name: "Купить абонемент"),
        LeftSideMenuRowViewModel(nameIdentity: "contacts", name: "Контакты")
    ]
    private let _menuAuth: [LeftSideMenuRowViewModel] = [
        LeftSideMenuRowViewModel(nameIdentity: "account", name: "Профиль"),
        //LeftSideMenuRowViewModel(nameIdentity: "qrcode", name: "QR-код"),
        LeftSideMenuRowViewModel(nameIdentity: "lessons", name: "Группы"),
        LeftSideMenuRowViewModel(nameIdentity: "visits", name: "Мои занятия"),
        LeftSideMenuRowViewModel(nameIdentity: "purchases", name: "История покупок"),
        LeftSideMenuRowViewModel(nameIdentity: "buyAbonement", name: "Купить абонемент"),
        LeftSideMenuRowViewModel(nameIdentity: "contacts", name: "Контакты"),
        LeftSideMenuRowViewModel(nameIdentity: "signOut", name: "Выйти")
    ]
    private var _menuCurrent:[LeftSideMenuRowViewModel] = [LeftSideMenuRowViewModel]()
    
    private var _context: NSManagedObjectContext
    private var _parentController: UIViewController?
    private var _leftSlideMenuDelegate: LeftSlideMenuDelegate?
    private var _gestureTouch: UITapGestureRecognizer?
    private var _isAuth: Bool = false
    
    private var _widthOfMenuContent: Int = 0
    private var _menuBgd : UIView?
    private var _menuSide: UIView?
    private var _logoView: UIView?
    private var _logoImage: UIImageView?
    private var _leftSideMenuTableView: LeftSideMenuTableView?
    private var _gestureOpenAdminController: UITapGestureRecognizer?
    
    init(context: NSManagedObjectContext, parentController: UIViewController, leftSlideMenuDelegate: LeftSlideMenuDelegate){
        
        _widthOfMenuContent = Int(parentController.view.frame.width * 0.25)
        
        _context = context
        _parentController = parentController
        _leftSlideMenuDelegate = leftSlideMenuDelegate
        
        super.init(frame: CGRect())
        
        _menuBgd = UIView(frame: CGRect())
        self.addSubview(_menuBgd!)
        _menuBgd!.translatesAutoresizingMaskIntoConstraints = false
        _menuBgd!.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        _menuBgd!.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        _menuBgd!.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        _menuBgd!.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        //_menuBgd!.backgroundColor = .gray
        //_menuBgd!.layer.opacity = 0.5
        
        
        _gestureTouch = UITapGestureRecognizer(target: self, action: #selector(closeMenu))
        _menuBgd!.addGestureRecognizer(_gestureTouch!)
        
        
        _menuSide = UIView(frame: CGRect())
        self.addSubview(_menuSide!)
        _menuSide!.translatesAutoresizingMaskIntoConstraints = false
        _menuSide!.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        _menuSide!.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        _menuSide!.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        _menuSide!.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: CGFloat(-_widthOfMenuContent)).isActive = true
        _menuSide!.backgroundColor = .white
        
        self.setLogo()
        
        
        _leftSideMenuTableView = LeftSideMenuTableView(parentController.view)
        _menuSide!.addSubview(_leftSideMenuTableView!)
        _leftSideMenuTableView!.translatesAutoresizingMaskIntoConstraints = false
        _leftSideMenuTableView!.topAnchor.constraint(equalTo: _logoView!.bottomAnchor).isActive = true
        _leftSideMenuTableView!.leadingAnchor.constraint(equalTo: _menuSide!.leadingAnchor).isActive = true
        _leftSideMenuTableView!.trailingAnchor.constraint(equalTo: _menuSide!.trailingAnchor).isActive = true
        _leftSideMenuTableView!.bottomAnchor.constraint(equalTo: _menuSide!.bottomAnchor).isActive = true
        
        _leftSideMenuTableView!.delegate = self
        _leftSideMenuTableView!.dataSource = self
        
        
        updateMenuCurrent()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    @objc
    private func closeMenu(){
        _leftSlideMenuDelegate?.handleMenuToggle()
    }
    
    
    private func setLogo() -> (){
        let heightOfLogo: Int = Int(120 * 3 / 4.5)
        
        _logoView = UIView(frame: CGRect())
        _logoView!.backgroundColor = .black
        _menuSide!.addSubview(_logoView!)
        _logoView!.translatesAutoresizingMaskIntoConstraints = false
        _logoView!.topAnchor.constraint(equalTo: _menuSide!.topAnchor).isActive = true
        _logoView!.leadingAnchor.constraint(equalTo: _menuSide!.leadingAnchor).isActive = true
        _logoView!.trailingAnchor.constraint(equalTo: _menuSide!.trailingAnchor).isActive = true
        _logoView!.heightAnchor.constraint(equalToConstant: CGFloat(heightOfLogo + 40)).isActive = true
        
        _logoImage = UIImageView(frame: CGRect())
        //_logoImage?.backgroundColor = .black
        _logoImage!.layer.cornerRadius = 8
        _logoImage?.image = UIImage(named: "logo")
        _logoView!.addSubview(_logoImage!)
        
        _logoImage!.translatesAutoresizingMaskIntoConstraints = false
        _logoImage!.topAnchor.constraint(equalTo: _logoView!.topAnchor, constant: 20).isActive = true
        _logoImage!.leadingAnchor.constraint(equalTo: _logoView!.leadingAnchor,constant: 20).isActive = true
        _logoImage!.heightAnchor.constraint(equalToConstant: (120 * 3 / 4.5)).isActive = true
        _logoImage!.widthAnchor.constraint(equalToConstant: 120).isActive = true
        
        
        _gestureOpenAdminController = UITapGestureRecognizer(target: self, action: #selector(tryOpenAdminController))
        _gestureOpenAdminController!.numberOfTapsRequired = 2
        _logoView!.addGestureRecognizer(_gestureOpenAdminController!)
        _gestureOpenAdminController!.delaysTouchesBegan = true
    }
    
    public func setIsAuth(isAuth: Bool){
        _isAuth = isAuth
        updateMenuCurrent()
    }
    public func getIsAuth() -> Bool {
        return _isAuth
    }
    private func updateMenuCurrent(){
        if _isAuth {
            _menuCurrent = _menuAuth
        } else {
            _menuCurrent = _menuGuest
        }
        _leftSideMenuTableView?.reloadData()
    }
    
    private func openModalSignOut(){
        let logoutAlert = UIAlertController(title: "Выйти из аккаунта", message: "Вы уверены, что хотите выйти из аккаунта", preferredStyle: .alert)

        logoutAlert.addAction(UIAlertAction(title: "Выйти", style: .cancel, handler: { (action: UIAlertAction!) in
            self._leftSlideMenuDelegate!.handleMenuLogout()
          }))

        logoutAlert.addAction(UIAlertAction(title: "Отмена", style: .default, handler: { (action: UIAlertAction!) in
          
          }))

        _parentController?.present(logoutAlert, animated: false, completion: nil)
    }
    
    @objc
    private func tryOpenAdminController(){
        print("tryOpenAdminController")
    }
        
    
}


extension LeftSideMenu: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return _menuCurrent.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "cellLeftSideMenu")
        var content = cell.defaultContentConfiguration()
        content.text = _menuCurrent[indexPath.row].name
        content.textProperties.color = .black
        
        cell.contentConfiguration = content
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if _menuCurrent[indexPath.row].nameIdentity == "signOut" {
            let userFacade = UserFacade(_context)
            if userFacade.logout() {
                openModalSignOut()
            }
            return
        }
        
        _leftSlideMenuDelegate!.handleChangeMenu(nameIdentity: _menuCurrent[indexPath.row].nameIdentity, title: _menuCurrent[indexPath.row].name)
    }
}

