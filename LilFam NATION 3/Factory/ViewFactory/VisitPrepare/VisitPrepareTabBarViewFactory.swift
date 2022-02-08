//
//  VisitPrepareTabBarViewFactory.swift
//  LilFam NATION 3
//
//  Created by Daniil Savva on 30.01.2022.
//

import UIKit


class VisitPrepareTabBarViewFactory {
    
    private var _parentController: UIViewController?
    private var _visitPrepareTabBarViewDelegate: VisitPrepareTabBarViewDelegate?
    private var _visitPrepareTabBarView = VisitPrepareTabBarView()
    private let _visitPrepareTabButtonFactory = VisitPrepareTabButtonFactory()
    
    public func create(
        parentController: UIViewController,
        visitPrepareTabBarViewDelegate: VisitPrepareTabBarViewDelegate
    ) -> VisitPrepareTabBarView {
        _parentController  = parentController
        _visitPrepareTabBarViewDelegate = visitPrepareTabBarViewDelegate
        
        let tabBarCustom = VisitPrepareTabBarView()
        parentController.view.addSubview(tabBarCustom)
        tabBarCustom.translatesAutoresizingMaskIntoConstraints = false
        tabBarCustom.bottomAnchor.constraint(equalTo: parentController.view.bottomAnchor).isActive = true
        tabBarCustom.leadingAnchor.constraint(equalTo: parentController.view.leadingAnchor).isActive = true
        tabBarCustom.trailingAnchor.constraint(equalTo: parentController.view.trailingAnchor).isActive = true
        tabBarCustom.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        let btnPurchasesAbonement = _visitPrepareTabButtonFactory.create(parentController: parentController, parentView: tabBarCustom, titleText: "Активные", indexOfBtnFrom2: 0)
        btnPurchasesAbonement.addTarget(self, action: #selector(changeTab), for: .touchUpInside)
        
        let btnAbonements = _visitPrepareTabButtonFactory.create(parentController: parentController, parentView: tabBarCustom, titleText: "Купить", indexOfBtnFrom2: 1)
        btnAbonements.addTarget(self, action: #selector(changeTab), for: .touchUpInside)
        
        tabBarCustom.tabButtons.append(btnPurchasesAbonement)
        tabBarCustom.tabButtons.append(btnAbonements)
        
        return tabBarCustom
    }
    
    @objc
    private func changeTab(sender: AuthTabButton){
        _visitPrepareTabBarViewDelegate?.changeTab(didSelect: sender.getIndex())
    }
    
    private func changeBtnTabActive(index: UInt8){
        
    }
}
