//
//  LeftSideMenuTableViewCell.swift
//  LilFam NATION 3
//
//  Created by Daniil Savva on 14.01.2022.
//

import UIKit

class LeftSideMenuTableViewCell : UITableViewCell {
    
    init(){
        super.init(style: UITableViewCell.CellStyle.default, reuseIdentifier: "cellLeftSideMenu")
        contentView.backgroundColor = UIColor(white: 1, alpha: 0)
    }
    
    required init(coder: NSCoder) {
        fatalError()
    }
}
