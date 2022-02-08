//
//  ScheduleProtocol.swift
//  LilFam NATION 3
//
//  Created by Daniil Savva on 23.01.2022.
//

protocol ScheduleDelegate {
    //func loadResult(jsonAnswerStatus: JsonAnswerStatus?) -> ()
    func scheduleLoadResult(
        status: String?,
        errors: String?
        //danceGroupScheduleWithNameOfDayOfWeeks: [DanceGroupScheduleWithNameOfDayOfWeek]?
        //danceGroupScheduleWithNameOfDayOfWeekViewModels: [DanceGroupScheduleWithNameOfDayOfWeekViewModel]?
    ) -> ()
    /*
    func loadGet(
        status: String?,
        errors: String?,
        danceGroupScheduleWithNameOfDayOfWeek: DanceGroupScheduleWithNameOfDayOfWeek?
    )
     */
    
}
