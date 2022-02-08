//
//  VisitsHistoryController.swift
//  LilFam NATION 3
//
//  Created by Daniil Savva on 14.01.2022.
//

import Foundation
import UIKit



class VisitsHistoryController : UIViewController, LoadingOrErrorViewDelegate, VisitsHistoryDelegate, VisitDelegate {
    
    private var _context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    private var _danceGroupLessonDelegate: DanceGroupLessonDelegate?
    
    private var _loadingOrErrorViewFactory = LoadingOrErrorViewFactory()
    private var _loadingOrErrorView: LoadingOrErrorView?
    
    private var _visitFacade: VisitFacade?
    private var _visitsHistoryView: VisitsHistoryView?
    
    // MARK: - Init
    override func viewDidLoad(){
        super.viewDidLoad()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        let controllerBackgroundImageFactory = ControllerBackgroundImageFactory()
        controllerBackgroundImageFactory.createAndAdd(parentController: self)
        
        _loadingOrErrorView = _loadingOrErrorViewFactory.create(parentController: self, loadingOrErrorViewDelegate: self, topView: nil, bottomView: nil)
        
        _visitFacade = VisitFacade(_context)
        
        _visitsHistoryView = VisitsHistoryView(context: _context, parentController: self, visitsHistoryDelegate: self)
        self.view.addSubview(_visitsHistoryView!)
        _visitsHistoryView!.translatesAutoresizingMaskIntoConstraints = false
        _visitsHistoryView!.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        _visitsHistoryView!.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        _visitsHistoryView!.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        _visitsHistoryView!.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        _visitsHistoryView!.isHidden = true
    }
    
    public func setup(danceGroupLessonDelegate: DanceGroupLessonDelegate){
        _danceGroupLessonDelegate = danceGroupLessonDelegate
    }
    
    public func update(){
        _visitsHistoryView!.isHidden = true
        _loadingOrErrorView!.setLoadingStatus()
        _visitFacade!.list(visitDelegate: self)
        print("VisitsHistoryController update")
    }
    
    internal func loadingOrErrorTryAgain() {
        update()
    }
    
    internal func visitsHistoryGetLesson(id_of_dance_group: Int, id_of_dance_group_day_of_week: Int, date_of_lesson_str: String, id_of_visit: Int) {
        //нужно вызывать загрузку окна из ContainerViewController
        _danceGroupLessonDelegate?.danceGroupLessonGetOpenViewController(
            id_of_dance_group: id_of_dance_group,
            id_of_dance_group_day_of_week: id_of_dance_group_day_of_week,
            date_of_lesson_str: date_of_lesson_str,
            id_of_visit: id_of_visit
        )
    }
    
    func visitListResult(status: String?, errors: String?) {
        if status == "success" {
            _visitsHistoryView!.update()
            _visitsHistoryView!.isHidden = false
            _loadingOrErrorView?.setDeactivatedStatus()
        } else {
            _visitsHistoryView!.isHidden = true
            _loadingOrErrorView?.setErrorStatus()
        }
    }
    
    
    
}







extension VisitsHistoryController {
    func visitPrepareResult(status: String?, errors: String?) {
        fatalError("VisitsHistoryController XXXX не должен запускаться")
    }
    
    func visitNotAuth() {
        fatalError("VisitsHistoryController XXXX не должен запускаться")
    }
    
    func visitForceLogout() {
        fatalError("VisitsHistoryController XXXX не должен запускаться")
    }
    
    func visitAdd(id_of_purchase_abonement: Int) {
        fatalError("VisitsHistoryController XXXX не должен запускаться")
    }
    
    func visitAddResult(status: String?, errors: String?) {
        fatalError("VisitsHistoryController XXXX не должен запускаться")
    }
    
    func visitDeleteResult(status: String?, errors: String?) {
        fatalError("VisitsHistoryController XXXX не должен запускаться")
    }
    
}
