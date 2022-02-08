//
//  DanceGroupFacade.swift
//  LilFam NATION 3
//
//  Created by Daniil Savva on 23.05.2021.
//

import CoreData


class DanceGroupFacade : DanceGroupFacadeProtocol {
    
    private var _context: NSManagedObjectContext
    init(_ context: NSManagedObjectContext){
        _context = context
    }
    private var _scheduleDelegate : ScheduleDelegate?
    
    func get(date: Date) -> (danceGroup: DanceGroup?, isSuccess: Bool, error: String?) {
        //Запрос
        
        return (danceGroup: nil , isSuccess: false, error: nil)
    }
    
    
    public func getScheduleByDatesOnWeek(
        scheduleDelegate : ScheduleDelegate
    ){
        ...
    }
    
    
    public func getLesson(
        danceGroupLessonDelegate : DanceGroupLessonDelegate,
        id_of_dance_group: Int,
        id_of_dance_group_day_of_week: Int,
        date_of_lesson_str: String,
        id_of_visit: Int? = 0
    ){
        ...
         
    }
    
}
