//
//  NKAccountCell.swift
//  NKBill
//
//  Created by nick on 16/2/2.
//  Copyright © 2016年 NickChen. All rights reserved.
//

import UIKit

class NKAccountCell: NKBaseTableViewCell {

    @IBOutlet weak var circleProgressView: CircularProgressView!
    @IBOutlet weak var platNameLabel: NKIconLabel!
    @IBOutlet weak var investLabel: UILabel!
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        // Initialization code
        circleProgressView.trackTint = UIColor.flatBlackColor()
        circleProgressView.progressTint = UIColor.flatGreenColor()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
