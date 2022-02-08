//
//  ViewController.swift
//  LilFam NATION 3
//
//  Created by Daniil Savva on 22.03.2021.
//

import UIKit
import CoreData

class ViewController: UIViewController, LeftSlideMenuDelegate, AuthUserDelegate, DanceGroupLessonDelegate, ViewNavigationBarDelegate {
    
    
    private var _context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    // MARK: - Properties
    private let startingYPos: CGFloat = {
        var heightToReturn: CGFloat = 0.0
             for window in UIApplication.shared.windows {
                 if let height = window.windowScene?.statusBarManager?.statusBarFrame.height, height > heightToReturn {
                     heightToReturn = height
                 }
             }
        return heightToReturn
    }()
    private var _leftSideMenu: LeftSideMenu?
    private var _isSlideMenuPresented: Bool = false
    private var _swipeFromLeftToRight: UISwipeGestureRecognizer?
    private var _swipeFromRightToLeft: UISwipeGestureRecognizer?
    private let _navigationBarFactory: NavigationBarFactory = NavigationBarFactory()
    private var _navigationBar: NavigationBar?
    
    private var _listOfControllers: [UIViewController]? = []
    private var _sheduleController: SheduleController = SheduleController()
    private var _authController: AuthController?
    private var _profileController = ProfileController()
    private var _visitsHistoryController = VisitsHistoryController()
    private var _contactsController = ContactsController()
    private var _purchaseAbonementHistoryController = PurchaseAbonementHistoryController()
    private var _buyAbonementController = BuyAbonementController()
    
    private var _userFacade: UserFacade?
    private var _danceGroupLessonController: DanceGroupLessonController?
    private var _danceGroupFacade: DanceGroupFacade?
    
    
    
    // MARK: - Init
    override func viewDidLoad() {
        let leftSideMenuFactory = LeftSideMenuFactory(context: _context)
        super.viewDidLoad()
        
        _navigationBar = _navigationBarFactory.createAndAddWithBtnMenuAndBtnRefresh(
            parentController: self,
            leftSlideMenuDelegate: self,
            viewNavigationBarDelegate: self,
            titleText: "Группы"
        )
        
        _sheduleController.setup(danceGroupLessonDelegate: self)
        self.addControllerAndSetConstraints(_sheduleController, isHidden: false)
        self.addControllerAndSetConstraints(_profileController, isHidden: true)
        _visitsHistoryController.setup(danceGroupLessonDelegate: self)
        self.addControllerAndSetConstraints(_visitsHistoryController, isHidden: true)
        self.addControllerAndSetConstraints(_contactsController, isHidden: true)
        _purchaseAbonementHistoryController.setup(danceGroupLessonDelegate: self)
        self.addControllerAndSetConstraints(_purchaseAbonementHistoryController, isHidden: true)
        _buyAbonementController.setup(danceGroupLessonDelegate: self)
        self.addControllerAndSetConstraints(_buyAbonementController, isHidden: true)
        
        _leftSideMenu = leftSideMenuFactory.create(parentController: self, leftSlideMenuDelegate: self)
        
        _swipeFromLeftToRight = UISwipeGestureRecognizer(target: self, action: #selector(handleGestureOpenSlideLeftMenu))
        _swipeFromLeftToRight!.direction = .right
        self.view.addGestureRecognizer(_swipeFromLeftToRight!)
        _swipeFromRightToLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleGestureCloseSlideLeftMenu))
        _swipeFromRightToLeft!.direction = .left
        self.view.addGestureRecognizer(_swipeFromRightToLeft!)
        
        
        _userFacade = UserFacade(_context)
        if _userFacade!.isAuth() {
            _leftSideMenu!.setIsAuth(isAuth: true)
        }
        
        _sheduleController.update()
    }
    
    @objc
    private func handleGestureOpenSlideLeftMenu(){
        if _isSlideMenuPresented {return}
        self.handleMenuToggle()
    }
    @objc
    private func handleGestureCloseSlideLeftMenu(){
        if !_isSlideMenuPresented {return}
        self.handleMenuToggle()
    }
    
    
    internal func handleMenuToggle() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseOut){
            self._leftSideMenu!.frame.origin.x = self._isSlideMenuPresented ? -self.view.frame.width : 0
        } completion: { (finished) in
            self._isSlideMenuPresented.toggle()
        }
    }
    internal func handleChangeMenu(nameIdentity: String, title: String) -> (){
        print("nameIdentity: \(nameIdentity)" )
        
        if nameIdentity == "signIn" {
            openAuthController()
        } else if nameIdentity == "account" {
            if !_userFacade!.isAuth() {
                openAuthController()
            }
            _navigationBar?.setTitle(title: title)
            hideAllControllers()
            _profileController.update()
            _profileController.view.isHidden = false
            handleMenuToggle()
        } else if nameIdentity == "lessons" {
            _navigationBar?.setTitle(title: title)
            hideAllControllers()
            _sheduleController.view.isHidden = false
            _sheduleController.update()
            handleMenuToggle()
        } else if nameIdentity == "visits" {
            _navigationBar?.setTitle(title: title)
            hideAllControllers()
            _visitsHistoryController.update()
            _visitsHistoryController.view.isHidden = false
            handleMenuToggle()
        } else if nameIdentity == "contacts" {
            _navigationBar?.setTitle(title: title)
            hideAllControllers()
            _contactsController.view.isHidden = false
            handleMenuToggle()
        } else if nameIdentity == "purchases" {
            _navigationBar?.setTitle(title: "title")
            hideAllControllers()
            _purchaseAbonementHistoryController.update()
            _purchaseAbonementHistoryController.view.isHidden = false
            handleMenuToggle()
        } else if nameIdentity == "buyAbonement" {
            _navigationBar?.setTitle(title: "title")
            hideAllControllers()
            _buyAbonementController.update()
            _buyAbonementController.view.isHidden = false
            handleMenuToggle()
        }
    }
    
    internal func handleMenuLogout() -> (){
        logout()
        
        //тут нужна перезагрузка расписания
        handleChangeMenu(nameIdentity: "lessons", title: "Группы")
    }
    internal func navigationBarRefreshCallback() {
        if !_sheduleController.view.isHidden {
            _sheduleController.update()
        } else if !_visitsHistoryController.view.isHidden {
            _visitsHistoryController.update()
        } else if !_purchaseAbonementHistoryController.view.isHidden {
            _purchaseAbonementHistoryController.update()
        } else if !_buyAbonementController.view.isHidden {
            _buyAbonementController.update()
        }
    }
    
    
    
    private func addControllerAndSetConstraints(_ controller: UIViewController, isHidden: Bool){
        view.addSubview(controller.view)
        self.addChild(controller)
        controller.didMove(toParent: self)
        //controller.view.topAnchor.constraint(equalTo: view.safeTopAnchor).isActive = true
        controller.view.translatesAutoresizingMaskIntoConstraints = false
        controller.view.topAnchor.constraint(equalTo: _navigationBar!.bottomAnchor).isActive = true
        controller.view.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        controller.view.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        controller.view.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        controller.view.isHidden = isHidden
        _listOfControllers?.append(controller)
    }
    private func hideAllControllers(){
        _listOfControllers?.forEach{controller in
            controller.view.isHidden = true
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    
    
    internal func danceGroupLessonGetOpenViewController(
        id_of_dance_group: Int,
        id_of_dance_group_day_of_week: Int,
        date_of_lesson_str: String,
        id_of_visit: Int?
    ){
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
    
    internal func danceGroupLessonFetchResult(
        status: String?,
        errors: String?
    ){
        fatalError("Загрузка данных о занятии не в ContainerViewController должна быть!")
    }
    func danceGroupLessonActionWithVisit(isAdd: Bool) {
        fatalError("Открытие окна с абонементами на занятие не в ContainerViewController должна быть!")
    }
    func danceGroupLessonAfterVisitAction() {
        fatalError("После отмечания на занятия в ContainerViewController не должно быть действий!")
    }
    
    
    
    private func openAuthController(){
        /*
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromRight
        transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
        view.window!.layer.add(transition, forKey: kCATransition)
        */
        _authController = AuthController()
        _authController?.setupAuthUserDelegate(authUserDelegate: self)
        _authController?.modalPresentationStyle = .fullScreen
        self.presentFromRight(_authController!)
    }
    func login(accessToken: String) {
        if _userFacade!.isAuth() {
            _leftSideMenu!.setIsAuth(isAuth: true)
        } else {
            print("Залогиниться не удалось accessToken не найден в базе")
        }
    }
    
    func logout() {
        _leftSideMenu?.setIsAuth(isAuth: false)
    }
    
    
    
}



