//
//  VisitLite.swift
//  LilFam NATION 3
//
//  Created by Daniil Savva on 28.01.2022.
//

struct VisitLite : Decodable {
    var id_of_visit: Int?
    var date_of_buy: String?
    var date_of_add: String?
    var id_of_dance_group: Int?
    var name_of_dance_group: String?
    
    var id_of_dance_group_day_of_week: Int?
    var time_from: String?
    var time_to: String?
    
    var id_of_purchase_abonement: Int?
    var name_of_abonement: String?
    
    var appCheck: Int?
    var isReservation: Int?
    var statusOfReservation: Int?
    
    var statusForDisableCanselByUser: Int?
}
