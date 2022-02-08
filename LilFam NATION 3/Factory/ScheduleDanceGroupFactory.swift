//
//  ScheduleDanceGroupFactory.swift
//  LilFam NATION 3
//
//  Created by Daniil Savva on 23.05.2021.
//

import Foundation


class ScheduleDanceGroupFactory : ScheduleDanceGroupFactoryProtocol {
    
    func create(id: UInt8, title: String, status: UInt8, date: Date, time: String) -> ScheduleDanceGroup {
        var scheduleDanceGroup: ScheduleDanceGroup = ScheduleDanceGroup()
        
        scheduleDanceGroup.danceGroup = DanceGroupFactory.createLite(id: id, title: title, time: time, status: status)
        
        scheduleDanceGroup.date = date
        
        return scheduleDanceGroup
    }
    
}
