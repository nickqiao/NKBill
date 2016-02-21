//
//  NKScheduleCell.swift
//  NKBill
//
//  Created by nick on 16/2/3.
//  Copyright © 2016年 NickChen. All rights reserved.
//

import UIKit

class NKScheduleCell: UITableViewCell {

    @IBOutlet weak var unreadIcon: UIImageView!
    @IBOutlet weak var repayDateLabel: UILabel!
    @IBOutlet weak var investLabel: UILabel!
    @IBOutlet weak var principleLabel: UILabel!
    
    @IBOutlet weak var spanLabel: UILabel!
    @IBOutlet weak var interestLabel: UILabel!
    @IBOutlet weak var platNameLabel: UILabel!
    
    var item: NKItem? {
        didSet {
            repayDateLabel.text = item!.schedule_repayDate()
            investLabel.text = item!.schedule_sum()
            principleLabel.text = item!.schedule_principal()
            interestLabel.text = item!.schedule_interest()
            spanLabel.text = item?.schedule_progress()
            platNameLabel.text = item!.schedule_platName()
            
            if item?.repayDate.isAfterToday() == false && item?.state == State.Waiting.rawValue {
                unreadIcon.hidden = false
            }else {
                unreadIcon.hidden = true
            }
            
        }
    }
    
    override func awakeFromNib() {
                super.awakeFromNib()
        // Initialization code
        repayDateLabel.textColor = NKBlueColor()
        platNameLabel.layer.cornerRadius = 3.0
        platNameLabel.layer.borderWidth = 1.0
        platNameLabel.layer.borderColor = UIColor.flatGrayColor().CGColor
        platNameLabel.layer.masksToBounds = true
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
