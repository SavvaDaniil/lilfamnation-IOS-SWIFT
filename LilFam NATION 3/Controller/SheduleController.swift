//
//  ShceduleController.swift
//  LilFam NATION 3
//
//  Created by Daniil Savva on 12.01.2022.
//

import Foundation
import UIKit


class SheduleController : UIViewController, ScheduleDelegate, LoadingOrErrorViewDelegate {
    
    private var _context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    private var _scheduleView: ScheduleView?
    private var _danceGroupFacade: DanceGroupFacade?
    
    private var _loadingOrErrorViewFactory = LoadingOrErrorViewFactory()
    private var _loadingOrErrorView: LoadingOrErrorView?
    
    private var _danceGroupLessonDelegate: DanceGroupLessonDelegate?
    //private var _scheduleTableView: UITableView?
    //private var _danceGroupScheduleWithNameOfDayOfWeeks : [DanceGroupScheduleWithNameOfDayOfWeek]?
    
    // MARK - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        //self.view.backgroundColor = .green
        let controllerBackgroundImageFactory = ControllerBackgroundImageFactory()
        controllerBackgroundImageFactory.createAndAdd(parentController: self)
        
        _loadingOrErrorView = _loadingOrErrorViewFactory.create(parentController: self, loadingOrErrorViewDelegate: self, topView: nil, bottomView: nil)
        
        _danceGroupFacade = DanceGroupFacade(_context)
        
        
        /*
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
        self.view.addSubview(_scheduleTableView!)
        _scheduleTableView!.translatesAutoresizingMaskIntoConstraints = false
        _scheduleTableView!.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        _scheduleTableView!.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        _scheduleTableView!.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        _scheduleTableView!.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        
        
        //
        if #available(iOS 15.0, *) {
            _scheduleTableView!.sectionHeaderTopPadding = 0
        }
        
        _scheduleTableView!.automaticallyAdjustsScrollIndicatorInsets = false
        _scheduleTableView!.contentInsetAdjustmentBehavior = .never
        _scheduleTableView!.contentInset = .zero
        if #available(iOS 11.0, *) {
            _scheduleTableView!.contentInsetAdjustmentBehavior = .automatic
        } else {
            automaticallyAdjustsScrollViewInsets = false
        }
        
        _scheduleTableView!.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: _scheduleTableView!.bounds.size.width, height: 0.01))
        */
    }
    
    public func loadingOrErrorTryAgain() {
        update()
    }
    
    public func setup(danceGroupLessonDelegate: DanceGroupLessonDelegate){
        _scheduleView = ScheduleView(context: _context, danceGroupLessonDelegate: danceGroupLessonDelegate, parentController: self, scheduleDelegate: self)
        self.view.addSubview(_scheduleView!)
        _scheduleView!.translatesAutoresizingMaskIntoConstraints = false
        _scheduleView!.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        _scheduleView!.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        _scheduleView!.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        _scheduleView!.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
    }
    
    public func update(){
        _scheduleView?.isHidden = true
        _loadingOrErrorView!.setLoadingStatus()
        
        _danceGroupFacade?.getScheduleByDatesOnWeek(scheduleDelegate: self)
    }
    
    internal func scheduleLoadResult(status: String?, errors: String?) {
        
        if status == "success" {
            _scheduleView!.update()
            _scheduleView?.isHidden = false
            _loadingOrErrorView!.setDeactivatedStatus()
        } else {
            _scheduleView?.isHidden = true
            _loadingOrErrorView!.setErrorStatus()
        }
        
    }
    
    
    /*
    func loadResult(status: String?, errors: String?, danceGroupScheduleWithNameOfDayOfWeekViewModels: [DanceGroupScheduleWithNameOfDayOfWeekViewModel]?) {
        print("SheduleController loadResult")
        
        print("SheduleController loadResult count: \(danceGroupScheduleWithNameOfDayOfWeekViewModels?.count ?? 0)")
        if danceGroupScheduleWithNameOfDayOfWeekViewModels != nil {
            _scheduleView!.update(danceGroupScheduleWithNameOfDayOfWeekViewModels: danceGroupScheduleWithNameOfDayOfWeekViewModels!)
        } else {
            print("danceGroupScheduleWithNameOfDayOfWeekViewModels == nil")
        }
    }
     */
    
    internal func loadGet(status: String?, errors: String?, danceGroupScheduleWithNameOfDayOfWeek: DanceGroupScheduleWithNameOfDayOfWeek?) {
        
    }
    
}

/*
extension SheduleController : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return _danceGroupScheduleWithNameOfDayOfWeeks?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if _danceGroupScheduleWithNameOfDayOfWeeks == nil {
            return 0
        }
        if _danceGroupScheduleWithNameOfDayOfWeeks?.count == 0 {
            return 0
        }
        return _danceGroupScheduleWithNameOfDayOfWeeks?[section].danceGroupScheduleViewModels!.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ScheduleTableViewCell(danceGroupSchedule: (_danceGroupScheduleWithNameOfDayOfWeeks?[indexPath.section].danceGroupScheduleViewModels![indexPath.row])!)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if _danceGroupScheduleWithNameOfDayOfWeeks == nil {
            return nil
        }
        
        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 40))
        headerView.backgroundColor = UIColor(red: 83/255, green: 89/255, blue: 75/255, alpha: 1)
        
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
    
}
*/
