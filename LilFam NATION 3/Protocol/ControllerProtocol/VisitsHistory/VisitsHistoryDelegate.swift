//
//  VisitsHistoryDelegate.swift
//  LilFam NATION 3
//
//  Created by Daniil Savva on 05.02.2022.
//

protocol VisitsHistoryDelegate {
    func visitsHistoryGetLesson(
        id_of_dance_group: Int,
        id_of_dance_group_day_of_week: Int,
        date_of_lesson_str: String,
        id_of_visit: Int
    )
}
