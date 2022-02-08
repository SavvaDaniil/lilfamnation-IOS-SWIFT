//
//  VisitPrepareAbonementsView.swift
//  LilFam NATION 3
//
//  Created by Daniil Savva on 30.01.2022.
//

import UIKit
import CoreData

class VisitPrepareAbonementsView : UIView {
    
    private var _context: NSManagedObjectContext
    private var _parentController: UIViewController
    private var _visitPaymentDelegate: VisitPaymentDelegate
    
    private var _tableAbonements: UITableView?
    private var _abonements: [AbonementLite]?
    private var _selectedIndex: IndexPath?
    
    init(context: NSManagedObjectContext, parentController: UIViewController, visitPaymentDelegate: VisitPaymentDelegate){
        _context = context
        _parentController = parentController
        _visitPaymentDelegate = visitPaymentDelegate
        super.init(frame: CGRect())
        
        
        _tableAbonements = UITableView(frame: CGRect(), style: UITableView.Style.plain)
        _tableAbonements!.delegate = self
        _tableAbonements!.dataSource = self
        _tableAbonements!.bounces = false
        _tableAbonements!.backgroundColor = UIColor(white: 1, alpha: 0)
        _tableAbonements!.separatorColor = UIColor(white: 1, alpha: 0.3)
        
        self.addSubview(_tableAbonements!)
        _tableAbonements!.translatesAutoresizingMaskIntoConstraints = false
        _tableAbonements!.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        _tableAbonements!.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        _tableAbonements!.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        _tableAbonements!.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        
    }
    
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    
    public func update(){
        if GlobalVariables.abonemetsBySpecialStatusViewModel == nil {
            print("GlobalVariables.abonemetsBySpecialStatusViewModel == nil")
            return
        }
        _abonements = []
        GlobalVariables.abonemetsBySpecialStatusViewModel!.abonementLiteViewModelsRazTrial!.forEach{
            abonementLite in
            _abonements?.append(abonementLite)
        }
        GlobalVariables.abonemetsBySpecialStatusViewModel!.abonementLiteViewModelsRaz!.forEach{
            abonementLite in
            _abonements?.append(abonementLite)
        }
        GlobalVariables.abonemetsBySpecialStatusViewModel!.abonementLiteViewModelsUsual!.forEach{
            abonementLite in
            _abonements?.append(abonementLite)
        }
        GlobalVariables.abonemetsBySpecialStatusViewModel!.abonementLiteViewModelsUnlim!.forEach{
            abonementLite in
            _abonements?.append(abonementLite)
        }
        print("VisitPrepareAbonementsView _abonements.count: \(_abonements?.count ?? 0)")
        _tableAbonements!.reloadData()
    }
}

extension VisitPrepareAbonementsView: UITableViewDelegate, UITableViewDataSource {
    
    // MARK: UITableViewDelegate
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return _abonements?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: "cellAbonementForBuy")
        
        var content = cell.defaultContentConfiguration()
        content.text = _abonements?[indexPath.row].name ?? "Не найдено"
        content.textProperties.color = UIColor(white: 1, alpha: 1)
        content.textProperties.font = UIFont(name: GlobalVariables.fontGothamProLightSrc, size: 16)!
        
        let price: Int = _abonements?[indexPath.row].price ?? 0
        content.secondaryText = String(price) + " руб."
        content.secondaryTextProperties.color = UIColor(white: 1, alpha: 0.5)
        
        cell.contentConfiguration = content
        
        var background = UIBackgroundConfiguration.listGroupedCell()
        background.backgroundColor = UIColor(white: 0, alpha: 0)
        cell.backgroundConfiguration = background
        
        
        cell.selectionStyle = .none
        //var backgroundSelected = UIView()
        //backgroundSelected.backgroundColor = UIColor(white: 0, alpha: 0.3)
        //cell.selectedBackgroundView = backgroundSelected
        
        
        //let backgroundSelected = UIView()
        if _selectedIndex == indexPath {
            //backgroundSelected.backgroundColor = UIColor(white: 0, alpha: 0.3)
        } else {
            //backgroundSelected.backgroundColor = UIColor(white: 0, alpha: 0)
        }
        //cell.selectedBackgroundView = backgroundSelected
        
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let abonementLite: AbonementLite? = _abonements?[indexPath.row]
        if abonementLite == nil {
            return
        }
        //_selectedIndex = indexPath
        //_tableAbonements?.reloadRows(at: [indexPath], with: .fade)
        
        _visitPaymentDelegate.visitPaymentBegin(abonementLite: abonementLite!)
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
