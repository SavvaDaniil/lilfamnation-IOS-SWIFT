//
//  UserProfileDelegate.swift
//  LilFam NATION 3
//
//  Created by Daniil Savva on 22.01.2022.
//


protocol UserProfileDelegate {
    func loadedProfile(jsonAnswerStatus: JsonAnswerStatus?) -> ()
    func saveResult(jsonAnswerStatus: JsonAnswerStatus?) -> ()
}
