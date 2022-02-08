//
//  TechService.swift
//  LilFam NATION 3
//
//  Created by Daniil Savva on 20.01.2022.
//

import CoreData

class TechDataService {
    private var _context: NSManagedObjectContext
    
    init(_ context: NSManagedObjectContext){
        _context = context
    }
    
    public func getAccessToken() -> String? {
        
        var isAccessTokenRowExist: Bool = false
        
        do {
            let techDatas: [TechData] = try _context.fetch(TechData.fetchRequest())
            if techDatas.count == 0 {
                //print("Нет записей")
            }
            
            for techData in techDatas {
                //print("techdata (\(techData as AnyObject).name): (\(techData as AnyObject).value as Any)")
                
                if techData.name == "access_token" {
                    isAccessTokenRowExist = true
                    return techData.value_
                }
            }
            
            if !isAccessTokenRowExist {
                if self.add("access_token", nil) {
                    
                }
            }
             
        } catch {
            return nil
        }
        return nil
    }
    
    public func isAccessTokenExist() -> Bool {
        do {
            let techDatas: [TechData] = try _context.fetch(TechData.fetchRequest())
            
            if techDatas.count == 0 {
                return false
            }
            
            for techData in techDatas {
                //print("techData as AnyObject).name : \(techData as AnyObject).name)")
                if (techData as AnyObject).name == "access_token" {
                    if (techData as AnyObject).value_ as String? != nil {
                        //print("isAccessTokenExist: \((techData as AnyObject).value_)")
                        return true
                    }
                }
            }
             
        } catch {
            return false
        }
        return false
    }
    
    
    private func add(_ name: String, _ value: String?) -> Bool{
        let newTechData = TechData(context: self._context)
        
        newTechData.name = name
        newTechData.value_ = value
        
        do {
            try self._context.save()
            return true
        } catch {
            return false
        }
    }
    
    
    public func updateAccessToken(_ value: String?) -> Bool {
        self.checkExistRowDataInsertIfNot()
        
        do {
            let techDatas: [TechData] = try _context.fetch(TechData.fetchRequest())
            
            for techData in techDatas {
                if (techData as AnyObject).name == "access_token" {
                    //(techData as TechData).setValue(value, forKey: "value_")
                    (techData as TechData).value_ = value
                    try! self._context.save()
                    return true
                }
            }
            
        } catch {
            return false
        }
        return false
    }
    
    
    private func checkExistRowDataInsertIfNot(){
        do {
            let techDatas: [TechData] = try _context.fetch(TechData.fetchRequest())
            if techDatas.count == 0 {
                if self.add("access_token", nil) { }
                return
            }
            
            for techData in techDatas {
                if (techData as AnyObject).name == "access_token" {
                    return
                }
            }
            
            if self.add("access_token", nil) { }
             
        } catch {
            return
        }
        return
    }
}
