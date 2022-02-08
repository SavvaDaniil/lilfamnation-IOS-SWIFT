//
//  PurchaseAbonementHistoryView.swift
//  LilFam NATION 3
//
//  Created by Daniil Savva on 07.02.2022.
//

import UIKit
import CoreData

class PurchaseAbonementHistoryView : UIView {
    
    private var _context: NSManagedObjectContext
    private var _parentController: UIViewController
    private var _purchaseAbonementDelegate: PurchaseAbonementDelegate
    
    private var _tablePurchasesAbonement: UITableView?
    private var _purchasesAbonementLite: [PurchaseAbonementLite]?
    
    init(context: NSManagedObjectContext, parentController: UIViewController, purchaseAbonementDelegate: PurchaseAbonementDelegate){
        _context = context
        _parentController = parentController
        _purchaseAbonementDelegate = purchaseAbonementDelegate
        super.init(frame: CGRect())
        
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
        _purchasesAbonementLite = GlobalVariables.purchasesAbonement
        print("_purchasesAbonementLite.count: \(_purchasesAbonementLite?.count ?? 0)")
        _tablePurchasesAbonement!.reloadData()
    }
}

extension PurchaseAbonementHistoryView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return _purchasesAbonementLite?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = PurchaseAbonementHistoryTableViewCell(purchaseAbonementLite: _purchasesAbonementLite![indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath as IndexPath) {
            cell.backgroundColor = UIColor(white: 1, alpha: 0.3)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didUnhighlightRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath as IndexPath) {
            cell.backgroundColor = UIColor(white: 1, alpha: 0)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let purchaseAbonementLite = _purchasesAbonementLite![indexPath.row]
        if purchaseAbonementLite.id_of_purchase_abonement == 0 {
            AlertComponent.callAlertError("Купленный абонемент не опознан. Сообщите пожалуйста администратору", _parentController)
        }
        _purchaseAbonementDelegate.purchaseAbonementOpenInfo(purchaseAbonementLite: purchaseAbonementLite)
    }
    
    
}

