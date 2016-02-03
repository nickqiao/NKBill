//
//  NKScheduleCell.swift
//  NKBill
//
//  Created by nick on 16/2/3.
//  Copyright © 2016年 NickChen. All rights reserved.
//

import UIKit

class NKScheduleCell: UITableViewCell {

    @IBOutlet weak var repayDateLabel: UILabel!
    @IBOutlet weak var investLabel: UILabel!
    @IBOutlet weak var principleLabel: UILabel!
    @IBOutlet weak var platIconView: UIImageView!
    @IBOutlet weak var spanLabel: UILabel!
    @IBOutlet weak var interestLabel: UILabel!
    @IBOutlet weak var platNameLabel: UILabel!
    
    var item: NKItem? {
        didSet {
            repayDateLabel.text = item!.schedule_repayDate()
            investLabel.text = item!.schedule_sum()
            principleLabel.text = item!.schedule_principal()
            interestLabel.text = item!.schedule_interest()
            spanLabel.text = "1"
            platNameLabel.text = item!.schedule_platName()
        }
    }
    
    override func awakeFromNib() {
                super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
