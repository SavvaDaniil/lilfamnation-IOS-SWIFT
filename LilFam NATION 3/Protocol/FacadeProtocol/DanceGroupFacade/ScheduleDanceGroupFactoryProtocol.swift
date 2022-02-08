//
//  ScheduleDanceGroupFactoryProtocol.swift
//  LilFam NATION 3
//
//  Created by Daniil Savva on 23.05.2021.
//

import Foundation


protocol ScheduleDanceGroupFactoryProtocol {
    func create(id: UInt8, title: String, status: UInt8, date: Date, time: String) -> ScheduleDanceGroup
}
