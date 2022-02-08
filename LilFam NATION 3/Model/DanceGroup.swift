//
//  DanceGroup.swift
//  LilFam NATION 3
//
//  Created by Daniil Savva on 22.03.2021.
//

import Foundation



class DanceGroup {
    public var id: UInt8!
    public var title: String
    public var name: String?
    public var time: String
    public var status: UInt8
    
    init(id: UInt8, title: String, time: String, status: UInt8){
        self.id = id
        self.title = title
        self.time = time
        self.status = status
    }
}
