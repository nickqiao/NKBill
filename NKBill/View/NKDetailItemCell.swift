//
//  NKDetailItemCell.swift
//  NKBill
//
//  Created by nick on 16/2/3.
//  Copyright © 2016年 NickChen. All rights reserved.
//

import UIKit

class NKDetailItemCell: UITableViewCell {
    @IBOutlet weak var repayDateLabel: UILabel!
    @IBOutlet weak var interestLabel: UILabel!
    @IBOutlet weak var principleLabel: UILabel!
    @IBOutlet weak var stateLabel: UILabel!

    var item: NKItem! {
        didSet {
            repayDateLabel.text = item.Detail_repayDate()
            interestLabel.text = item.Detail_interest()
            principleLabel.text = item.Detail_principal()
            
            switch item.state{
            case State.Overdue.rawValue:
                stateLabel.textColor = UIColor.flatRedColor()
            case State.Passed.rawValue:
                stateLabel.textColor = UIColor.flatGreenColor()
            default:
                stateLabel.textColor = UIColor.flatBlackColor()
            }
           
            stateLabel.text = item.Detail_state()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        repayDateLabel.font = UIFont.systemFontOfSize(12)
        interestLabel.font = UIFont.systemFontOfSize(12)
        principleLabel.font = UIFont.systemFontOfSize(12)
        stateLabel.font = UIFont.systemFontOfSize(12)
        stateLabel.textAlignment = .Center
    }

    
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
