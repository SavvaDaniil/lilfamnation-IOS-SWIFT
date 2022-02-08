//
//  ScheduleDayFactory.swift
//  LilFam NATION 3
//
//  Created by Daniil Savva on 23.05.2021.
//

import Foundation


class ScheduleDayFactory : ScheduleDayFactoryProtocol {
    
    func create(date: Date, title: String, arrayOfScheduleDanceGroup: Array<ScheduleDanceGroup>) -> ScheduleDay {
        var scheduleDay: ScheduleDay = ScheduleDay()
        scheduleDay.date = date
        scheduleDay.title = title
        scheduleDay.arrayOfScheduleDanceGroup = arrayOfScheduleDanceGroup
        
        return scheduleDay
    }
    
}
