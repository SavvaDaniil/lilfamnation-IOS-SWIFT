//
//  ScheduleDayFactoryProtocol.swift
//  LilFam NATION 3
//
//  Created by Daniil Savva on 23.05.2021.
//

import Foundation


protocol ScheduleDayFactoryProtocol {
    func create(date: Date, title: String, arrayOfScheduleDanceGroup: Array<ScheduleDanceGroup>) -> ScheduleDay
}
