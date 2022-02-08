//
//  ControllerBackgroundImageFactory.swift
//  LilFam NATION 3
//
//  Created by Daniil Savva on 22.01.2022.
//

import UIKit


class ControllerBackgroundImageFactory {
    
    public func createAndAdd(parentController: UIViewController){
        let imgBgd = UIImage(named: "bgdPink")
        let imgBgdView = UIImageView(frame: CGRect())
        imgBgdView.image = imgBgd
        imgBgdView.contentMode = .scaleAspectFill
        imgBgdView.clipsToBounds = true
        imgBgdView.center = parentController.view.center
        imgBgdView.layer.opacity = 0.7
        
        parentController.view.addSubview(imgBgdView)
        imgBgdView.translatesAutoresizingMaskIntoConstraints = false
        imgBgdView.topAnchor.constraint(equalTo: parentController.view.topAnchor).isActive = true
        imgBgdView.bottomAnchor.constraint(equalTo: parentController.view.bottomAnchor).isActive = true
        imgBgdView.leadingAnchor.constraint(equalTo: parentController.view.leadingAnchor).isActive = true
        imgBgdView.trailingAnchor.constraint(equalTo: parentController.view.trailingAnchor).isActive = true
        
        //parentController.view.sendSubviewToBack(imgBgdView)
    }
}
