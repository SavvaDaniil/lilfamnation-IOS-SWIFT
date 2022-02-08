//
//  VisitPaymentDelegate.swift
//  LilFam NATION 3
//
//  Created by Daniil Savva on 31.01.2022.
//

protocol VisitPaymentDelegate {
    func visitPaymentBegin(abonementLite: AbonementLite)
    func visitPaymentAfterAction()
}
