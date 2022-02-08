//
//  AbonementLite.swift
//  LilFam NATION 3
//
//  Created by Daniil Savva on 28.01.2022.
//

struct AbonementLite : Decodable {
    var id: Int?
    var name: String?
    var special_status: String?
    var days: Int?
    var price: Int?
    var visits: Int?
    var status_of_visible: Int?
    var status_for_app: Int?
    var is_private: Int?
    var is_trial: Int?
}
