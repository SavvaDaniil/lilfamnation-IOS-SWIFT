//
//  LoadingOrErrorViewFactory.swift
//  LilFam NATION 3
//
//  Created by Daniil Savva on 23.01.2022.
//

import UIKit
import CoreData

class LoadingOrErrorViewFactory {
    
    public func create(
        parentController: UIViewController,
        loadingOrErrorViewDelegate: LoadingOrErrorViewDelegate,
        topView: UIView?,
        bottomView: UIView?
    ) -> LoadingOrErrorView {
        let loadingOrErrorView = LoadingOrErrorView(loadingOrErrorViewDelegate: loadingOrErrorViewDelegate)
        parentController.view.addSubview(loadingOrErrorView)
        loadingOrErrorView.translatesAutoresizingMaskIntoConstraints = false
        
        if topView != nil {
            loadingOrErrorView.topAnchor.constraint(equalTo: topView!.bottomAnchor).isActive = true
        } else {
            loadingOrErrorView.topAnchor.constraint(equalTo: parentController.view.topAnchor).isActive = true
        }
        if bottomView != nil {
            loadingOrErrorView.topAnchor.constraint(equalTo: bottomView!.bottomAnchor).isActive = true
        } else {
            loadingOrErrorView.bottomAnchor.constraint(equalTo: parentController.view.bottomAnchor).isActive = true
        }
        
        loadingOrErrorView.leadingAnchor.constraint(equalTo: parentController.view.leadingAnchor).isActive = true
        loadingOrErrorView.trailingAnchor.constraint(equalTo: parentController.view.trailingAnchor).isActive = true
        
        return loadingOrErrorView
    }
}
