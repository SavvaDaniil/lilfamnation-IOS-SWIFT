//
//  MenuDelegate.swift
//  LilFam NATION 3
//
//  Created by Daniil Savva on 22.03.2021.
//

protocol LeftSlideMenuDelegate {
    func handleMenuToggle() -> ()
    func handleChangeMenu(nameIdentity: String, title: String) -> ()
    func handleMenuLogout() -> ()
}
