//
//  AbonementFacade.swift
//  LilFam NATION 3
//
//  Created by Daniil Savva on 08.02.2022.
//

import CoreData

class AbonementFacade {
    
    private var _context: NSManagedObjectContext
    init(_ context: NSManagedObjectContext){
        _context = context
    }
    
    public func listAll(
        abonementDelegate: AbonementDelegate
    ){
        GlobalVariables.abonemetsBySpecialStatusViewModel = nil
        GlobalVariables.visitPrepare = nil
        
        ...
        
    }
}
