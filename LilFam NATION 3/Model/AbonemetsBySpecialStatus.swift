//
//  AbonmenetsBySpecialStatus.swift
//  LilFam NATION 3
//
//  Created by Daniil Savva on 28.01.2022.
//

struct AbonemetsBySpecialStatus : Decodable {
    var abonementLiteViewModelsRaz: [AbonementLite]?
    var abonementLiteViewModelsUsual: [AbonementLite]?
    var abonementLiteViewModelsUnlim: [AbonementLite]?
    var abonementLiteViewModelsRazTrial: [AbonementLite]?
}
