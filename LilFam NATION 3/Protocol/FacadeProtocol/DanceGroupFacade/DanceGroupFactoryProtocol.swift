//
//  DanceGroupFactoryProtocol.swift
//  LilFam NATION 3
//
//  Created by Daniil Savva on 23.05.2021.
//

import Foundation


protocol DanceGroupFactoryProtocol {
    static func createLite(id: UInt8, title: String, time: String, status: UInt8) -> DanceGroup
}
