//
//  PurchaseAbonementLite.swift
//  LilFam NATION 3
//
//  Created by Daniil Savva on 28.01.2022.
//

struct PurchaseAbonementLite: Decodable {
    var id_of_purchase_abonement: Int?
    var name: String?
    var dateOfBuy: String?
    var dateOfActivation: String?
    var dateOfMustBeUsedTo: String?
    var days: Int?
    var price: Int?
    var cashless: Int?
    var visits: Int?
    var visitsLeft: Int?
    var specialStatus: String?
    var isExpired: Bool?
    
    var id_of_user: Int?
    var fio_of_user: String?
}
