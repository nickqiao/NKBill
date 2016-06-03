//
//  NKIndexCell.swift
//  NKBill
//
//  Created by nick on 16/2/2.
//  Copyright © 2016年 NickChen. All rights reserved.
//

import UIKit

class NKIndexCell: UITableViewCell {

    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var orderLabel: UILabel!
    @IBOutlet weak var ratioLabel: UILabel!
    @IBOutlet weak var investLabel: UILabel!
    @IBOutlet weak var platLabel: UILabel!
    override func awakeFromNib() {
       
        super.awakeFromNib()
        
        // Initialization code
        numberLabel.textColor = UIColor.whiteColor()
        numberLabel.backgroundColor = Constant.Color.ThemeBlueColor
        numberLabel.layer.cornerRadius = 1
        numberLabel.layer.masksToBounds = true
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
