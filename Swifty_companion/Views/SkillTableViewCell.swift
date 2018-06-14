//
//  SkillTableViewCell.swift
//  Swifty_companion
//
//  Created by Audrey ROEMER on 4/22/18.
//  Copyright © 2018 Audrey ROEMER. All rights reserved.
//

import UIKit

class SkillTableViewCell: UITableViewCell {
    
    @IBOutlet var skillLabel: UILabel!
    @IBOutlet var skillLevelLabel: UILabel!
    @IBOutlet var skillProgress: UIProgressView! {
        didSet {
            skillProgress.transform = skillProgress.transform.scaledBy(x: 1, y: 1.5)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
