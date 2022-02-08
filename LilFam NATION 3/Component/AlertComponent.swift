//
//  AlertComponent.swift
//  LilFam NATION 3
//
//  Created by Daniil Savva on 20.01.2022.
//

import UIKit

class AlertComponent {
    
    public static func callAlertError(_ message: String, _ controller: UIViewController){
        let alert = UIAlertController(title: "Ошибка", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Закрыть", style: .default, handler: nil))
        controller.present(alert, animated: true, completion: nil)
    }
    
    public static func callAlertSuccess(_ message: String, _ controller: UIViewController){
        let alert = UIAlertController(title: "Успешно", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Закрыть", style: .default, handler: nil))
        controller.present(alert, animated: true, completion: nil)
    }
    
    
}
