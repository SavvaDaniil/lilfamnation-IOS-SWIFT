//
//  DanceGroupFactory.swift
//  LilFam NATION 3
//
//  Created by Daniil Savva on 23.05.2021.
//

import Foundation


class DanceGroupFactory : DanceGroupFactoryProtocol {
    
    static func createLite(id: UInt8, title: String, time: String, status: UInt8) -> DanceGroup {
        return DanceGroup(id: id, title: title, time: time, status: status)
    }
    
}
