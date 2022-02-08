//
//  ScheduleFacadeProtocol.swift
//  LilFam NATION 3
//
//  Created by Daniil Savva on 23.05.2021.
//

import Foundation


protocol ScheduleFacadeProtocol {
    func getAsyncCurrentSchedule() -> (arrayOfScheduleDay: Array<ScheduleDay>, isSuccess: Bool, error: String?)
}
