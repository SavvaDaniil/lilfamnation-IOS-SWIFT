//
//  PurchaseAbonementDelegate.swift
//  LilFam NATION 3
//
//  Created by Daniil Savva on 06.02.2022.
//

protocol PurchaseAbonementDelegate {
    func purchaseAbonementListAllResult(status: String?, errors: String?)
    func purchaseAbonementOpenInfo(purchaseAbonementLite: PurchaseAbonementLite)
    func purchaseAbonementInfoResult(status: String?, errors: String?)
    func purchaseAbonementNotAuth()
    func purchaseAbonementForceLogout()
}
