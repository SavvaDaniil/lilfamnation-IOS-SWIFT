//
//  PurchaseAbonementInfoController.swift
//  LilFam NATION 3
//
//  Created by Daniil Savva on 07.02.2022.
//

import UIKit
import CoreData

class PurchaseAbonementInfoController : UIViewController, LoadingOrErrorViewDelegate, PurchaseAbonementDelegate, ViewNavigationBarDelegate, VisitsHistoryDelegate {
    
    private var _context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    private var _danceGroupLessonDelegate: DanceGroupLessonDelegate?
    
    private let _navigationBarFactory: NavigationBarFactory = NavigationBarFactory()
    private var _navigationBar: NavigationBar?
    private var _loadingOrErrorViewFactory = LoadingOrErrorViewFactory()
    private var _loadingOrErrorView: LoadingOrErrorView?
    
    private var _purchaseAbonementLite: PurchaseAbonementLite?
    private var _purchaseAbonementInfoView: PurchaseAbonementInfoView?
    private var _visitFacade: VisitFacade?
    private var _danceGroupLessonController: DanceGroupLessonController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let controllerBackgroundImageFactory = ControllerBackgroundImageFactory()
        controllerBackgroundImageFactory.createAndAdd(parentController: self)
        
        _navigationBar = _navigationBarFactory.createWithButtonBackAndButtonRefresh(parentController: self, viewNavigationBarDelegate: self, titleText: "")
        _loadingOrErrorView = _loadingOrErrorViewFactory.create(parentController: self, loadingOrErrorViewDelegate: self, topView: _navigationBar!, bottomView: nil)
        
        _visitFacade = VisitFacade(_context)
        
        _purchaseAbonementInfoView = PurchaseAbonementInfoView(context: _context, parentController: self, visitsHistoryDelegate: self)
        self.view.addSubview(_purchaseAbonementInfoView!)
        _purchaseAbonementInfoView!.translatesAutoresizingMaskIntoConstraints = false
        _purchaseAbonementInfoView!.topAnchor.constraint(equalTo: _navigationBar!.bottomAnchor).isActive = true
        _purchaseAbonementInfoView!.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        _purchaseAbonementInfoView!.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        _purchaseAbonementInfoView!.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        _purchaseAbonementInfoView!.isHidden = true
        
        if _purchaseAbonementLite != nil {
            _purchaseAbonementInfoView!.setup(purchaseAbonementLite: _purchaseAbonementLite!)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        update()
    }
    
    internal func loadingOrErrorTryAgain() {
        update()
    }
    public func setup(purchaseAbonementLite: PurchaseAbonementLite, danceGroupLessonDelegate: DanceGroupLessonDelegate){
        _purchaseAbonementLite = purchaseAbonementLite
        _danceGroupLessonDelegate = danceGroupLessonDelegate
    }
    
    internal func navigationBarRefreshCallback() {
        update()
    }
    
    private func update(){
        _purchaseAbonementInfoView!.isHidden = true
        _loadingOrErrorView!.setLoadingStatus()
        _visitFacade!.listAllByPurchaseAbonement(
            purchaseAbonementDelegate: self,
            id_of_purchase_abonement: _purchaseAbonementLite!.id_of_purchase_abonement ?? 0
        )
    }
    
}


extension PurchaseAbonementInfoController {
    
    func purchaseAbonementListAllResult(status: String?, errors: String?) {
        fatalError("purchaseAbonementListAllResult не должна запускаться в PurchaseAbonementInfoController")
    }
    
    func purchaseAbonementOpenInfo(purchaseAbonementLite: PurchaseAbonementLite) {
        fatalError("purchaseAbonementOpenInfo не должна запускаться в PurchaseAbonementInfoController")
    }
    
    func purchaseAbonementInfoResult(status: String?, errors: String?) {
        if status == "success" {
            _purchaseAbonementInfoView!.update()
            _purchaseAbonementInfoView!.isHidden = false
            _loadingOrErrorView!.setDeactivatedStatus()
        } else {
            _purchaseAbonementInfoView!.isHidden = true
            _loadingOrErrorView!.setErrorStatus()
        }
    }
    
    func purchaseAbonementNotAuth() {
        
    }
    
    func purchaseAbonementForceLogout() {
        
    }
    
    func visitsHistoryGetLesson(id_of_dance_group: Int, id_of_dance_group_day_of_week: Int, date_of_lesson_str: String, id_of_visit: Int) {
        
        _danceGroupLessonController = DanceGroupLessonController()
        _danceGroupLessonController?.modalPresentationStyle = .fullScreen
        
        _danceGroupLessonController!.setup(
            id_of_dance_group: id_of_dance_group,
            id_of_dance_group_day_of_week: id_of_dance_group_day_of_week,
            date_of_lesson_str: date_of_lesson_str,
            id_of_visit: id_of_visit
        )
        self.presentFromRight(_danceGroupLessonController!)
    }
}
