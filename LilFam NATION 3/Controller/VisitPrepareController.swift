//
//  VisitPrepareController.swift
//  LilFam NATION 3
//
//  Created by Daniil Savva on 28.01.2022.
//

import UIKit
import CoreData

class VisitPrepareController : UIViewController, VisitPrepareTabBarViewDelegate, VisitPrepareViewDelegate, VisitDelegate, VisitPaymentDelegate, LoadingOrErrorViewDelegate, ViewNavigationBarDelegate {
    
    private var _context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    private var _id_of_dance_group: Int?
    private var _id_of_dance_group_day_of_week: Int?
    private var _date_of_lesson_str: String?
    private var _danceGroupLessonDelegate: DanceGroupLessonDelegate?
    
    private let _navigationBarFactory: NavigationBarFactory = NavigationBarFactory()
    private var _navigationBar: NavigationBar?
    private var _loadingOrErrorViewFactory = LoadingOrErrorViewFactory()
    private var _loadingOrErrorView: LoadingOrErrorView?
    
    private var _visitDelegate: VisitDelegate?
    
    private let _visitPrepareTabBarViewFactory = VisitPrepareTabBarViewFactory()
    private var _visitPrepareTabBarView: VisitPrepareTabBarView?
    
    private var _visitPrepareViewFactory: VisitPrepareViewFactory?
    private var _visitPreparePurchasesAbonementView: VisitPreparePurchasesAbonementView?
    private var _visitPrepareAbonementsView: VisitPrepareAbonementsView?
    private var _visitFacade: VisitFacade?
    private var _paymentPrepareController: PaymentPrepareController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let controllerBackgroundImageFactory = ControllerBackgroundImageFactory()
        controllerBackgroundImageFactory.createAndAdd(parentController: self)
        
        _navigationBar = _navigationBarFactory.createWithButtonBackAndButtonRefresh(parentController: self, viewNavigationBarDelegate: self, titleText: "")
        
        _loadingOrErrorView = _loadingOrErrorViewFactory.create(parentController: self, loadingOrErrorViewDelegate: self, topView: _navigationBar!, bottomView: nil)
        
        _visitPrepareTabBarView = _visitPrepareTabBarViewFactory.create(parentController: self, visitPrepareTabBarViewDelegate: self)
        
        _visitPrepareViewFactory = VisitPrepareViewFactory(context: _context)
        _visitPreparePurchasesAbonementView = _visitPrepareViewFactory!.createPurchasesAbonementView(parentController: self, visitDelegate: self, topView: _navigationBar!, bottomView: _visitPrepareTabBarView!, isHidden: false)
        _visitPrepareAbonementsView = _visitPrepareViewFactory!.createAbonementsView(parentController: self, visitPaymentDelegate: self, topView: _navigationBar!, bottomView: _visitPrepareTabBarView!)
        
        _visitFacade = VisitFacade(_context)
        
        //_visitPreparePurchasesAbonementView!.update()
        //_visitPrepareAbonementsView!.update()
        update()
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
    internal func navigationBarRefreshCallback() {
        update()
    }
    internal func loadingOrErrorTryAgain() {
        update()
    }
    
    
    
    public func setup(
        id_of_dance_group: Int,
        id_of_dance_group_day_of_week: Int,
        date_of_lesson_str: String,
        danceGroupLessonDelegate: DanceGroupLessonDelegate
    ){
        _id_of_dance_group = id_of_dance_group
        _id_of_dance_group_day_of_week = id_of_dance_group_day_of_week
        _date_of_lesson_str = date_of_lesson_str
        _danceGroupLessonDelegate = danceGroupLessonDelegate
    }
    
    private func update(){
        _visitPrepareTabBarView?.isHidden = true
        _visitPreparePurchasesAbonementView?.isHidden = true
        _visitPrepareAbonementsView?.isHidden = true
        _loadingOrErrorView?.setLoadingStatus()
        
        _visitFacade!.prepare(
            visitDelegate: self,
            id_of_dance_group: _id_of_dance_group ?? 0,
            id_of_dance_group_day_of_week: _id_of_dance_group_day_of_week ?? 0,
            date_of_lesson: _date_of_lesson_str ?? ""
        )
    }
    
    
    internal func changeTab(didSelect tag: Int) {
        _visitPrepareTabBarView!.changeActiveTabButton(index: tag)
        switch tag  {
            case 0:
            hideAllViews()
            _visitPreparePurchasesAbonementView?.isHidden = false
                break
            case 1:
            hideAllViews()
            _visitPrepareAbonementsView?.isHidden = false
                break
            default:
                break
        }
    }
    private func hideAllViews(){
        _visitPreparePurchasesAbonementView?.isHidden = true
        _visitPrepareAbonementsView?.isHidden = true
    }
    
    internal func visitPrepareResult(status: String?, errors: String?) {
        if status == "success" {
            _loadingOrErrorView?.setDeactivatedStatus()
            _visitPreparePurchasesAbonementView!.update()
            _visitPrepareAbonementsView!.update()
            _visitPrepareTabBarView?.isHidden = false
            changeTab(didSelect: 0)
        } else {
            _visitPrepareTabBarView?.isHidden = true
            _visitPreparePurchasesAbonementView?.isHidden = true
            _visitPrepareAbonementsView?.isHidden = true
            _loadingOrErrorView?.setErrorStatus()
        }
    }
    internal func visitPaymentAfterAction() {
        _paymentPrepareController!.dismiss(animated: false, completion: { [self] in
            _danceGroupLessonDelegate!.danceGroupLessonAfterVisitAction()
        })
    }
    internal func visitAdd(id_of_purchase_abonement: Int) {
        
        if _id_of_dance_group == 0 {
            AlertComponent.callAlertError("Группа не опознана. Свяжитесь пожалуйста с администратором", self)
        }
        if _id_of_dance_group_day_of_week == 0 {
            AlertComponent.callAlertError("День занятия не опознан. Свяжитесь пожалуйста с администратором", self)
        }
        if _date_of_lesson_str == nil {
            AlertComponent.callAlertError("Дата занятия не опознана. Свяжитесь пожалуйста с администратором", self)
        }
        
        _visitFacade?.add(
            visitDelegate: self,
            id_of_dance_group: _id_of_dance_group!,
            id_of_dance_group_day_of_week: _id_of_dance_group_day_of_week!,
            id_of_purchase_abonement: id_of_purchase_abonement,
            date_of_day: _date_of_lesson_str!
        )
    }
    internal func visitAddResult(status: String?, errors: String?) {
        if status == "success" {
            _danceGroupLessonDelegate!.danceGroupLessonAfterVisitAction()
        } else {
            AlertComponent.callAlertError("Во время отмечани на занятие произошла ошибка. Сообщите пожалуйста администратору", self)
        }
    }
    internal func visitDeleteResult(status: String?, errors: String?) {
        /*
        if status == "success" {
            _danceGroupLessonDelegate!.danceGroupLessonAfterVisitAction()
        } else {
            AlertComponent.callAlertError("Во время отмены визита произошла ошибка. Сообщите пожалуйста администратору", self)
        }*/
        fatalError("Отмена визита происходит не из окна VisitPrepareController")
    }
    
    
    
    func visitNotAuth() {
        
    }
    
    func visitForceLogout() {
        
    }
    func openVisitPrepare() {
        fatalError("openVisitPrepare не должен срабатывать в уже открытом окне VisitPrepareController")
    }
    
    
    func visitPaymentBegin(abonementLite: AbonementLite) {
        
        _paymentPrepareController = PaymentPrepareController()
        _paymentPrepareController!.modalPresentationStyle = .fullScreen
        
        _paymentPrepareController!.setup(
            id_of_dance_group: _id_of_dance_group!,
            id_of_dance_group_day_of_week: _id_of_dance_group_day_of_week!,
            date_of_lesson_str: _date_of_lesson_str!,
            abonementLite: abonementLite,
            name_of_dance_group: GlobalVariables.visitPrepare?.nameOfDanceGroup ?? ""
        )
        
        self.presentFromRight(_paymentPrepareController!)
    }
    func visitListResult(status: String?, errors: String?) {
        fatalError("VisitPrepareController visitListResult не должно запускаться!")
    }
}
