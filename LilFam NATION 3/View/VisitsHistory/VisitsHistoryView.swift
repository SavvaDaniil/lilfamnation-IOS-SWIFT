//
//  VisitsHistoryView.swift
//  LilFam NATION 3
//
//  Created by Daniil Savva on 05.02.2022.
//

import UIKit
import CoreData

class VisitsHistoryView : UIView {
    
    private var _context: NSManagedObjectContext
    private var _parentController: UIViewController
    private var _visitsHistoryDelegate: VisitsHistoryDelegate
    
    private var _visitsHistoryTableView: UITableView?
    private var _visitLites: [VisitLite]?
    
    init(context: NSManagedObjectContext, parentController: UIViewController, visitsHistoryDelegate: VisitsHistoryDelegate){
        _context = context
        _parentController = parentController
        _visitsHistoryDelegate = visitsHistoryDelegate
        super.init(frame: CGRect())
        
        _visitsHistoryTableView = UITableView(frame: CGRect(), style: UITableView.Style.plain)
        _visitsHistoryTableView!.dataSource = self
        _visitsHistoryTableView!.delegate = self
        _visitsHistoryTableView!.bounces = false
        _visitsHistoryTableView!.backgroundColor = UIColor(white: 1, alpha: 0)
        _visitsHistoryTableView!.separatorColor = UIColor(red: 83/255, green: 89/255, blue: 75/255, alpha: 1)
        
        self.addSubview(_visitsHistoryTableView!)
        _visitsHistoryTableView!.translatesAutoresizingMaskIntoConstraints = false
        _visitsHistoryTableView!.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        _visitsHistoryTableView!.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        _visitsHistoryTableView!.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        _visitsHistoryTableView!.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    public func update(){
        _visitLites = GlobalVariables.visitLites
        _visitsHistoryTableView!.reloadData()
    }
    
    
}

extension VisitsHistoryView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return _visitLites?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = VisitsHistoryTableViewCell(visitLite: _visitLites![indexPath.row])
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let visitLite: VisitLite = _visitLites![indexPath.row]
        
        _visitsHistoryDelegate.visitsHistoryGetLesson(
            id_of_dance_group: visitLite.id_of_dance_group ?? 0,
            id_of_dance_group_day_of_week: visitLite.id_of_dance_group_day_of_week ?? 0,
            date_of_lesson_str: visitLite.date_of_buy ?? "",
            id_of_visit: visitLite.id_of_visit ?? 0
        )
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
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
