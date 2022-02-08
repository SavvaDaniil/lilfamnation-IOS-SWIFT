//
//  DanceGroupLessonDelegate.swift
//  LilFam NATION 3
//
//  Created by Daniil Savva on 25.01.2022.
//

protocol DanceGroupLessonDelegate {
    
    func danceGroupLessonGetOpenViewController(
        id_of_dance_group: Int,
        id_of_dance_group_day_of_week: Int,
        date_of_lesson_str: String,
        id_of_visit: Int?
    )
    
    func danceGroupLessonFetchResult(
        status: String?,
        errors: String?
    )
    
    func danceGroupLessonActionWithVisit(isAdd: Bool) -> ()
    func danceGroupLessonAfterVisitAction()
}
