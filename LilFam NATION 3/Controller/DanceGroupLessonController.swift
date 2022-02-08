//
//  DanceGroupLessonController.swift
//  LilFam NATION 3
//
//  Created by Daniil Savva on 25.01.2022.
//

import UIKit


class DanceGroupLessonController : UIViewController, DanceGroupLessonDelegate, ViewNavigationBarDelegate, LoadingOrErrorViewDelegate, VisitDelegate {
    
    private var _context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    private let _navigationBarFactory: NavigationBarFactory = NavigationBarFactory()
    private var _navigationBar: NavigationBar?
    private var _loadingOrErrorViewFactory = LoadingOrErrorViewFactory()
    private var _loadingOrErrorView: LoadingOrErrorView?
    
    private var _id_of_dance_group: Int?
    private var _id_of_dance_group_day_of_week: Int?
    private var _date_of_lesson_str: String?
    private var _id_of_visit: Int?
    private var _danceGroupScheduleViewModel: DanceGroupSchedule?
    private var _danceGroupFacade: DanceGroupFacade?
    private var _danceGroupLessonView: DanceGroupLessonView?
    private var _visitPrepareController: VisitPrepareController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let controllerBackgroundImageFactory = ControllerBackgroundImageFactory()
        controllerBackgroundImageFactory.createAndAdd(parentController: self)
        
        _navigationBar = _navigationBarFactory.createWithButtonBackAndButtonRefresh(parentController: self, viewNavigationBarDelegate: self, titleText: "")
        
        _loadingOrErrorView = _loadingOrErrorViewFactory.create(parentController: self, loadingOrErrorViewDelegate: self, topView: _navigationBar!, bottomView: nil)
        
        _danceGroupLessonView = DanceGroupLessonView(context: _context, parentController: self, danceGroupLessonDelegate: self)
        self.view.addSubview(_danceGroupLessonView!)
        _danceGroupLessonView!.translatesAutoresizingMaskIntoConstraints = false
        _danceGroupLessonView!.topAnchor.constraint(equalTo: _navigationBar!.bottomAnchor).isActive = true
        _danceGroupLessonView!.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        _danceGroupLessonView!.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        _danceGroupLessonView!.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        
        _danceGroupLessonView!.isHidden = true
        danceLessonFetchGet()
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
    
    internal func navigationBarRefreshCallback() {
        danceLessonFetchGet()
    }
    internal func loadingOrErrorTryAgain() {
        danceLessonFetchGet()
    }
    
    
    public func setup(
        id_of_dance_group: Int,
        id_of_dance_group_day_of_week: Int,
        date_of_lesson_str: String,
        id_of_visit: Int?
    ){
        _id_of_dance_group = id_of_dance_group
        _id_of_dance_group_day_of_week = id_of_dance_group_day_of_week
        _date_of_lesson_str = date_of_lesson_str
        _id_of_visit = id_of_visit
    }
    
    
    private func danceLessonFetchGet(){
        if _danceGroupFacade == nil {
            _danceGroupFacade = DanceGroupFacade(_context)
        }
        //нужно поставить анимацию загрзки
        _danceGroupLessonView?.isHidden = true
        _loadingOrErrorView!.setLoadingStatus()
        
        _danceGroupFacade!.getLesson(
            danceGroupLessonDelegate: self,
            id_of_dance_group: _id_of_dance_group ?? 0,
            id_of_dance_group_day_of_week: _id_of_dance_group_day_of_week ?? 0,
            date_of_lesson_str: _date_of_lesson_str ?? ""
        )
    }
    
    internal func danceGroupLessonGetOpenViewController(id_of_dance_group: Int, id_of_dance_group_day_of_week: Int, date_of_lesson_str: String, id_of_visit: Int?) {
        fatalError("Открытие контроллера должно происходить из ContainerViewController!")
    }
    
    internal func danceGroupLessonFetchResult(status: String?, errors: String?) {
        //print("DanceGroupLessonController danceGroupLessonFetchResult")
        //_danceGroupLessonView?.setup()
        
        if status == nil {
            print("DanceGroupLessonController setErrorStatus")
            _danceGroupLessonView?.isHidden = true
            _loadingOrErrorView!.setErrorStatus()
            return
        }
        
        if status == "success" {
            _danceGroupLessonView?.setup()
            _loadingOrErrorView!.setDeactivatedStatus()
            _danceGroupLessonView?.isHidden = false
        } else {
            print("DanceGroupLessonController setErrorStatus")
            _danceGroupLessonView?.isHidden = true
            _loadingOrErrorView!.setErrorStatus()
        }
        
    }
    internal func danceGroupLessonActionWithVisit(isAdd: Bool){
        if isAdd {
            _visitPrepareController = VisitPrepareController()
            _visitPrepareController!.modalPresentationStyle = .fullScreen
            
            _visitPrepareController!.setup(
                id_of_dance_group: _id_of_dance_group ?? 0,
                id_of_dance_group_day_of_week: _id_of_dance_group_day_of_week ?? 0,
                date_of_lesson_str: _date_of_lesson_str ?? "",
                danceGroupLessonDelegate: self
            )
            self.presentFromRight(_visitPrepareController!)
        } else {
            let visitFacade = VisitFacade(_context)
            visitFacade.prepareDelete(parentController: self, visitDelegate: self)
        }
    }
    func danceGroupLessonAfterVisitAction() {
        _visitPrepareController?.dismissToRight()
        self.dismiss(animated: false, completion: nil)
    }
    
    
    
    internal func visitPrepareResult(jsonAnswerStatus: JsonAnswerStatus?) {
        print("DanceGroupLessonController visitPrepareResult")
        /*
        if jsonAnswerStatus == nil {
            return
        }
        
        if jsonAnswerStatus?.status == "success"{
            let visitPrepareController = VisitPrepareController()
            visitPrepareController.modalPresentationStyle = .fullScreen
            
            visitPrepareController.update(
                id_of_dance_group: _id_of_dance_group ?? 0,
                id_of_dance_group_day_of_week: _id_of_dance_group_day_of_week ?? 0,
                date_of_lesson_str: _date_of_lesson_str ?? ""
            )
            self.presentFromRight(visitPrepareController)
        } else {
            
        }
         */
    }
    
    internal func visitNotAuth() {
        fatalError("visitNotAuth не работает в окне с занятием группы")
    }
    
    internal func visitForceLogout() {
        fatalError("visitForceLogout не работает в окне с занятием группы")
    }
    
}


extension DanceGroupLessonController {
    
    func visitPrepareResult(status: String?, errors: String?) {
        fatalError("visitPrepareResult не должно работать из DanceGroupLessonController")
    }
    
    func visitAdd(id_of_purchase_abonement: Int) {
        fatalError("visitAdd не должно работать из DanceGroupLessonController")
    }
    
    func visitAddResult(status: String?, errors: String?) {
        fatalError("visitAddResult не должно работать из DanceGroupLessonController")
    }
    
    func visitDeleteResult(status: String?, errors: String?) {
        _danceGroupLessonView?.isHidden = false
        _loadingOrErrorView!.setDeactivatedStatus()
        
        if status == "success" {
            self.dismissToRight()
        } else {
            AlertComponent.callAlertError("Ошибка при попытке отменить визит", self)
        }
    }
    func visitListResult(status: String?, errors: String?) {
        fatalError("visitListResult не должно работать из DanceGroupLessonController")
    }
}
