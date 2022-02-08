//
//  DateToStringComponent.swift
//  LilFam NATION 3
//
//  Created by Daniil Savva on 07.02.2022.
//

import Foundation

class DateToStringComponent {
    
    public static func convertToddMMyyyy(dateAsStr: String?) -> String? {
        if dateAsStr == nil {
            return nil
        }
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = Locale.current
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        let dateFormatterOut = DateFormatter()
        dateFormatterOut.locale = Locale(identifier: "ru_RU") // set locale to reliable US_POSIX
        dateFormatterOut.dateFormat = "dd.MM.yyyy"
        var dateOfBuy: String? = nil
        
        let dateOfBuyDate = dateFormatter.date(from: (dateAsStr!))
        if dateOfBuyDate != nil {
            dateOfBuy = (dateFormatterOut.string(from: dateOfBuyDate!))
        }
        return dateOfBuy
    }
    
}
