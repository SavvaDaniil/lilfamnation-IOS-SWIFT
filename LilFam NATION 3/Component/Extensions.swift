//
//  Extensions.swift
//  LilFam NATION 3
//
//  Created by Daniil Savva on 20.01.2022.
//

import Foundation
import UIKit

public extension UIView {
    
    func egdeTo(_ view: UIView, _ startingYPos: CGFloat){
        view.addSubview(self)
        translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(equalTo: view.topAnchor, constant: startingYPos + GlobalVariables.titleHeight).isActive = true
        leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    func pinMenuTo(_ view: UIView, _ startingYPos: CGFloat, with constant: CGFloat){
        view.addSubview(self)
        translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(equalTo: view.topAnchor, constant: startingYPos + GlobalVariables.titleHeight).isActive = true
        leadingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        trailingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width * 2).isActive = true
        bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}




extension UIView {

    var safeTopAnchor: NSLayoutYAxisAnchor {
        if #available(iOS 11.0, *) {
            return safeAreaLayoutGuide.topAnchor
        }
        return topAnchor
    }

    var safeLeftAnchor: NSLayoutXAxisAnchor {
        if #available(iOS 11.0, *){
            return safeAreaLayoutGuide.leftAnchor
        }
        return leftAnchor
    }

    var safeRightAnchor: NSLayoutXAxisAnchor {
        if #available(iOS 11.0, *){
            return safeAreaLayoutGuide.rightAnchor
        }
        return rightAnchor
    }

    var safeBottomAnchor: NSLayoutYAxisAnchor {
        if #available(iOS 11.0, *) {
            return safeAreaLayoutGuide.bottomAnchor
        }
        return bottomAnchor
    }
}


extension UIViewController {

    func presentFromRight(_ viewControllerToPresent: UIViewController) {
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromRight
        transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
        self.view.window!.layer.add(transition, forKey: kCATransition)

        present(viewControllerToPresent, animated: false)
    }

    func dismissToRight() {
        let transition = CATransition()
        transition.duration = 0.25
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromLeft
        self.view.window!.layer.add(transition, forKey: kCATransition)

        dismiss(animated: false)
    }
}


extension Dictionary {
    func percentEncoded() -> Data? {
        return map { key, value in
            let escapedKey = "\(key)".addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? ""
            let escapedValue = "\(value)".addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? ""
            return escapedKey + "=" + escapedValue
        }
        .joined(separator: "&")
        .data(using: .utf8)
    }
}

extension CharacterSet {
    static let urlQueryValueAllowed: CharacterSet = {
        let generalDelimitersToEncode = ":#[]@" // does not include "?" or "/" due to RFC 3986 - Section 3.4
        let subDelimitersToEncode = "!$&'()*+,;="

        var allowed = CharacterSet.urlQueryAllowed
        allowed.remove(charactersIn: "\(generalDelimitersToEncode)\(subDelimitersToEncode)")
        return allowed
    }()
}


extension String {
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return nil }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return nil
        }
    }
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
}

/*
extension UIViewController : LoadingOrErrorViewDelegate {
    
    var _loadingOrErrorViewFactory: LoadingOrErrorViewFactory {
        return LoadingOrErrorViewFactory()
    }
    
    var _loadingOrErrorView: LoadingOrErrorView? {
        get {
            return _loadingOrErrorViewFactory.create(parentController: self, loadingOrErrorViewDelegate: self)
        }
        set(newLoadingOrErrorView) {
            
        }
    }
    var loadingOrErrorView: LoadingOrErrorView {
        get {
            return _loadingOrErrorView == nil ? _loadingOrErrorViewFactory.create(parentController: self, loadingOrErrorViewDelegate: self) : _loadingOrErrorView!
        }
        set(newLoadingOrErrorView) {
            _loadingOrErrorView = newLoadingOrErrorView
        }
    }
    
    
    private func initLoadingOrError(){
       //_loadingOrErrorView = _loadingOrErrorViewFactory.create(parentController: self, loadingOrErrorViewDelegate: self)
        
    }
    
    @objc
    func extLoadingOrErrorTryAgain() {
        fatalError("Функция должна быть переопределена")
    }
}
*/
