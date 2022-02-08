//
//  PurchaseAbonementFacade.swift
//  LilFam NATION 3
//
//  Created by Daniil Savva on 06.02.2022.
//

import CoreData

class PurchaseAbonementFacade {
    
    private var _context: NSManagedObjectContext
    init(_ context: NSManagedObjectContext){
        _context = context
    }
    
    public func listAll(
        purchaseAbonementDelegate: PurchaseAbonementDelegate
    ){
        ...
    }
    
}
