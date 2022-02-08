//
//  VisitFacade.swift
//  LilFam NATION 3
//
//  Created by Daniil Savva on 28.01.2022.
//

import CoreData
import UIKit

class VisitFacade {
    
    private var _context: NSManagedObjectContext
    init(_ context: NSManagedObjectContext){
        _context = context
    }
    
    
    //MARK: prepare visit
    
    public func prepare(
        visitDelegate: VisitDelegate,
        id_of_dance_group: Int,
        id_of_dance_group_day_of_week: Int,
        date_of_lesson: String
    ){
        GlobalVariables.abonemetsBySpecialStatusViewModel = nil
        GlobalVariables.visitPrepare = nil
        
        ...
    }
    
    
    
    
    
    //MARK: add visit
    
    public func add(
        visitDelegate: VisitDelegate,
        id_of_dance_group: Int,
        id_of_dance_group_day_of_week: Int,
        id_of_purchase_abonement: Int,
        date_of_day: String
    ){
        ...
    }
    
    
    
    //MARK: delete visit
    
    public func prepareDelete(
        parentController: UIViewController,
        visitDelegate: VisitDelegate
    ){
        
        let alert = UIAlertController(
            title: "Отмена визита",
            message: "Вы уверены, что хотите отменить визит?",
            preferredStyle: .actionSheet
        )
        alert.addAction(UIAlertAction(title: "Отменить визит", style: .destructive, handler: { [self]_ in
            
            if GlobalVariables.visitLites != nil {
                if GlobalVariables.visitLites!.count > 0 {
                    self.delete(
                        visitDelegate: visitDelegate,
                        id_of_visit: (GlobalVariables.visitLites!.last?.id_of_visit)!
                    )
                }
            } else {
                DispatchQueue.main.async {
                    visitDelegate.visitDeleteResult(status: nil, errors: nil)
                }
            }
            
        }))
        alert.addAction(UIAlertAction(title: "Закрыть", style: .cancel, handler: nil))
        parentController.present(alert, animated: true, completion: nil)
    }
    
    public func delete(
        visitDelegate: VisitDelegate,
        id_of_visit: Int
    ){
        
        ...
    }
    
    
    //MARK: visit list
    
    public func list(
        visitDelegate: VisitDelegate
    ){
        GlobalVariables.visitLites = []
        
        ...
    }
    
    
    public func listAllByPurchaseAbonement(
        purchaseAbonementDelegate: PurchaseAbonementDelegate,
        id_of_purchase_abonement: Int
    ){
        
        GlobalVariables.visitLites = []
        
        ...
    }
}
