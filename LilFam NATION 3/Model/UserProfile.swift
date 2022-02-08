//
//  UserProfile.swift
//  LilFam NATION 3
//
//  Created by Daniil Savva on 22.01.2022.
//


struct UserProfile : Decodable {
    var id: Int?
    var fio: String?
    var phone: String?
    var sex: Int?
    var dateOfBirthday: String?
    var username: String?
    var parentFio: String?
    var parentPhone: String?
}
