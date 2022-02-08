//
//  BuyAbonementController.swift
//  LilFam NATION 3
//
//  Created by Daniil Savva on 08.02.2022.
//

import UIKit
import CoreData

class BuyAbonementController : UIViewController, LoadingOrErrorViewDelegate, VisitPaymentDelegate, AbonementDelegate {
    
    
    private var _context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    private var _danceGroupLessonDelegate: DanceGroupLessonDelegate?
    private var _loadingOrErrorViewFactory = LoadingOrErrorViewFactory()
    private var _loadingOrErrorView: LoadingOrErrorView?
    
    private var _visitPrepareViewFactory: VisitPrepareViewFactory?
    private var _visitPrepareAbonementsView: VisitPrepareAbonementsView?
    private var _paymentPrepareController: PaymentPrepareController?
    
    private var _abonementFacade: AbonementFacade?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let controllerBackgroundImageFactory = ControllerBackgroundImageFactory()
        controllerBackgroundImageFactory.createAndAdd(parentController: self)
        
        _loadingOrErrorView = _loadingOrErrorViewFactory.create(parentController: self, loadingOrErrorViewDelegate: self, topView: nil, bottomView: nil)
        
        _abonementFacade = AbonementFacade(_context)
        
        _visitPrepareViewFactory = VisitPrepareViewFactory(context: _context)
        _visitPrepareAbonementsView = _visitPrepareViewFactory!.createAbonementsView(parentController: self, visitPaymentDelegate: self, topView: nil, bottomView: nil)
    }
    
    public func setup(danceGroupLessonDelegate: DanceGroupLessonDelegate){
        _danceGroupLessonDelegate = danceGroupLessonDelegate
    }
    
    public func update(){
        _visitPrepareAbonementsView!.isHidden = true
        _loadingOrErrorView!.setLoadingStatus()
        _abonementFacade?.listAll(abonementDelegate: self)
    }
    
    internal func loadingOrErrorTryAgain() {
        update()
    }
    
    func abonementListAllResult(status: String?, errors: String?) {
        if status == "success" {
            _visitPrepareAbonementsView!.update()
            _visitPrepareAbonementsView!.isHidden = false
            _loadingOrErrorView!.setDeactivatedStatus()
        } else {
            _visitPrepareAbonementsView!.isHidden = true
            _loadingOrErrorView!.setErrorStatus()
        }
    }
    
    func abonementForceLogout() {
        
    }
    
    func abonementNotAuth() {
        
    }
    
    
    internal func visitPaymentBegin(abonementLite: AbonementLite) {
        _paymentPrepareController = PaymentPrepareController()
        _paymentPrepareController!.modalPresentationStyle = .fullScreen
        
        _paymentPrepareController!.setup(
            id_of_dance_group: 0,
            id_of_dance_group_day_of_week: 0,
            date_of_lesson_str: "",
            abonementLite: abonementLite,
            name_of_dance_group: GlobalVariables.visitPrepare?.nameOfDanceGroup ?? ""
        )
        
        self.presentFromRight(_paymentPrepareController!)
    }
    
    internal func visitPaymentAfterAction() {
        _paymentPrepareController!.dismiss(animated: false, completion: { [self] in
            _danceGroupLessonDelegate!.danceGroupLessonAfterVisitAction()
        })
        //может возврат к группам?
        update()
    }
    
}
