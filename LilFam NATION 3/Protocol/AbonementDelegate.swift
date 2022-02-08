//
//  AbonementDelegate.swift
//  LilFam NATION 3
//
//  Created by Daniil Savva on 08.02.2022.
//

protocol AbonementDelegate {
    func abonementListAllResult(status: String?, errors: String?)
    func abonementForceLogout()
    func abonementNotAuth()
}
