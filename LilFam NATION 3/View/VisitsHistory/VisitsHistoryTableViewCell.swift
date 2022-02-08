//
//  VisitsHistoryTableViewCell.swift
//  LilFam NATION 3
//
//  Created by Daniil Savva on 05.02.2022.
//

import UIKit

class VisitsHistoryTableViewCell : UITableViewCell {
    
    private var _visitLite: VisitLite
    
    private var _labelTitle: UILabel?
    private var _labelStatus: UILabel?
    
    init(visitLite: VisitLite){
        _visitLite = visitLite
        super.init(style: UITableViewCell.CellStyle.default, reuseIdentifier: "cellVisitsHistoryTableViewCell")
        
        self.backgroundColor = UIColor(white: 1, alpha: 0)
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        let dateTimeOfVisit = dateFormatter.date(from:visitLite.date_of_buy ?? "")!
        let dateFormatterTo = DateFormatter()
        dateFormatterTo.dateFormat = "dd.MM"
        let dateTimeOfVisitStr = dateFormatterTo.string(from: dateTimeOfVisit)
        
        _labelTitle = UILabel(frame: CGRect())
        self.addSubview(_labelTitle!)
        _labelTitle!.translatesAutoresizingMaskIntoConstraints = false
        _labelTitle!.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12).isActive = true
        _labelTitle!.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8).isActive = true
        _labelTitle!.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8).isActive = true
        
        _labelTitle!.text = (dateTimeOfVisitStr) + " (" + (visitLite.time_from ?? "") + ") - " + (visitLite.name_of_dance_group ?? "")
        _labelTitle!.font = UIFont(name: GlobalVariables.fontGothamProLightSrc, size: 16)
        _labelTitle!.textColor = .white
        
        
        
        _labelStatus = UILabel(frame: CGRect())
        self.addSubview(_labelStatus!)
        _labelStatus!.translatesAutoresizingMaskIntoConstraints = false
        _labelStatus!.topAnchor.constraint(equalTo: _labelTitle!.bottomAnchor, constant: 8).isActive = true
        _labelStatus!.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8).isActive = true
        _labelStatus!.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8).isActive = true
        
        _labelStatus!.font = UIFont(name: GlobalVariables.fontGothamProLightSrc, size: 12)
        
        if visitLite.statusForDisableCanselByUser == 1 {
            _labelStatus!.text = "Успешно использована"
            _labelStatus!.textColor = .green
        } else {
            _labelStatus!.text = "Ожидаем вас..."
            _labelStatus!.textColor = .gray
        }
        
        
    }
    
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
