//
//  ScheduleTableViewCell.swift
//  LilFam NATION 3
//
//  Created by Daniil Savva on 23.01.2022.
//

import UIKit


class ScheduleTableViewCell : UITableViewCell {
    
    private var _danceGroupSchedule : DanceGroupSchedule
    private let _textColor = UIColor(red: 229/255, green: 229/255, blue: 229/255, alpha: 1)
    
    init(danceGroupSchedule : DanceGroupSchedule){
        _danceGroupSchedule = danceGroupSchedule
        super.init(style: UITableViewCell.CellStyle.default, reuseIdentifier: "cellScheduleDanceGroupPreview")
        
        self.backgroundColor = UIColor(white: 1, alpha: 0)
        contentView.backgroundColor = UIColor(white: 1, alpha: 0)
        
        let strokeTextAttributes = [
          NSAttributedString.Key.strokeColor : _textColor,
          NSAttributedString.Key.foregroundColor : UIColor.black,
          NSAttributedString.Key.strokeWidth : -1.0,
          NSAttributedString.Key.font : UIFont(name: GlobalVariables.fontGothamProLightSrc, size: 18)]
          as [NSAttributedString.Key : Any]

        //labelOutLine.attributedText = NSMutableAttributedString(string: "Your outline text", attributes: strokeTextAttributes)
        
        
        let timeFrom = UILabel(frame: CGRect())
        timeFrom.font = UIFont(name: GlobalVariables.fontGothamProLightSrc, size: 20)
        timeFrom.text = _danceGroupSchedule.time_from
        timeFrom.textAlignment = .center
        timeFrom.textColor = _textColor
        contentView.addSubview(timeFrom)
        timeFrom.translatesAutoresizingMaskIntoConstraints = false
        timeFrom.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        timeFrom.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        timeFrom.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        timeFrom.widthAnchor.constraint(equalToConstant: 60).isActive = true
        
        
        let danceGroupName = UILabel(frame: CGRect())
        //danceGroupName.font = UIFont(name: GlobalVariables.fontGothamProLightSrc, size: 18)
        //danceGroupName.text = _danceGroupSchedule.name_of_dance_group
        danceGroupName.attributedText = NSMutableAttributedString(string: danceGroupSchedule.name_of_dance_group ?? "", attributes: strokeTextAttributes)
        danceGroupName.textColor = _textColor
        contentView.addSubview(danceGroupName)
        danceGroupName.translatesAutoresizingMaskIntoConstraints = false
        danceGroupName.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8).isActive = true
        danceGroupName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 90).isActive = true
        danceGroupName.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 8).isActive = true
        
        
        let branchName = UILabel(frame: CGRect())
        branchName.font = UIFont(name: GlobalVariables.fontGothamProLightSrc, size: 12)
        branchName.text = _danceGroupSchedule.name_of_branch
        branchName.textColor = _textColor
        contentView.addSubview(branchName)
        branchName.translatesAutoresizingMaskIntoConstraints = false
        branchName.topAnchor.constraint(equalTo: danceGroupName.bottomAnchor, constant: 4).isActive = true
        branchName.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
        branchName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 90).isActive = true
        
        /*
        UIView.animate(withDuration: 0.2, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 5, options: .curveEaseIn,animations: {
            self.contentView.transform = CGAffineTransform(scaleX: 1, y: 1)
                },completion: { finished in

            })
        */
        
        /*
        let nameOfDanceGroup = UILabel(frame: CGRect())
        nameOfDanceGroup.font = UIFont(name: GlobalVariables.fontGothamProLightSrc, size: 18)
        nameOfDanceGroup.text = _danceGroupSchedule.name_of_dance_group
        
        nameOfDanceGroup.translatesAutoresizingMaskIntoConstraints = false
        //view.backgroundColor = UIColor(white: 0, alpha: 0)
        contentView.addSubview(nameOfDanceGroup)
        nameOfDanceGroup.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        nameOfDanceGroup.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        nameOfDanceGroup.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        nameOfDanceGroup.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        */
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
