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
    @IBOutlet weak var orderLabel: UILabel!

    var item: NKItem! {
        didSet {
            orderLabel.text = item.Detail_repayDate()
            interestLabel.text = item.Detail_interest()
            principleLabel.text = item.Detail_principal()
            repayDateLabel.text = item.Detail_state()
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
