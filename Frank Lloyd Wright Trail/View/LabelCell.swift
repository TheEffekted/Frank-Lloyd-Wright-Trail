//
//  LabelCell.swift
//  Frank Lloyd Wright Trail
//
//  Created by Max on 2/16/17.
//  Copyright © 2017 App Factory. All rights reserved.
//

import UIKit

class LabelCell: UITableViewCell {

    @IBOutlet weak var signUpLabel: UILabel!
    
    @IBOutlet weak var icon: UIImageView!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
