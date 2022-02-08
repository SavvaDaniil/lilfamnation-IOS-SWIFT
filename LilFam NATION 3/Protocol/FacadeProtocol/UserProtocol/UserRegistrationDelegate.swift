//
//  UserRegistrationProtocol.swift
//  LilFam NATION 3
//
//  Created by Daniil Savva on 20.01.2022.
//

import Foundation


protocol UserRegistrationDelegate {
    func result(jsonAnswerStatus: JsonAnswerStatus?) -> ()
}
