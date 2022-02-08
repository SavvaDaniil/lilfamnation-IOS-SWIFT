//
//  DanceGroupLessonView.swift
//  LilFam NATION 3
//
//  Created by Daniil Savva on 25.01.2022.
//

import UIKit
import CoreData

class DanceGroupLessonView: UIView {
    
    private var _context: NSManagedObjectContext
    private var _parentController: UIViewController
    private var _danceGroupScheduleViewModel: DanceGroupSchedule?
    
    private var _teacherPosterView: UIView?
    private var _teacherPoster: UIImageView?
    private var _teacherName: UILabel?
    
    private var _danceGroupName: UILabel?
    private var _danceGroupLessonDateName: UILabel?
    private var _danceGroupLessonTimeFrom: UILabel?
    private var _danceGroupDescription: UILabel?
    
    private var _aboutQuestions: UILabel?
    private var _btnToInstagram: UIButton?
    private var _actionBtn: ButtonDefault?
    
    private var _danceGroupLessonDelegate: DanceGroupLessonDelegate
    private var _visitFacade: VisitFacade?
    private var _id_of_dance_group: Int?
    private var _id_of_dance_group_day_of_week: Int?
    private var _date_of_lesson: String?
    private var _lastVisitLite: VisitLite?
    
    init(context: NSManagedObjectContext, parentController: UIViewController, danceGroupLessonDelegate: DanceGroupLessonDelegate){
        _context = context
        _parentController = parentController
        _danceGroupLessonDelegate = danceGroupLessonDelegate
        super.init(frame: CGRect())
        
        let width1_3: CGFloat = parentController.view.frame.width / 3
        
        
        _teacherPosterView = UIView(frame: CGRect())
        //_teacherPosterView!.backgroundColor = UIColor(red: 83/255, green: 89/255, blue: 75/255, alpha: 1)
        _teacherPosterView!.backgroundColor = UIColor(red: 188/255, green: 84/255, blue: 228/255, alpha: 1)
        //_teacherPosterView!.backgroundColor = UIColor(red: 75/255, green: 66/255, blue: 145/255, alpha: 1)
        self.addSubview(_teacherPosterView!)
        _teacherPosterView!.translatesAutoresizingMaskIntoConstraints = false
        _teacherPosterView!.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        _teacherPosterView!.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        _teacherPosterView!.trailingAnchor.constraint(equalTo: self.leadingAnchor, constant: width1_3).isActive = true
        _teacherPosterView!.bottomAnchor.constraint(equalTo: self.topAnchor, constant: CGFloat(width1_3 + 20)).isActive = true
        
        _teacherPoster = UIImageView(frame: CGRect())
        _teacherPosterView!.addSubview(_teacherPoster!)
        _teacherPoster!.translatesAutoresizingMaskIntoConstraints = false
        _teacherPoster!.topAnchor.constraint(equalTo: _teacherPosterView!.topAnchor, constant: 8).isActive = true
        _teacherPoster!.bottomAnchor.constraint(equalTo: _teacherPosterView!.bottomAnchor, constant: -28).isActive = true
        _teacherPoster!.leadingAnchor.constraint(equalTo: _teacherPosterView!.leadingAnchor, constant: 8).isActive = true
        _teacherPoster!.trailingAnchor.constraint(equalTo: _teacherPosterView!.trailingAnchor, constant: -8).isActive = true
        _teacherPoster!.image = UIImage(named: "userDefault")
        
        _teacherName = UILabel(frame: CGRect())
        _teacherName!.font = UIFont(name: GlobalVariables.fontGothamProLightSrc, size: 10)
        _teacherName!.textAlignment = .center
        _teacherName!.textColor = .black
        _teacherPosterView!.addSubview(_teacherName!)
        _teacherName!.translatesAutoresizingMaskIntoConstraints = false
        _teacherName!.topAnchor.constraint(equalTo: _teacherPoster!.bottomAnchor, constant: 10).isActive = true
        _teacherName!.leadingAnchor.constraint(equalTo: _teacherPoster!.leadingAnchor, constant: 8).isActive = true
        _teacherName!.trailingAnchor.constraint(equalTo: _teacherPoster!.trailingAnchor, constant: -8).isActive = true
        _teacherName!.text = "ФИО препода"
        
        
        _danceGroupName = UILabel(frame: CGRect())
        _danceGroupName!.font = UIFont(name: GlobalVariables.fontGothamProLightSrc, size: 18)
        _danceGroupName!.textColor = .white
        self.addSubview(_danceGroupName!)
        _danceGroupName!.translatesAutoresizingMaskIntoConstraints = false
        _danceGroupName!.topAnchor.constraint(equalTo: self.topAnchor, constant: 20).isActive = true
        _danceGroupName!.leadingAnchor.constraint(equalTo: _teacherPosterView!.trailingAnchor, constant: 10).isActive = true
        _danceGroupName!.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true
        _danceGroupName!.text = "Название группы"
        
        
        _danceGroupLessonDateName = UILabel(frame: CGRect())
        _danceGroupLessonDateName!.font = UIFont(name: GlobalVariables.fontGothamProLightSrc, size: 14)
        _danceGroupLessonDateName!.textColor = .white
        self.addSubview(_danceGroupLessonDateName!)
        _danceGroupLessonDateName!.translatesAutoresizingMaskIntoConstraints = false
        _danceGroupLessonDateName!.topAnchor.constraint(equalTo: _danceGroupName!.bottomAnchor, constant: 20).isActive = true
        _danceGroupLessonDateName!.leadingAnchor.constraint(equalTo: _teacherPosterView!.trailingAnchor, constant: 10).isActive = true
        _danceGroupLessonDateName!.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true
        _danceGroupLessonDateName!.text = "Название дня с датой"
        
        _danceGroupLessonTimeFrom = UILabel(frame: CGRect())
        _danceGroupLessonTimeFrom!.font = UIFont(name: GlobalVariables.fontGothamProMediumSrc, size: 14)
        _danceGroupLessonTimeFrom!.textColor = .white
        self.addSubview(_danceGroupLessonTimeFrom!)
        _danceGroupLessonTimeFrom!.translatesAutoresizingMaskIntoConstraints = false
        _danceGroupLessonTimeFrom!.topAnchor.constraint(equalTo: _danceGroupLessonDateName!.bottomAnchor, constant: 20).isActive = true
        _danceGroupLessonTimeFrom!.leadingAnchor.constraint(equalTo: _teacherPosterView!.trailingAnchor, constant: 10).isActive = true
        _danceGroupLessonTimeFrom!.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true
        _danceGroupLessonTimeFrom!.text = "XX:XX"
        
        
        _danceGroupDescription = UILabel(frame: CGRect())
        _danceGroupDescription!.font = UIFont(name: GlobalVariables.fontGothamProLightSrc, size: 14)
        //_danceGroupDescription!.backgroundColor = .blue
        _danceGroupDescription!.textColor = .white
        _danceGroupDescription!.sizeToFit()
        _danceGroupDescription!.numberOfLines = 0
        self.addSubview(_danceGroupDescription!)
        _danceGroupDescription!.translatesAutoresizingMaskIntoConstraints = false
        _danceGroupDescription!.topAnchor.constraint(equalTo: _teacherPosterView!.bottomAnchor,constant: 20).isActive = true
        _danceGroupDescription!.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 8).isActive = true
        _danceGroupDescription!.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: -8).isActive = true
        //_danceGroupDescription!.heightAnchor.constraint(equalToConstant: parentController.view.frame.height / 2).isActive = true
        
        
        
        ///
        _aboutQuestions = UILabel(frame: CGRect())
        _aboutQuestions!.font = UIFont(name: GlobalVariables.fontGothamProMediumSrc, size: 12)
        _aboutQuestions!.textColor = .white
        self.addSubview(_aboutQuestions!)
        _aboutQuestions!.translatesAutoresizingMaskIntoConstraints = false
        _aboutQuestions!.topAnchor.constraint(equalTo: _danceGroupDescription!.bottomAnchor,constant: 40).isActive = true
        _aboutQuestions!.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 8).isActive = true
        _aboutQuestions!.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: -8).isActive = true
        _aboutQuestions!.text = "По всем вопросам пишите нам:"
        
        _btnToInstagram = ButtonDefault("@studio.lilfam.nation")
        self.addSubview(_btnToInstagram!)
        _btnToInstagram!.translatesAutoresizingMaskIntoConstraints = false
        _btnToInstagram!.topAnchor.constraint(equalTo: _aboutQuestions!.bottomAnchor,constant: 4).isActive = true
        _btnToInstagram!.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 8).isActive = true
        _btnToInstagram!.widthAnchor.constraint(equalToConstant: 180).isActive = true
        _btnToInstagram!.addTarget(self, action: #selector(openInstagram), for: .touchUpInside)
        
        
        _actionBtn = ButtonDefault("Записаться на занятие")
        self.addSubview(_actionBtn!)
        _actionBtn!.translatesAutoresizingMaskIntoConstraints = false
        _actionBtn!.bottomAnchor.constraint(equalTo: self.bottomAnchor,constant: -12).isActive = true
        _actionBtn!.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 8).isActive = true
        _actionBtn!.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: -8).isActive = true
        _actionBtn!.addTarget(self, action: #selector(btnActionClick), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    public func setup(){
        _danceGroupScheduleViewModel = GlobalVariables.danceGroupScheduleWithNameOfDayOfWeek?.danceGroupScheduleViewModel
        
        _teacherName!.text = _danceGroupScheduleViewModel?.teacher_name
        _danceGroupName!.text = _danceGroupScheduleViewModel?.name_of_dance_group
        _danceGroupLessonDateName!.text = GlobalVariables.danceGroupScheduleWithNameOfDayOfWeek?.name_of_day_of_week
        _danceGroupLessonTimeFrom!.text = _danceGroupScheduleViewModel?.time_from
        //_danceGroupDescription!.attributedText = _danceGroupScheduleViewModel?.description?.htmlToAttributedString
        _danceGroupDescription!.text = _danceGroupScheduleViewModel?.description
        _danceGroupDescription!.sizeToFit()
        
        _id_of_dance_group = _danceGroupScheduleViewModel?.id_of_dance_group
        _id_of_dance_group_day_of_week = _danceGroupScheduleViewModel?.id_of_dance_group_day_of_week
        _date_of_lesson = _danceGroupScheduleViewModel?.date_of_day
        
        if GlobalVariables.visitLites != nil {
            if GlobalVariables.visitLites!.count > 0 {
                _lastVisitLite = GlobalVariables.visitLites!.last
                self._actionBtn!.setCustomLabel(text: "Отменить")
            } else {
                self._actionBtn!.setCustomLabel(text: "Записаться")
            }
        }
    }
    
    public func setBtnActionStatus(){
        
    }
    
    @objc
    private func btnActionClick(){
        /*
        _visitFacade = VisitFacade(_context)
        _visitFacade!.prepare(
            visitDelegate: _visitDelegate,
            id_of_dance_group: _id_of_dance_group ?? 0,
            id_of_dance_group_day_of_week: _id_of_dance_group_day_of_week ?? 0,
            date_of_lesson: _date_of_lesson ?? ""
        )
        */
        if _lastVisitLite != nil {
            if _lastVisitLite?.statusForDisableCanselByUser == 1 {
                AlertComponent.callAlertError("Вы уже отметились на занятие.\n Если это ошибка, сообщите пожалуйста администратору.", _parentController)
            } else {
                _danceGroupLessonDelegate.danceGroupLessonActionWithVisit(isAdd: false)
            }
        } else {
            _danceGroupLessonDelegate.danceGroupLessonActionWithVisit(isAdd: true)
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
    
    
    @objc
    private func openInstagram(){
        let Username = "studio.lilfam.nation" // Your Instagram Username here
        let appURL = URL(string: "instagram://user?username=\(Username)")!
        let application = UIApplication.shared

        if application.canOpenURL(appURL) {
            application.open(appURL)
        } else {
            let webURL = URL(string: "https://instagram.com/\(Username)")!
            application.open(webURL)
        }
    }
    
    
    
}
