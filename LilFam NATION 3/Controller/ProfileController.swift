//
//  ProfileController.swift
//  LilFam NATION 3
//
//  Created by Daniil Savva on 22.01.2022.
//

import UIKit

//LoadingOrErrorViewDelegate
class ProfileController : UIViewController, UserProfileDelegate, LoadingOrErrorViewDelegate {
    
    private var _context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    private var _userFacade: UserFacade?
    
    private var _loadingOrErrorViewFactory = LoadingOrErrorViewFactory()
    private var _loadingOrErrorView: LoadingOrErrorView?
    
    private var _profileViewFactory: ProfileViewFactory?
    private var _profileView: ProfileView?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        _userFacade = UserFacade(_context)
        let controllerBackgroundImageFactory = ControllerBackgroundImageFactory()
        controllerBackgroundImageFactory.createAndAdd(parentController: self)
        _profileViewFactory = ProfileViewFactory(context: _context)
        _profileView = _profileViewFactory?.create(parentController: self, userProfileDelegate: self)
        _profileView?.isHidden = true
        
        _loadingOrErrorView = _loadingOrErrorViewFactory.create(parentController: self, loadingOrErrorViewDelegate: self, topView: nil, bottomView: nil)
    }
    
    
    public func update(){
        _profileView?.isHidden = true
        _loadingOrErrorView!.setLoadingStatus()
        _userFacade?.getProfile(userProfileDelegate: self)
    }
    
    internal func loadedProfile(jsonAnswerStatus: JsonAnswerStatus?) {
        
        if jsonAnswerStatus == nil {
            _loadingOrErrorView!.setErrorStatus()
            return
        }
        
        if jsonAnswerStatus!.status == "success" && jsonAnswerStatus!.userProfileViewModel != nil {
            _profileView!.setUserData(
                username: jsonAnswerStatus!.userProfileViewModel!.username,
                fio: jsonAnswerStatus!.userProfileViewModel!.fio,
                phone: jsonAnswerStatus!.userProfileViewModel!.phone,
                sex: jsonAnswerStatus!.userProfileViewModel!.sex ?? 0,
                dateOfBirthday: jsonAnswerStatus!.userProfileViewModel!.dateOfBirthday
            )
            _loadingOrErrorView!.setDeactivatedStatus()
            _profileView?.isHidden = false
        } else {
            AlertComponent.callAlertError("Неизвестная ошибка на сервере", self)
            _profileView?.isHidden = true
            _loadingOrErrorView!.setErrorStatus()
        }
    }
    
    internal func saveResult(jsonAnswerStatus: JsonAnswerStatus?) {
        
        if jsonAnswerStatus == nil {
            AlertComponent.callAlertError("Ошибка при попытке сохранения", self)
            return
        }
        
        if jsonAnswerStatus!.status == "success" {
            if jsonAnswerStatus!.accessToken != nil {
                let techDataService = TechDataService(self._context)
                if !techDataService.updateAccessToken(jsonAnswerStatus!.accessToken) {
                    AlertComponent.callAlertError("Ошибка в приложении при попытке пройти аутентификацию", self)
                    return
                }
            }
            AlertComponent.callAlertSuccess("Профиль успешно сохранен", self)
            _profileView!.clearPasswordFields()
        } else if jsonAnswerStatus!.status == "error" && jsonAnswerStatus!.errors == "username_already_exist" {
            AlertComponent.callAlertError("Указанный email уже зарегистрирован в базе", self)
        } else if jsonAnswerStatus!.status == "error" && jsonAnswerStatus!.errors == "wrong" {
            AlertComponent.callAlertError("Текущий пароль введен неверно", self)
        } else {
            AlertComponent.callAlertError("Неизвестная ошибка на сервере", self)
        }
    }
    
    
    internal func loadingOrErrorTryAgain() {
        update()
    }
}
