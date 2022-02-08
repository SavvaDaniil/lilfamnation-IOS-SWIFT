//
//  PaymentPrepareController.swift
//  LilFam NATION 3
//
//  Created by Daniil Savva on 31.01.2022.
//

import UIKit
import CoreData

class PaymentPrepareController : UIViewController {
    
    private var _context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    private let _navigationBarFactory: NavigationBarFactory = NavigationBarFactory()
    private var _navigationBar: NavigationBar?
    
    private var _id_of_dance_group: Int?
    private var _id_of_dance_group_day_of_week: Int?
    private var _date_of_lesson_str: String?
    /*
    private var _id_of_abonement: Int?
    private var _name_of_abonement: String?
    private var _price: Int?
    private var _days: Int?
     */
    private var _abonementLite: AbonementLite?
    private var _name_of_dance_group: String?
    
    
    private var _labelNameOfAbonement: UILabel?
    private var _labelPriceTitle: UILabel?
    private var _labelVisitsTitle: UILabel?
    private var _labelDaysTitle: UILabel?
    private var _labelNameOfDanceGroupTitle: UILabel?
    
    private var _labelPrice: UILabel?
    private var _labelVisits: UILabel?
    private var _labelDays: UILabel?
    private var _labelNameOfDanceGroup: UILabel?
    
    private var _actionBtn: UIButton?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let controllerBackgroundImageFactory = ControllerBackgroundImageFactory()
        controllerBackgroundImageFactory.createAndAdd(parentController: self)
        
        _navigationBar = _navigationBarFactory.createWithOnlyButtonBack(parentController: self, titleText: "")
        
        _labelNameOfAbonement = UILabel(frame: CGRect())
        _labelNameOfAbonement!.textAlignment = .center
        _labelNameOfAbonement!.font = UIFont(name: GlobalVariables.fontGothamProMediumSrc, size: 20)
        _labelNameOfAbonement!.textColor = .white
        _labelNameOfAbonement!.text = _abonementLite?.name
        
        self.view.addSubview(_labelNameOfAbonement!)
        _labelNameOfAbonement!.translatesAutoresizingMaskIntoConstraints = false
        _labelNameOfAbonement!.topAnchor.constraint(equalTo: _navigationBar!.bottomAnchor, constant: 20).isActive = true
        _labelNameOfAbonement!.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20).isActive = true
        _labelNameOfAbonement!.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20).isActive = true
        
        
        
        
        _labelPriceTitle = UILabelDefaultPaymentDesc(textLabel: "Стоимость:")
        self.view.addSubview(_labelPriceTitle!)
        _labelPriceTitle!.translatesAutoresizingMaskIntoConstraints = false
        _labelPriceTitle!.topAnchor.constraint(equalTo: _labelNameOfAbonement!.bottomAnchor, constant: 20).isActive = true
        _labelPriceTitle!.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20).isActive = true
        
        let price: String = String(_abonementLite?.price ?? 0)
        
        _labelPrice = UILabelDefaultPaymentDesc(textLabel: price + " руб.", isTitle: false)
        self.view.addSubview(_labelPrice!)
        _labelPrice!.translatesAutoresizingMaskIntoConstraints = false
        _labelPrice!.topAnchor.constraint(equalTo: _labelNameOfAbonement!.bottomAnchor, constant: 20).isActive = true
        _labelPrice!.leadingAnchor.constraint(equalTo: _labelPriceTitle!.trailingAnchor, constant: 4).isActive = true
        
        
        
        _labelVisitsTitle = UILabelDefaultPaymentDesc(textLabel: "Занятий:")
        self.view.addSubview(_labelVisitsTitle!)
        _labelVisitsTitle!.translatesAutoresizingMaskIntoConstraints = false
        _labelVisitsTitle!.topAnchor.constraint(equalTo: _labelPriceTitle!.bottomAnchor, constant: 20).isActive = true
        _labelVisitsTitle!.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20).isActive = true
        
        let visits: String = String(_abonementLite?.visits ?? 0)
        
        _labelVisits = UILabelDefaultPaymentDesc(textLabel: visits + " шт.", isTitle: false)
        self.view.addSubview(_labelVisits!)
        _labelVisits!.translatesAutoresizingMaskIntoConstraints = false
        _labelVisits!.topAnchor.constraint(equalTo: _labelPriceTitle!.bottomAnchor, constant: 20).isActive = true
        _labelVisits!.leadingAnchor.constraint(equalTo: _labelVisitsTitle!.trailingAnchor, constant: 4).isActive = true
        
        
        
        _labelDaysTitle = UILabelDefaultPaymentDesc(textLabel: "Количество дней:")
        self.view.addSubview(_labelDaysTitle!)
        _labelDaysTitle!.translatesAutoresizingMaskIntoConstraints = false
        _labelDaysTitle!.topAnchor.constraint(equalTo: _labelVisits!.bottomAnchor, constant: 20).isActive = true
        _labelDaysTitle!.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20).isActive = true
        
        let days: String = String(_abonementLite?.days ?? 0)
        
        _labelDays = UILabelDefaultPaymentDesc(textLabel: days + " дней", isTitle: false)
        self.view.addSubview(_labelDays!)
        _labelDays!.translatesAutoresizingMaskIntoConstraints = false
        _labelDays!.topAnchor.constraint(equalTo: _labelVisits!.bottomAnchor, constant: 20).isActive = true
        _labelDays!.leadingAnchor.constraint(equalTo: _labelDaysTitle!.trailingAnchor, constant: 4).isActive = true
        
        if _name_of_dance_group != nil && _name_of_dance_group != "" {
            _labelNameOfDanceGroupTitle = UILabelDefaultPaymentDesc(textLabel: "Сразу отметить на занятие:")
            self.view.addSubview(_labelNameOfDanceGroupTitle!)
            _labelNameOfDanceGroupTitle!.translatesAutoresizingMaskIntoConstraints = false
            _labelNameOfDanceGroupTitle!.topAnchor.constraint(equalTo: _labelDays!.bottomAnchor, constant: 20).isActive = true
            _labelNameOfDanceGroupTitle!.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20).isActive = true
            _labelNameOfDanceGroupTitle!.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20).isActive = true
            
            _labelNameOfDanceGroup = UILabelDefaultPaymentDesc(textLabel: _name_of_dance_group!, isTitle: false)
            self.view.addSubview(_labelNameOfDanceGroup!)
            _labelNameOfDanceGroup!.translatesAutoresizingMaskIntoConstraints = false
            _labelNameOfDanceGroup!.topAnchor.constraint(equalTo: _labelNameOfDanceGroupTitle!.bottomAnchor, constant: 20).isActive = true
            _labelNameOfDanceGroup!.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20).isActive = true
            _labelNameOfDanceGroup!.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20).isActive = true
        }
        
        
        _actionBtn = ButtonDefault("Купить")
        self.view.addSubview(_actionBtn!)
        _actionBtn!.translatesAutoresizingMaskIntoConstraints = false
        _actionBtn!.bottomAnchor.constraint(equalTo: self.view.bottomAnchor,constant: -12).isActive = true
        _actionBtn!.leadingAnchor.constraint(equalTo: self.view.leadingAnchor,constant: 8).isActive = true
        _actionBtn!.trailingAnchor.constraint(equalTo: self.view.trailingAnchor,constant: -8).isActive = true
        //_actionBtn!.addTarget(self, action: #selector(btnActionClick), for: .touchUpInside)
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
    
    
    
    public func setup(
        id_of_dance_group: Int?,
        id_of_dance_group_day_of_week: Int?,
        date_of_lesson_str: String?,
        abonementLite: AbonementLite,
        name_of_dance_group: String?
    ){
        _id_of_dance_group = id_of_dance_group
        _id_of_dance_group_day_of_week = id_of_dance_group_day_of_week
        _date_of_lesson_str = date_of_lesson_str
        _abonementLite = abonementLite
        _name_of_dance_group = name_of_dance_group
    }
    
    /*
    private func createPaymentTitleDesc(
        view: UIView,
        viewTop: UIView,
        textTitle: String,
        textString: String
    ) -> (UILabelDefaultPaymentDesc, UILabelDefaultPaymentDesc) {
        
        let labelTitle = UILabelDefaultPaymentDesc(textLabel: textTitle)
        view.addSubview(labelTitle)
        labelTitle.translatesAutoresizingMaskIntoConstraints = false
        labelTitle.topAnchor.constraint(equalTo: viewTop.bottomAnchor, constant: 20).isActive = true
        labelTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        
        let labelPrice = UILabelDefaultPaymentDesc(textLabel: textString, isTitle: false)
        view.addSubview(labelPrice)
        labelPrice.translatesAutoresizingMaskIntoConstraints = false
        labelPrice.topAnchor.constraint(equalTo: view.bottomAnchor, constant: 20).isActive = true
        labelPrice.leadingAnchor.constraint(equalTo: labelTitle.trailingAnchor, constant: 4).isActive = true
        
        return (labelTitle, labelPrice)
    }
    */
    
    
    private class UILabelDefaultPaymentDesc: UILabel {
        init(textLabel: String, isTitle: Bool = true){
            super.init(frame: CGRect())
            
            self.text = textLabel
            self.textColor = .white
            if isTitle {
                self.font = UIFont(name: GlobalVariables.fontGothamProMediumSrc, size: 16)
            } else {
                self.font = UIFont(name: GlobalVariables.fontGothamProLightSrc, size: 16)
            }
        }
        required init?(coder: NSCoder) {
            fatalError()
        }
    }
    
}
