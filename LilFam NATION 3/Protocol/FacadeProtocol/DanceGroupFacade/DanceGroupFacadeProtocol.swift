//
//  DanceGroupFacadeProtocol.swift
//  LilFam NATION 3
//
//  Created by Daniil Savva on 23.05.2021.
//

import Foundation

protocol DanceGroupFacadeProtocol {
    func get(date: Date) -> (danceGroup: DanceGroup?, isSuccess: Bool, error: String?)
}
