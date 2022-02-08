//
//  JsonAnswerStatus.swift
//  LilFam NATION 3
//
//  Created by Daniil Savva on 20.01.2022.
//


struct JsonAnswerStatus : Decodable {
    var status: String?
    var errors: String?
    var accessToken: String?
    var id_of_user: Int?
    
    ...
}
