//
//  PurchaseAbonementInfoView.swift
//  LilFam NATION 3
//
//  Created by Daniil Savva on 07.02.2022.
//

import UIKit
import CoreData

class PurchaseAbonementInfoView : UIView {
    
    private var _context: NSManagedObjectContext
    private var _parentController: UIViewController
    private var _visitsHistoryDelegate: VisitsHistoryDelegate
    
    private var _purchaseAbonementLite: PurchaseAbonementLite?
    private var _visitsHistoryTableView: UITableView?
    private var _visitLites: [VisitLite]?
    
    private var _labelNameTitle: UILabel?
    private var _labelName: UILabel?
    
    private var _labelDateOfBuyTitle: UILabel?
    private var _labelDateOfBuy: UILabel?
    
    private var _labelPriceTitle: UILabel?
    private var _labelPrice: UILabel?
    
    private var _labelDaysTitle: UILabel?
    private var _labelDays: UILabel?
    
    private var _labelVisitsTitle: UILabel?
    private var _labelVisits: UILabel?
    
    private var _labelVisitsLeftTitle: UILabel?
    private var _labelVisitsLeft: UILabel?
    
    private var _labelDateOfActivationTitle: UILabel?
    private var _labelDateOfActivation: UILabel?
    
    private var _labelDateOfMustBeUsedToTitle: UILabel?
    private var _labelDateOfMustBeUsedTo: UILabel?
    
    private var _labelStatusOfEnabledTitle: UILabel?
    private var _labelStatusOfEnabled: UILabel?
    
    init(context: NSManagedObjectContext, parentController: UIViewController, visitsHistoryDelegate: VisitsHistoryDelegate){
        _context = context
        _parentController = parentController
        _visitsHistoryDelegate = visitsHistoryDelegate
        super.init(frame: CGRect())
    
        //self.backgroundColor = .blue
        
        _labelNameTitle = factoryLabelDefault(text: "Наименование:", isTitle: true, topView: nil, leftView: nil, width: 130)
        _labelName = factoryLabelDefault(leftView: _labelNameTitle!)
        
        _labelDateOfBuyTitle = factoryLabelDefault(text: "Дата покупки:", isTitle: true, topView: _labelNameTitle, leftView: nil, width: 120)
        _labelDateOfBuy = factoryLabelDefault(topView: _labelNameTitle!, leftView: _labelDateOfBuyTitle!)
        
        _labelPriceTitle = factoryLabelDefault(text: "Стоимость:", isTitle: true, topView: _labelDateOfBuyTitle, leftView: nil, width: 100)
        _labelPrice = factoryLabelDefault(topView: _labelDateOfBuyTitle!, leftView: _labelPriceTitle!)
        
        _labelDaysTitle = factoryLabelDefault(text: "На сколько дней:", isTitle: true, topView: _labelPriceTitle, leftView: nil, width: 150)
        _labelDays = factoryLabelDefault(topView: _labelPriceTitle!, leftView: _labelDaysTitle!)
        
        _labelVisitsTitle = factoryLabelDefault(text: "Занятий:", isTitle: true, topView: _labelDaysTitle, leftView: nil, width: 75)
        _labelVisits = factoryLabelDefault(topView: _labelDaysTitle!, leftView: _labelVisitsTitle!)
        
        _labelVisitsLeftTitle = factoryLabelDefault(text: "Занятий осталось:", isTitle: true, topView: _labelVisitsTitle, leftView: nil, width: 155)
        _labelVisitsLeft = factoryLabelDefault(topView: _labelVisitsTitle!, leftView: _labelVisitsLeftTitle!)
        
        _labelDateOfActivationTitle = factoryLabelDefault(text: "Дата активации:", isTitle: true, topView: _labelVisitsLeftTitle, leftView: nil, width: 140)
        _labelDateOfActivation = factoryLabelDefault(topView: _labelVisitsLeftTitle!, leftView: _labelDateOfActivationTitle!)
        
        _labelDateOfMustBeUsedToTitle = factoryLabelDefault(text: "Дата окончания:", isTitle: true, topView: _labelDateOfActivationTitle, leftView: nil, width: 140)
        _labelDateOfMustBeUsedTo = factoryLabelDefault(topView: _labelDateOfActivationTitle!, leftView: _labelDateOfMustBeUsedToTitle!)
        
        _labelStatusOfEnabledTitle = factoryLabelDefault(text: "Статус:", isTitle: true, topView: _labelDateOfMustBeUsedToTitle, leftView: nil, width: 60)
        _labelStatusOfEnabled = factoryLabelDefault(topView: _labelDateOfMustBeUsedToTitle!, leftView: _labelStatusOfEnabledTitle!)
        
        
        
        _visitsHistoryTableView = UITableView(frame: CGRect(), style: UITableView.Style.plain)
        _visitsHistoryTableView!.dataSource = self
        _visitsHistoryTableView!.delegate = self
        _visitsHistoryTableView!.bounces = false
        _visitsHistoryTableView!.backgroundColor = UIColor(white: 1, alpha: 0)
        _visitsHistoryTableView!.separatorColor = UIColor(red: 83/255, green: 89/255, blue: 75/255, alpha: 1)
        
        self.addSubview(_visitsHistoryTableView!)
        _visitsHistoryTableView!.translatesAutoresizingMaskIntoConstraints = false
        _visitsHistoryTableView!.topAnchor.constraint(equalTo: _labelStatusOfEnabled!.bottomAnchor, constant: 20).isActive = true
        _visitsHistoryTableView!.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -4).isActive = true
        _visitsHistoryTableView!.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        _visitsHistoryTableView!.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
    }
    
    public func setup(purchaseAbonementLite: PurchaseAbonementLite){
        _purchaseAbonementLite = purchaseAbonementLite
        _labelName!.text = purchaseAbonementLite.name ?? ""
        _labelDateOfBuy!.text = DateToStringComponent.convertToddMMyyyy(dateAsStr: purchaseAbonementLite.dateOfBuy) ?? ""
        let price: Int = (purchaseAbonementLite.price ?? 0) + (purchaseAbonementLite.cashless ?? 0)
        _labelPrice!.text = String(price) + " руб."
        _labelDays!.text = String(purchaseAbonementLite.days ?? 0)
        _labelVisits!.text = String(purchaseAbonementLite.visits ?? 0)
        _labelVisitsLeft!.text = String(purchaseAbonementLite.visitsLeft ?? 0)
        
        _labelDateOfActivation!.text = DateToStringComponent.convertToddMMyyyy(dateAsStr: purchaseAbonementLite.dateOfActivation) ?? " - не акт."
        _labelDateOfMustBeUsedTo!.text = DateToStringComponent.convertToddMMyyyy(dateAsStr: purchaseAbonementLite.dateOfMustBeUsedTo) ?? " - не акт."
        
        if purchaseAbonementLite.isExpired ?? false {
            _labelStatusOfEnabled!.text = "Истек срок действия"
        } else if purchaseAbonementLite.visitsLeft ?? 1 <= 0 {
            _labelStatusOfEnabled!.text = "Израсходован"
        } else {
            _labelStatusOfEnabled!.text = "Доступен для использования"
        }
        
    }
    public func update(){
        _visitLites = GlobalVariables.visitLites
        _visitsHistoryTableView!.reloadData()
    }
    
    
    private func factoryLabelDefault(text: String? = "", isTitle: Bool = false, topView: UIView? = nil, leftView: UIView? = nil, width: CGFloat? = 0) -> UILabel{
        let label = createLabelDefault(text: text ?? "", isTitle: isTitle)
        self.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        if topView == nil {
            label.topAnchor.constraint(equalTo: self.topAnchor, constant: 20).isActive = true
        } else {
            label.topAnchor.constraint(equalTo: topView!.bottomAnchor, constant: 10).isActive = true
        }
        if leftView == nil && width != nil {
            label.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
            label.widthAnchor.constraint(equalToConstant: width!).isActive = true
        } else {
            label.leadingAnchor.constraint(equalTo: leftView!.trailingAnchor, constant: 4).isActive = true
            label.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8).isActive = true
        }
        
        return label
    }
    
    private func createLabelDefault(text: String, isTitle: Bool = false) -> UILabel {
        let label = UILabel(frame: CGRect())
        label.font = UIFont(name: (isTitle ? GlobalVariables.fontGothamProMediumSrc : GlobalVariables.fontGothamProLightSrc), size: 16)
        label.textColor = .white
        label.text = text
        return label
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
}

extension PurchaseAbonementInfoView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return _visitLites?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = VisitsHistoryTableViewCell(visitLite: _visitLites![indexPath.row])
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let visitLite: VisitLite = _visitLites![indexPath.row]
        
        _visitsHistoryDelegate.visitsHistoryGetLesson(
            id_of_dance_group: visitLite.id_of_dance_group ?? 0,
            id_of_dance_group_day_of_week: visitLite.id_of_dance_group_day_of_week ?? 0,
            date_of_lesson_str: visitLite.date_of_buy ?? "",
            id_of_visit: visitLite.id_of_visit ?? 0
        )
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath as IndexPath) {
            cell.backgroundColor = UIColor(white: 1, alpha: 0.3)
        }
    }
    
    func tableView(_ tableView: UITableView, didUnhighlightRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath as IndexPath) {
            cell.backgroundColor = UIColor(white: 1, alpha: 0)
        }
    }
}

