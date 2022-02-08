//
//  AuthUserLoginResultDelegate.swift
//  LilFam NATION 3
//
//  Created by Daniil Savva on 20.01.2022.
//

protocol AuthUserDelegate {
    func login(accessToken: String) -> ()
    func logout() -> ()
}
