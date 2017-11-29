//
//  AlarmTableViewCell.swift
//  Alarm
//
//  Created by Dheepthaa Anand on 21/11/17.
//  Copyright © 2017 Dheepthaa Anand. All rights reserved.
//

import UIKit

class AlarmTableViewCell: UITableViewCell {

    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var switch1: UISwitch!
    @IBOutlet weak var desc1: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        desc1.sizeToFit()
        desc1.numberOfLines = 1
        desc1.minimumScaleFactor = 4
        desc1.adjustsFontSizeToFitWidth = true
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    

}
