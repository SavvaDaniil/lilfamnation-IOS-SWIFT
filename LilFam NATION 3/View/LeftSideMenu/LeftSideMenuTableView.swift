//
//  LeftSideMenuTableView.swift
//  LilFam NATION 3
//
//  Created by Daniil Savva on 14.01.2022.
//

import UIKit



class LeftSideMenuTableView : UITableView {
    
    required init(_ parentView : UIView){
        
        super.init(frame: CGRect(), style: UITableView.Style.plain)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.backgroundColor = UIColor(white: 1, alpha: 0)
        //self.separatorStyle = .none
        self.bounces = false
        
        //self.rowHeight = parentView.frame.width * 9 / 16
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
