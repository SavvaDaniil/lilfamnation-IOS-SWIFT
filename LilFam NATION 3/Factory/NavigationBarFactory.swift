//
//  NavigationBarFactory.swift
//  LilFam NATION 3
//
//  Created by Daniil Savva on 12.01.2022.
//

import Foundation
import UIKit


class NavigationBarFactory {
    
    private var _leftSlideMenuDelegate: LeftSlideMenuDelegate?
    private var _parentController: UIViewController?
    private var _viewNavigationBarDelegate: ViewNavigationBarDelegate?
    
    public func createAndAddToController(
        parentController: UIViewController,
        leftSlideMenuDelegate: LeftSlideMenuDelegate,
        title: String? = nil
    ) -> NavigationBar {
        
        _leftSlideMenuDelegate = leftSlideMenuDelegate
        
        let navigationBar = NavigationBar(parentController:parentController, title: title, leftBarButtonItem: getBtnMenu())
        parentController.view.addSubview(navigationBar)
        navigationBar.translatesAutoresizingMaskIntoConstraints = false
        navigationBar.topAnchor.constraint(equalTo: parentController.view.safeTopAnchor).isActive = true
        navigationBar.leadingAnchor.constraint(equalTo: parentController.view.leadingAnchor).isActive = true
        navigationBar.trailingAnchor.constraint(equalTo: parentController.view.trailingAnchor).isActive = true
        navigationBar.heightAnchor.constraint(equalToConstant: 46).isActive = true
        
        
        //navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name: "CaviarDreams", size: 20)!]
        /*
        let navItem = UINavigationItem()
        
        navItem.title = "Заголовок"
        navItem.leftBarButtonItem = self.getBtnMenu()
        
        navigationBar.items = [navItem]
        */
        
        return navigationBar
    }
    
    private func getBtnMenu() -> UIBarButtonItem {
        let btnMenu: UIButton = UIButton(frame: CGRect())
        btnMenu.translatesAutoresizingMaskIntoConstraints = false
        btnMenu.heightAnchor.constraint(equalToConstant: 40).isActive = true
        btnMenu.widthAnchor.constraint(equalToConstant: 40).isActive = true
        
        //btnMenu.setImage(UIImage(named: "ic_menu"), for: .normal)
        let menuImageView = UIImageView(frame: CGRect())
        menuImageView.image = UIImage(named: "ic_menu")
        btnMenu.addSubview(menuImageView)
        menuImageView.translatesAutoresizingMaskIntoConstraints = false
        menuImageView.topAnchor.constraint(equalTo: btnMenu.topAnchor, constant: 8).isActive = true
        menuImageView.bottomAnchor.constraint(equalTo: btnMenu.bottomAnchor, constant: -6).isActive = true
        menuImageView.leadingAnchor.constraint(equalTo: btnMenu.leadingAnchor, constant: 6).isActive = true
        menuImageView.trailingAnchor.constraint(equalTo: btnMenu.trailingAnchor, constant: -6).isActive = true
        
        btnMenu.addTarget(self, action: #selector(btnMenuClick), for: .touchUpInside)
        
        let btnMenuItem: UIBarButtonItem = UIBarButtonItem(customView: btnMenu)
        return btnMenuItem
    }
    
    @objc
    private func btnMenuClick() -> (){
        print("btnMenuClick")
        
        self._leftSlideMenuDelegate?.handleMenuToggle()
    }
    
    public func createWithOnlyButtonBack(
        parentController: UIViewController,
        titleText: String
    ) -> NavigationBar
    {
        _parentController = parentController
        
        let navigationBar = NavigationBar(parentController:parentController)
        parentController.view.addSubview(navigationBar)
        navigationBar.translatesAutoresizingMaskIntoConstraints = false
        navigationBar.topAnchor.constraint(equalTo: parentController.view.safeTopAnchor).isActive = true
        navigationBar.leadingAnchor.constraint(equalTo: parentController.view.leadingAnchor).isActive = true
        navigationBar.trailingAnchor.constraint(equalTo: parentController.view.trailingAnchor).isActive = true
        navigationBar.heightAnchor.constraint(equalToConstant: 46).isActive = true
        
        let navItem = UINavigationItem()
        
        navItem.title = titleText
        navItem.leftBarButtonItem = self.getBtnBack()
        navigationBar.items = [navItem]
        
        return navigationBar
    }
    
    private func getBtnBack() -> UIBarButtonItem {
        let btnBack: UIButton = UIButton(frame: CGRect())
        btnBack.translatesAutoresizingMaskIntoConstraints = false
        btnBack.heightAnchor.constraint(equalToConstant: 40).isActive = true
        btnBack.widthAnchor.constraint(equalToConstant: 40).isActive = true
        
        //btnMenu.setImage(UIImage(named: "ic_menu"), for: .normal)
        let backImageView = UIImageView(frame: CGRect())
        backImageView.image = UIImage(named: "back")
        btnBack.addSubview(backImageView)
        backImageView.translatesAutoresizingMaskIntoConstraints = false
        backImageView.topAnchor.constraint(equalTo: btnBack.topAnchor, constant: 8).isActive = true
        backImageView.bottomAnchor.constraint(equalTo: btnBack.bottomAnchor, constant: -6).isActive = true
        backImageView.leadingAnchor.constraint(equalTo: btnBack.leadingAnchor, constant: 6).isActive = true
        backImageView.trailingAnchor.constraint(equalTo: btnBack.trailingAnchor, constant: -6).isActive = true
        
        btnBack.addTarget(self, action: #selector(closeController), for: .touchUpInside)
        
        let btnBackItem: UIBarButtonItem = UIBarButtonItem(customView: btnBack)
        return btnBackItem
    }
    @objc
    private func closeController(){
        _parentController?.dismissToRight()
    }
    
    
    public func createWithButtonBackAndButtonRefresh(
        parentController: UIViewController,
        viewNavigationBarDelegate: ViewNavigationBarDelegate,
        titleText: String
    ) -> NavigationBar
    {
        _parentController = parentController
        _viewNavigationBarDelegate = viewNavigationBarDelegate
        
        let navigationBar = NavigationBar(parentController:parentController)
        parentController.view.addSubview(navigationBar)
        navigationBar.translatesAutoresizingMaskIntoConstraints = false
        navigationBar.topAnchor.constraint(equalTo: parentController.view.safeTopAnchor).isActive = true
        navigationBar.leadingAnchor.constraint(equalTo: parentController.view.leadingAnchor).isActive = true
        navigationBar.trailingAnchor.constraint(equalTo: parentController.view.trailingAnchor).isActive = true
        navigationBar.heightAnchor.constraint(equalToConstant: 46).isActive = true
        
        let navItem = UINavigationItem()
        
        navItem.title = titleText
        navItem.leftBarButtonItem = self.getBtnBack()
        navItem.rightBarButtonItem = self.getBtnRefresh()
        navigationBar.items = [navItem]
        
        return navigationBar
    }
    
    private func getBtnRefresh() -> UIBarButtonItem {
        let btnRefresh: UIButton = UIButton(frame: CGRect())
        btnRefresh.translatesAutoresizingMaskIntoConstraints = false
        btnRefresh.heightAnchor.constraint(equalToConstant: 40).isActive = true
        btnRefresh.widthAnchor.constraint(equalToConstant: 40).isActive = true
        
        let backImageView = UIImageView(frame: CGRect())
        backImageView.image = UIImage(named: "refresh")
        btnRefresh.addSubview(backImageView)
        backImageView.translatesAutoresizingMaskIntoConstraints = false
        backImageView.topAnchor.constraint(equalTo: btnRefresh.topAnchor, constant: 8).isActive = true
        backImageView.bottomAnchor.constraint(equalTo: btnRefresh.bottomAnchor, constant: -6).isActive = true
        backImageView.leadingAnchor.constraint(equalTo: btnRefresh.leadingAnchor, constant: 6).isActive = true
        backImageView.trailingAnchor.constraint(equalTo: btnRefresh.trailingAnchor, constant: -6).isActive = true
        
        btnRefresh.addTarget(self, action: #selector(callBackRefresh), for: .touchUpInside)
        
        let btnBackItem: UIBarButtonItem = UIBarButtonItem(customView: btnRefresh)
        return btnBackItem
    }
    @objc
    private func callBackRefresh(){
        _viewNavigationBarDelegate!.navigationBarRefreshCallback()
    }
    
    
    public func createAndAddWithBtnMenuAndBtnRefresh(
        parentController: UIViewController,
        leftSlideMenuDelegate: LeftSlideMenuDelegate,
        viewNavigationBarDelegate: ViewNavigationBarDelegate,
        titleText: String? = nil
    ) -> NavigationBar {
        
        _parentController = parentController
        _leftSlideMenuDelegate = leftSlideMenuDelegate
        _viewNavigationBarDelegate = viewNavigationBarDelegate
        
        let navigationBar = NavigationBar(parentController:parentController)
        parentController.view.addSubview(navigationBar)
        navigationBar.translatesAutoresizingMaskIntoConstraints = false
        navigationBar.topAnchor.constraint(equalTo: parentController.view.safeTopAnchor).isActive = true
        navigationBar.leadingAnchor.constraint(equalTo: parentController.view.leadingAnchor).isActive = true
        navigationBar.trailingAnchor.constraint(equalTo: parentController.view.trailingAnchor).isActive = true
        navigationBar.heightAnchor.constraint(equalToConstant: 46).isActive = true
        
        let navItem = UINavigationItem()
        
        navItem.title = titleText
        navItem.leftBarButtonItem = self.getBtnMenu()
        navItem.rightBarButtonItem = self.getBtnRefresh()
        navigationBar.items = [navItem]
        
        return navigationBar
    }
}
