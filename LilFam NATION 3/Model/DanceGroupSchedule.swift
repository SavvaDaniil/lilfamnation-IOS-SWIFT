//
//  DanceGroupSchedule.swift
//  LilFam NATION 3
//
//  Created by Daniil Savva on 23.01.2022.
//


struct DanceGroupSchedule : Decodable {
    
    var id_of_dance_group: Int?
    var name_of_dance_group: String?
    var id_of_dance_group_day_of_week: Int?
    var dayOfWeek: Int?
    var time_from: String?
    var time_to: String?
    var date_of_day: String?
    var id_of_teacher: Int?
    var teacher_name: String?
    var id_of_branch: Int?
    var name_of_branch: String?
    
    var isReplacementExistForLesson: Bool?
    
    var description: String?
    var coordinates_of_branch: String?
    var id_of_teacher_replacement: Int?
    var name_of_teacher_replacement: String?
    var teacherPosterSrc: String?
}
