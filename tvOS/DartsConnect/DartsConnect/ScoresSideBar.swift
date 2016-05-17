//
//  ScoresSideBar.swift
//  DartsConnect
//
//  Created by Jordan Lewis on 5/04/2016.
//  Copyright © 2016 Jordan Lewis. All rights reserved.
//

import UIKit

class ScoresSideBarScore: ScoresBarScore {
    override init() {
        super.init()
        
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-10-[scoreLabel]-10-|", options: .AlignAllCenterX, metrics: nil, views: ["scoreLabel":scoreLabel]))
        
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-10-[descLabel]-10-|", options: .AlignAllCenterX, metrics: nil, views: ["descLabel":descLabel]))
        
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-10-[scoreLabel(\(scoreLabel.font.pointSize))]-5-[descLabel(\(descLabel.font.pointSize + 10))]-10-|", options: .AlignAllCenterX, metrics: nil, views: ["scoreLabel":scoreLabel, "descLabel":descLabel]))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class ScoresSideBar: ScoresBar {
    override init(parent: GameViewController) {
        super.init(parent: parent)
        
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[header]|", options: .AlignAllCenterX, metrics: nil, views: ["header":header]))
        
        scoresStack.axis = .Vertical
        
        for score in scoresStack.arrangedSubviews {
            scoresStack.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-10-[score]-10-|", options: .AlignAllCenterX, metrics: nil, views: ["score":score]))
            scoresStack.addConstraint(NSLayoutConstraint(item: score, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: 115))
        }
                
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-25-[actionButton]-25-|", options: .AlignAllCenterX, metrics: nil, views: ["actionButton":actionButton]))

        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-25-[header]-40-[scoreStack]-40-[actionButton]-25-|", options: .AlignAllCenterX, metrics: nil, views: ["header":header, "scoreStack":scoresStack, "actionButton":actionButton]))
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[scoreStack]|", options: .AlignAllCenterX, metrics: nil, views: ["scoreStack":scoresStack]))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
