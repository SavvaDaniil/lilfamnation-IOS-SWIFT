//
//  GlobalVariables.swift
//  LilFam NATION 3
//
//  Created by Daniil Savva on 12.01.2022.
//

import UIKit

struct GlobalVariables {
    
    static let startingYPos: CGFloat = {
        var heightToReturn: CGFloat = 0.0
             for window in UIApplication.shared.windows {
                 if let height = window.windowScene?.statusBarManager?.statusBarFrame.height, height > heightToReturn {
                     heightToReturn = height
                 }
             }
        return heightToReturn
    }()
    
    static let baseDomain: String = "XXXXXXXXXXXXXXXX"
    static let titleHeight: CGFloat = 44
    
    ...
    
    static let activeColor: UIColor = .black
    static let notActiveColor: UIColor = UIColor(red: 150/255, green: 150/255, blue: 150/255, alpha: 1)
    
    static var danceGroupScheduleWithNameOfDayOfWeek : DanceGroupScheduleWithNameOfDayOfWeek?
    static var danceGroupScheduleWithNameOfDayOfWeeks: [DanceGroupScheduleWithNameOfDayOfWeek]?
    static var visitLites: [VisitLite]?
    
    static var visitPrepare: VisitPrepare?
    static var purchasesAbonement: [PurchaseAbonementLite]?
    static var abonemetsBySpecialStatusViewModel: AbonemetsBySpecialStatus?
    
}
