//
//  MenuTableView.swift
//  LilFam NATION 3
//
//  Created by Daniil Savva on 25.03.2021.
//

import UIKit

class TestClass {
    public static func printTest() -> Void{
        print("printTest")
    }
}

class MenuTableView : UITableView, UITableViewDataSource, UITableViewDelegate {
    
    // MARK: - Public properties
    private let cellReuseIdentifier = "menuCell"
    private var _leftSlideMenuDelegate: LeftSlideMenuDelegate?
    private let menuGuest: [String] = [
        "Войти",
        "Группы",
        "Мои занятия",
        "История покупок",
        "Купить абонемент",
        "Контакты"
    ]
    private let menuAuth: [String] = [
        "Профиль",
        "QR-код",
        "Группы",
        "Мои занятия",
        "История покупок",
        "Купить абонемент",
        "Контакты",
        "Выйти"
    ]
    private var menu:[String] = [String]()
    
    // MARK: - Public methods
    
    public func setup(isQuest: Bool) -> Void {
        menu = isQuest ? menuGuest : menuAuth
        
        self.tableFooterView = UIView()
        self.bounces = false
        self.delegate = self
        self.dataSource = self
    }
}

extension MenuTableView {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.menu.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.cellReuseIdentifier, for:indexPath)
        cell.textLabel?.text = self.menu[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped cell number \(indexPath.row).")
        print("MenuTableView")
        //menuDelegate?.handleMenuToggle(choosedPanel: menu[indexPath.row])
    }
}
