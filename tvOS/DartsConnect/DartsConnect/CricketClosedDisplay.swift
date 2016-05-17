//
//  CricketClosedDisplay.swift
//  DartsConnect
//
//  Created by Jordan Lewis on 17/05/2016.
//  Copyright © 2016 Jordan Lewis. All rights reserved.
//

import UIKit

class CricketClosedColumnRow: UIStackView {
    
    let imageview = UIImageView()
    
    func setCloseStage(stage:Int) {
        imageview.image = UIImage(named: "Cricket Close Icon \(stage)")
    }
    
    init(number:Int) {
        let label = UILabel()
        label.text = "\(number)"
        label.font = UIFont.systemFontOfSize(100)
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .Center
        label.textColor = UIColor.whiteColor()
        
        super.init(frame:CGRectZero)
        
        self.axis = .Horizontal
        self.distribution = .EqualCentering
        self.alignment = .Center
        self.addArrangedSubview(label)
        self.addArrangedSubview(imageview)
        
        self.addConstraint(NSLayoutConstraint(item: imageview, attribute: .Height, relatedBy: .Equal, toItem: self, attribute: .Height, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: imageview, attribute: .Width, relatedBy: .Equal, toItem: imageview, attribute: .Height, multiplier: 1, constant: 0))
        
        self.addConstraint(NSLayoutConstraint(item: label, attribute: .Height, relatedBy: .Equal, toItem: imageview, attribute: .Height, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: label, attribute: .Width, relatedBy: .Equal, toItem: imageview, attribute: .Width, multiplier: 1, constant: 0))
        
        if isDebugging {self.backgroundColor = UIColor.purpleColor()}
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class CricketClosedColumn: UIView {
    let closeStack:UIStackView = UIStackView()
    let numbers = [15,16,17,18,19,20,25]
    
    
    init() {
        super.init(frame: CGRectZero)
        
        if isDebugging {self.backgroundColor = UIColor.redColor()}
        
        closeStack.axis = .Vertical
        closeStack.distribution = .EqualSpacing
        closeStack.alignment = .Center
        closeStack.spacing = 10
        closeStack.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(closeStack)
        
        for number in numbers {
            let row = CricketClosedColumnRow(number: number)
            
            closeStack.addArrangedSubview(row)
            closeStack.addConstraint(NSLayoutConstraint(item: row, attribute: .Height, relatedBy: .Equal, toItem: closeStack, attribute: .Height, multiplier: 0.128, constant: 0))
            closeStack.addConstraint(NSLayoutConstraint(item: row, attribute: .Width, relatedBy: .Equal, toItem: row, attribute: .Height, multiplier: 2.1, constant: 0))
            closeStack.addConstraint(NSLayoutConstraint(item: row, attribute: .CenterX, relatedBy: .Equal, toItem: closeStack, attribute: .CenterX, multiplier: 1, constant: 0))
        }
        
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[closeStack]|", options: .AlignAllCenterX, metrics: nil, views: ["closeStack":closeStack]))
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[closeStack]|", options: .AlignAllCenterY, metrics: nil, views: ["closeStack":closeStack]))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class CricketClosedDisplay: UIView {
    
    let columnStack:UIStackView = UIStackView()
    
    func updateCloseStageFor(index:Int, closeNumber:Int, toStage:Int) {
        let spacerAdj = GlobalVariables.sharedVariables.currentGame!.players.count > 2 ? 0 : 1
        let adjustedIndex = index + spacerAdj
        let column = columnStack.arrangedSubviews[adjustedIndex] as! CricketClosedColumn
        let row = column.closeStack.arrangedSubviews[column.numbers.indexOf(closeNumber)!] as! CricketClosedColumnRow
        row.setCloseStage(toStage)
    }
    
    func applyColumnConstraintsTo(column:UIView) {
        columnStack.addConstraint(NSLayoutConstraint(item: column, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: 300))
        columnStack.addConstraint(NSLayoutConstraint(item: column, attribute: .Height, relatedBy: .Equal, toItem: columnStack, attribute: .Height, multiplier: 1, constant: 0))
    }
    
    func addBlankColumn() {
        let column = UIView()
        column.backgroundColor = UIColor.redColor()
        column.translatesAutoresizingMaskIntoConstraints = false
        columnStack.addArrangedSubview(column)
        applyColumnConstraintsTo(column)
    }
    
    init(numPlayers:Int) {
        super.init(frame: CGRectZero)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        if isDebugging {self.backgroundColor = UIColor.greenColor()}
        
        columnStack.axis = .Horizontal
        columnStack.spacing = 10
        columnStack.distribution = .EqualSpacing
        columnStack.alignment = .Center
        
        if numPlayers <= 2 {addBlankColumn()}
        
        for _ in 0..<numPlayers {
            let column = CricketClosedColumn()
            column.translatesAutoresizingMaskIntoConstraints = false
            columnStack.addArrangedSubview(column)
            applyColumnConstraintsTo(column)
        }
        
        if numPlayers <= 2 {addBlankColumn()}
        
        self.addSubview(columnStack)
        columnStack.translatesAutoresizingMaskIntoConstraints = false
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[columnStack]|", options: .AlignAllCenterY, metrics: nil, views: ["columnStack":columnStack]))
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[columnStack]|", options: .AlignAllCenterY, metrics: nil, views: ["columnStack":columnStack]))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}