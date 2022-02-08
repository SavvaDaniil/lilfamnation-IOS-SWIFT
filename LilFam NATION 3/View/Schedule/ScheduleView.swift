//
//  ScheduleTableView.swift
//  LilFam NATION 3
//
//  Created by Daniil Savva on 23.01.2022.
//

import UIKit
import CoreData

class ScheduleView : UIView {
    
    private var _context: NSManagedObjectContext
    private var _danceGroupLessonDelegate: DanceGroupLessonDelegate
    private var _parentController: UIViewController
    private var _scheduleDelegate: ScheduleDelegate
    private var _scheduleTableView: UITableView?
    
    private var _danceGroupScheduleWithNameOfDayOfWeeks : [DanceGroupScheduleWithNameOfDayOfWeek]?
    //private var _danceGroupScheduleWithNameOfDayOfWeekViewModels: [DanceGroupScheduleWithNameOfDayOfWeekViewModel]?
    private var _danceGroup: DanceGroupFacade
    private var _danceGroupLessonController: DanceGroupLessonController?
    
    init(context: NSManagedObjectContext, danceGroupLessonDelegate: DanceGroupLessonDelegate, parentController: UIViewController, scheduleDelegate: ScheduleDelegate){
        _context = context
        _danceGroupLessonDelegate = danceGroupLessonDelegate
        _parentController = parentController
        _scheduleDelegate = scheduleDelegate
        _danceGroup = DanceGroupFacade(_context)
        super.init(frame: CGRect())
        
        
        _scheduleTableView = UITableView(frame: CGRect(), style: UITableView.Style.plain)
        _scheduleTableView!.dataSource = self
        _scheduleTableView!.delegate = self
        _scheduleTableView!.bounces = false
        //_scheduleTableView!.tableHeaderView = nil
        //_scheduleTableView!.insetsContentViewsToSafeArea = false
        
        //_scheduleTableView!.contentInset = UIEdgeInsets(top: -35, left: 0, bottom: 0, right: 0);
        print(_scheduleTableView!.automaticallyAdjustsScrollIndicatorInsets)
        _scheduleTableView!.backgroundColor = UIColor(white: 1, alpha: 0)
        _scheduleTableView!.separatorColor = UIColor(red: 83/255, green: 89/255, blue: 75/255, alpha: 1)
        //_scheduleTableView!.rowHeight = 50
        self.addSubview(_scheduleTableView!)
        _scheduleTableView!.translatesAutoresizingMaskIntoConstraints = false
        _scheduleTableView!.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        _scheduleTableView!.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        _scheduleTableView!.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        _scheduleTableView!.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        
        
        //
    
        _scheduleTableView!.automaticallyAdjustsScrollIndicatorInsets = false
        _scheduleTableView!.contentInsetAdjustmentBehavior = .never
        _scheduleTableView!.contentInset = .zero
        if #available(iOS 11.0, *) {
            _scheduleTableView!.contentInsetAdjustmentBehavior = .never
        } else {
            self.inputViewController?.automaticallyAdjustsScrollViewInsets = false
        }
        if #available(iOS 15.0, *) {
            _scheduleTableView!.sectionHeaderTopPadding = 0
        }
        _scheduleTableView!.separatorInset = .zero
        
    }
    
    required init(coder: NSCoder) {
        fatalError()
    }
    
    /*
    public func update(danceGroupScheduleWithNameOfDayOfWeeks : [DanceGroupScheduleWithNameOfDayOfWeek]?){
        _danceGroupScheduleWithNameOfDayOfWeeks = danceGroupScheduleWithNameOfDayOfWeeks
        _scheduleTableView!.reloadData()
        
    }
    */
    
    public func update(){
        print("ScheduleView update \(GlobalVariables.danceGroupScheduleWithNameOfDayOfWeeks?.count ?? 0)")
        /*
        if danceGroupScheduleWithNameOfDayOfWeekViewModels == nil {
            print("danceGroupScheduleWithNameOfDayOfWeekViewModels == nil")
        }
        */
        
        _danceGroupScheduleWithNameOfDayOfWeeks = GlobalVariables.danceGroupScheduleWithNameOfDayOfWeeks
        _scheduleTableView?.reloadData()
    }
    
}

extension ScheduleView : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return _danceGroupScheduleWithNameOfDayOfWeeks?.count ?? 0
        //return _danceGroupScheduleWithNameOfDayOfWeekViewModels?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if _danceGroupScheduleWithNameOfDayOfWeeks == nil {
            return 0
        }
        if _danceGroupScheduleWithNameOfDayOfWeeks?.count == 0 {
            return 0
        }
        return _danceGroupScheduleWithNameOfDayOfWeeks?[section].danceGroupScheduleViewModels!.count ?? 0
        
        /*
        if _danceGroupScheduleWithNameOfDayOfWeekViewModels == nil {
            return 0
        }
        if _danceGroupScheduleWithNameOfDayOfWeekViewModels?.count == 0 {
            return 0
        }
        return _danceGroupScheduleWithNameOfDayOfWeekViewModels?[section].danceGroupScheduleViewModels!.count ?? 0
         */
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //print("_danceGroupScheduleWithNameOfDayOfWeeks.count \(_danceGroupScheduleWithNameOfDayOfWeeks?.count)")
        //print("section: \(indexPath.section) row: \(indexPath.row)")
        
        
        let danceGroupScheduleViewModel = _danceGroupScheduleWithNameOfDayOfWeeks?[indexPath.section].danceGroupScheduleViewModels?[indexPath.row]
        
        //print("danceGroupScheduleViewModel: \(danceGroupScheduleViewModel?.name_of_dance_group)")
        
        let cell = ScheduleTableViewCell(danceGroupSchedule: danceGroupScheduleViewModel!)
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let danceGroupScheduleViewModel = _danceGroupScheduleWithNameOfDayOfWeeks?[indexPath.section].danceGroupScheduleViewModels![indexPath.row]
        
        _danceGroupLessonDelegate.danceGroupLessonGetOpenViewController(
            id_of_dance_group: danceGroupScheduleViewModel?.id_of_dance_group ?? 0,
            id_of_dance_group_day_of_week: danceGroupScheduleViewModel?.id_of_dance_group_day_of_week ?? 0,
            date_of_lesson_str: danceGroupScheduleViewModel?.date_of_day ?? "",
            id_of_visit: 0
        )
         
        /*
        _danceGroupLessonController = DanceGroupLessonController()
        _danceGroupLessonController!.setup(
            id_of_dance_group: danceGroupScheduleViewModel?.id_of_dance_group ?? 0,
            id_of_dance_group_day_of_week: danceGroupScheduleViewModel?.id_of_dance_group_day_of_week ?? 0,
            date_of_lesson_str: danceGroupScheduleViewModel?.date_of_day ?? ""
        )
        _parentController.presentFromRight(_danceGroupLessonController!)
        */
        /*
        _danceGroup.getLesson(
            scheduleDelegate: _scheduleDelegate,
            id_of_dance_group: danceGroupScheduleViewModel?.id_of_dance_group ?? 0,
            id_of_dance_group_day_of_week: danceGroupScheduleViewModel?.id_of_dance_group_day_of_week ?? 0,
            date_of_lesson_str: danceGroupScheduleViewModel?.date_of_day ?? ""
        )
         */
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if _danceGroupScheduleWithNameOfDayOfWeeks == nil {
            return nil
        }
        
        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 40))
        //headerView.backgroundColor = UIColor(red: 83/255, green: 89/255, blue: 75/255, alpha: 1)
        headerView.backgroundColor = UIColor(red: 188/255, green: 84/255, blue: 228/255, alpha: 1)
        
        let label = UILabel()
        headerView.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.topAnchor.constraint(equalTo: headerView.topAnchor).isActive = true
        label.bottomAnchor.constraint(equalTo: headerView.bottomAnchor).isActive = true
        label.leadingAnchor.constraint(equalTo: headerView.leadingAnchor).isActive = true
        label.trailingAnchor.constraint(equalTo: headerView.trailingAnchor).isActive = true
        
        label.text = _danceGroupScheduleWithNameOfDayOfWeeks?[section].name_of_day_of_week
        label.textAlignment = .center
        label.font = UIFont(name: GlobalVariables.fontGothamProLightSrc, size: 16)
        label.textColor = UIColor(red: 9/255, green: 6/255, blue: 4/255, alpha: 1)
        headerView.addSubview(label)
        
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath as IndexPath) {
            cell.backgroundColor = UIColor(white: 1, alpha: 0.3)
        }
    }
    
    func tableView(_ tableView: UITableView, didUnhighlightRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath as IndexPath) {
            cell.backgroundColor = UIColor(white: 1, alpha: 0)
        }
    }
    
    
}
