//
//  VisitDelegate.swift
//  LilFam NATION 3
//
//  Created by Daniil Savva on 28.01.2022.
//

protocol VisitDelegate {
    func visitPrepareResult(status: String?, errors: String?) -> ()
    func visitNotAuth() -> ()
    func visitForceLogout() -> ()
    
    func visitAdd(id_of_purchase_abonement: Int)
    func visitAddResult(status: String?, errors: String?) -> ()
    func visitDeleteResult(status: String?, errors: String?) -> ()
    func visitListResult(status: String?, errors: String?) -> ()
}
