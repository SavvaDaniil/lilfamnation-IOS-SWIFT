//
//  VisitPrepareViewFactory.swift
//  LilFam NATION 3
//
//  Created by Daniil Savva on 30.01.2022.
//

import UIKit
import CoreData

class VisitPrepareViewFactory {
    
    private var _context: NSManagedObjectContext
    //private var _visitDelegate: VisitDelegate
    //private var _visitPaymentDelegate: VisitPaymentDelegate
    //init(context: NSManagedObjectContext,visitDelegate: VisitDelegate, visitPaymentDelegate: VisitPaymentDelegate){
    init(context: NSManagedObjectContext){
        _context = context
        //_visitDelegate = visitDelegate
        //_visitPaymentDelegate = visitPaymentDelegate
    }
    
    public func createPurchasesAbonementView(parentController: UIViewController, visitDelegate: VisitDelegate, topView: UIView, bottomView: UIView, isHidden: Bool = true) -> VisitPreparePurchasesAbonementView {
        let view = VisitPreparePurchasesAbonementView(
            context:_context,
            parentController: parentController,
            visitDelegate: visitDelegate)
        parentController.view.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.topAnchor.constraint(equalTo: topView.bottomAnchor).isActive = true
        view.bottomAnchor.constraint(equalTo: bottomView.topAnchor).isActive = true
        view.leadingAnchor.constraint(equalTo: parentController.view.leadingAnchor).isActive = true
        view.trailingAnchor.constraint(equalTo: parentController.view.trailingAnchor).isActive = true
        view.isHidden = isHidden
        
        return view
    }
    
    public func createAbonementsView(parentController: UIViewController, visitPaymentDelegate: VisitPaymentDelegate, topView: UIView?, bottomView: UIView?, isHidden: Bool = true) -> VisitPrepareAbonementsView {
        let view = VisitPrepareAbonementsView(context:_context, parentController: parentController, visitPaymentDelegate: visitPaymentDelegate)
        parentController.view.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        if topView != nil {
            view.topAnchor.constraint(equalTo: topView!.bottomAnchor).isActive = true
        } else {
            view.topAnchor.constraint(equalTo: parentController.view.topAnchor).isActive = true
        }
        
        if bottomView != nil {
            view.bottomAnchor.constraint(equalTo: bottomView!.topAnchor).isActive = true
        } else {
            view.bottomAnchor.constraint(equalTo: parentController.view.bottomAnchor).isActive = true
        }
        
        view.leadingAnchor.constraint(equalTo: parentController.view.leadingAnchor).isActive = true
        view.trailingAnchor.constraint(equalTo: parentController.view.trailingAnchor).isActive = true
        view.isHidden = isHidden
        
        return view
    }
    
}
