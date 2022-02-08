//
//  VisitPreparePurchasesAbonement.swift
//  LilFam NATION 3
//
//  Created by Daniil Savva on 29.01.2022.
//

import UIKit
import CoreData

class VisitPreparePurchasesAbonementView : UIView {
    
    private var _context: NSManagedObjectContext
    private var _parentController: UIViewController
    private var _visitDelegate: VisitDelegate
    
    private var _tablePurchasesAbonement: UITableView?
    private var _purchasesAbonement: [PurchaseAbonementLite]?
    
    init(context: NSManagedObjectContext, parentController: UIViewController, visitDelegate: VisitDelegate){
        _context = context
        _parentController = parentController
        _visitDelegate = visitDelegate
        super.init(frame: CGRect())
        
        /*
        let headerTitle = UILabel(frame: CGRect())
        headerTitle.textColor = .white
        headerTitle.text = "VisitPreparePurchasesAbonementView"
        self.addSubview(headerTitle)
        */
        
        _tablePurchasesAbonement = UITableView(frame: CGRect(), style: UITableView.Style.plain)
        _tablePurchasesAbonement!.delegate = self
        _tablePurchasesAbonement!.dataSource = self
        _tablePurchasesAbonement!.bounces = false
        _tablePurchasesAbonement!.backgroundColor = UIColor(white: 1, alpha: 0)
        _tablePurchasesAbonement!.separatorColor = UIColor(white: 1, alpha: 0.3)
        
        
        self.addSubview(_tablePurchasesAbonement!)
        _tablePurchasesAbonement!.translatesAutoresizingMaskIntoConstraints = false
        _tablePurchasesAbonement!.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        _tablePurchasesAbonement!.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        _tablePurchasesAbonement!.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        _tablePurchasesAbonement!.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        
    }
    
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    public func update(){
        //print("GlobalVariables.purchasesAbonement.count: \(GlobalVariables.purchasesAbonement?.count ?? 0)")
        _purchasesAbonement = GlobalVariables.purchasesAbonement
        //print("VisitPreparePurchasesAbonementView _purchasesAbonement.count \(_purchasesAbonement?.count)")
        _tablePurchasesAbonement!.reloadData()
    }
    
}


extension VisitPreparePurchasesAbonementView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return _purchasesAbonement?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cellPurchaseAbonement")
        let purchaseAbonement = _purchasesAbonement?[indexPath.row]
        
        cell.selectionStyle = .none
        var content = cell.defaultContentConfiguration()
        content.text = _purchasesAbonement?[indexPath.row].name ?? "-"
        content.textProperties.color = UIColor(white: 1, alpha: 1)
        content.textProperties.font = UIFont(name: GlobalVariables.fontGothamProLightSrc, size: 16)!
        content.secondaryTextProperties.color = UIColor(white: 1, alpha: 1)
        //content.secondaryTextProperties.font = UIFont(name: GlobalVariables.fontGothamProLightSrc, size: 10)!
        
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = Locale.current
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        let dateFormatterOut = DateFormatter()
        dateFormatterOut.locale = Locale(identifier: "ru_RU") // set locale to reliable US_POSIX
        dateFormatterOut.dateFormat = "dd.MM.yyyy"
        var dateOfBuy: String = ""
        if purchaseAbonement?.dateOfBuy != nil {
            let dateOfBuyDate = dateFormatter.date(from: (purchaseAbonement!.dateOfBuy!))
            if dateOfBuyDate != nil {
                dateOfBuy = "куп. \(dateFormatterOut.string(from: dateOfBuyDate!))"
            }
        }
        
        content.secondaryText = "Осталось \(String(purchaseAbonement?.visitsLeft ?? 0)) из \(String(purchaseAbonement?.visits ?? 0)) | \(dateOfBuy)"
        
        var dateOfMustBeUsedTo: String = ""
        if purchaseAbonement?.dateOfMustBeUsedTo != nil {
            let dateOfMustBeUsedToDate = dateFormatter.date(from: (purchaseAbonement!.dateOfMustBeUsedTo!))
            if dateOfMustBeUsedToDate != nil {
                dateOfMustBeUsedTo = " до \(dateFormatterOut.string(from: dateOfMustBeUsedToDate!))"
            }
        }
        content.secondaryText?.append(dateOfMustBeUsedTo)
        
        cell.contentConfiguration = content
        
        var background = UIBackgroundConfiguration.listGroupedCell()
        background.backgroundColor = UIColor(white: 0, alpha: 0)
        cell.backgroundConfiguration = background
        
        return cell
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let purchaseAbonement = _purchasesAbonement![indexPath.row]
        if purchaseAbonement.id_of_purchase_abonement == 0 {
            AlertComponent.callAlertError("Купленный абонемент не опознан. Сообщите пожалуйста администратору", _parentController)
        }
        _visitDelegate.visitAdd(id_of_purchase_abonement: purchaseAbonement.id_of_purchase_abonement!)
    }
    
}
