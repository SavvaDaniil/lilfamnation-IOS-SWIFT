//
//  PurchaseAbonementHistoryController.swift
//  LilFam NATION 3
//
//  Created by Daniil Savva on 06.02.2022.
//

import UIKit
import CoreData

class PurchaseAbonementHistoryController : UIViewController, LoadingOrErrorViewDelegate, PurchaseAbonementDelegate {
    
    private var _context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    private var _danceGroupLessonDelegate: DanceGroupLessonDelegate?
    
    private var _loadingOrErrorViewFactory = LoadingOrErrorViewFactory()
    private var _loadingOrErrorView: LoadingOrErrorView?
    
    private var _purchaseAbonementFacade: PurchaseAbonementFacade?
    private var _purchaseAbonementHistoryView: PurchaseAbonementHistoryView?
    private var _purchaseAbonementInfoController : PurchaseAbonementInfoController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        let controllerBackgroundImageFactory = ControllerBackgroundImageFactory()
        controllerBackgroundImageFactory.createAndAdd(parentController: self)
        
        _loadingOrErrorView = _loadingOrErrorViewFactory.create(parentController: self, loadingOrErrorViewDelegate: self, topView: nil, bottomView: nil)
        
        _purchaseAbonementFacade = PurchaseAbonementFacade(_context)
        
        _purchaseAbonementHistoryView = PurchaseAbonementHistoryView(context: _context, parentController: self, purchaseAbonementDelegate: self)
        
        self.view.addSubview(_purchaseAbonementHistoryView!)
        _purchaseAbonementHistoryView!.translatesAutoresizingMaskIntoConstraints = false
        _purchaseAbonementHistoryView!.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        _purchaseAbonementHistoryView!.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        _purchaseAbonementHistoryView!.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        _purchaseAbonementHistoryView!.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        _purchaseAbonementHistoryView!.isHidden = true
        
    }
    
    public func setup(danceGroupLessonDelegate: DanceGroupLessonDelegate){
        _danceGroupLessonDelegate = danceGroupLessonDelegate
    }
    
    public func update(){
        _purchaseAbonementHistoryView!.isHidden = true
        _loadingOrErrorView!.setLoadingStatus()
        _purchaseAbonementFacade!.listAll(purchaseAbonementDelegate: self)
    }
    
    internal func loadingOrErrorTryAgain() {
        update()
    }
    
    internal func purchaseAbonementListAllResult(status: String?, errors: String?) {
        if status == "success" {
            _purchaseAbonementHistoryView!.update()
            _purchaseAbonementHistoryView!.isHidden = false
            _loadingOrErrorView!.setDeactivatedStatus()
        } else {
            _purchaseAbonementHistoryView!.isHidden = true
            _loadingOrErrorView!.setErrorStatus()
        }
    }
    internal func purchaseAbonementOpenInfo(purchaseAbonementLite: PurchaseAbonementLite) {
        _purchaseAbonementInfoController = PurchaseAbonementInfoController()
        _purchaseAbonementInfoController!.modalPresentationStyle = .fullScreen
        _purchaseAbonementInfoController!.setup(purchaseAbonementLite: purchaseAbonementLite, danceGroupLessonDelegate: _danceGroupLessonDelegate!)
        self.presentFromRight(_purchaseAbonementInfoController!)
    }
    internal func purchaseAbonementInfoResult(status: String?, errors: String?) {
        fatalError("purchaseAbonementInfoResult не должна запускаться в PurchaseAbonementHistoryController")
    }
    internal func purchaseAbonementNotAuth() {
        
    }
    
    internal func purchaseAbonementForceLogout() {
        
    }
    
}
