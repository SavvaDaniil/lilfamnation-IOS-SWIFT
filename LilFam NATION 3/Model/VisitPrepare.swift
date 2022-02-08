//
//  VisitPrepare.swift
//  LilFam NATION 3
//
//  Created by Daniil Savva on 28.01.2022.
//

struct VisitPrepare : Decodable {
    var nameOfUser: String?
    var date_of_buy: String?
    var id_of_dance_group: Int?
    var nameOfDanceGroup: String?
    var id_of_dance_group_day_of_week: Int?
    
    var abonementsBySpecialStatusViewModel: AbonemetsBySpecialStatus?
    var purchaseAbonementLiteViewModels: [PurchaseAbonementLite]?
    var visitLiteViewModel: VisitLite?
    var visitLiteViewModels: [VisitLite]?
}
