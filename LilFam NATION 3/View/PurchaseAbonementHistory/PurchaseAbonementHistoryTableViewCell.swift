//
//  PurchaseAbonementHistoryTableViewCell.swift
//  LilFam NATION 3
//
//  Created by Daniil Savva on 07.02.2022.
//

import UIKit


class PurchaseAbonementHistoryTableViewCell : UITableViewCell {
    
    private var _purchaseAbonementLite: PurchaseAbonementLite
    private var _labelTitle: UILabel?
    private var _labelStatus: UILabel?
    
    init(purchaseAbonementLite: PurchaseAbonementLite){
        _purchaseAbonementLite = purchaseAbonementLite
        super.init(style: UITableViewCell.CellStyle.default, reuseIdentifier: "cellPurchaseAbonementHistoryCell")
        
        self.backgroundColor = UIColor(white: 1, alpha: 0)
        self.preservesSuperviewLayoutMargins = false
        self.separatorInset = UIEdgeInsets.zero
        self.layoutMargins = UIEdgeInsets.zero
        
        _labelTitle = UILabel(frame: CGRect())
        self.addSubview(_labelTitle!)
        _labelTitle!.translatesAutoresizingMaskIntoConstraints = false
        _labelTitle!.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12).isActive = true
        _labelTitle!.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8).isActive = true
        _labelTitle!.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8).isActive = true
        
        _labelTitle!.text = _purchaseAbonementLite.name ?? "- наименование не найдено"
        _labelTitle!.font = UIFont(name: GlobalVariables.fontGothamProLightSrc, size: 16)
        _labelTitle!.textColor = .white
        
        
        
        _labelStatus = UILabel(frame: CGRect())
        self.addSubview(_labelStatus!)
        _labelStatus!.translatesAutoresizingMaskIntoConstraints = false
        _labelStatus!.topAnchor.constraint(equalTo: _labelTitle!.bottomAnchor, constant: 8).isActive = true
        _labelStatus!.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8).isActive = true
        _labelStatus!.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8).isActive = true
        
        _labelStatus!.font = UIFont(name: GlobalVariables.fontGothamProLightSrc, size: 12)
        _labelStatus!.textColor = .white
        
        var statusString: String = ""
        
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = Locale.current
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        let dateFormatterOut = DateFormatter()
        dateFormatterOut.locale = Locale(identifier: "ru_RU") // set locale to reliable US_POSIX
        dateFormatterOut.dateFormat = "dd.MM.yyyy"
        var dateOfBuy: String = ""
        if purchaseAbonementLite.dateOfBuy != nil {
            let dateOfBuyDate = dateFormatter.date(from: (purchaseAbonementLite.dateOfBuy!))
            if dateOfBuyDate != nil {
                dateOfBuy = "куп. \(dateFormatterOut.string(from: dateOfBuyDate!))"
            }
        }
        
        statusString = "Осталось \(String(purchaseAbonementLite.visitsLeft ?? 0)) из \(String(purchaseAbonementLite.visits ?? 0)) | \(dateOfBuy)"
        
        var dateOfMustBeUsedTo: String = ""
        if purchaseAbonementLite.dateOfMustBeUsedTo != nil {
            let dateOfMustBeUsedToDate = dateFormatter.date(from: (purchaseAbonementLite.dateOfMustBeUsedTo!))
            if dateOfMustBeUsedToDate != nil {
                dateOfMustBeUsedTo = " до \(dateFormatterOut.string(from: dateOfMustBeUsedToDate!))"
            }
        }
        statusString.append(dateOfMustBeUsedTo)
        
        _labelStatus!.text = statusString
        
        if purchaseAbonementLite.isExpired ?? false || purchaseAbonementLite.visitsLeft ?? 1 <= 0 {
            _labelTitle!.layer.opacity = 0.5
            _labelStatus!.layer.opacity = 0.5
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
