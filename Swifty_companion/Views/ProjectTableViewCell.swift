//
//  ProjectTableViewCell.swift
//  Swifty_companion
//
//  Created by Audrey ROEMER on 4/23/18.
//  Copyright © 2018 Audrey ROEMER. All rights reserved.
//

import UIKit

class ProjectTableViewCell: UITableViewCell {
    
        @IBOutlet var projectNameLabel: UILabel!
        @IBOutlet var projectGradeLabel: UILabel!
        @IBOutlet var projectValidatedImage:UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
