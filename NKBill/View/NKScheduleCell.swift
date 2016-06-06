//
//  NKScheduleCell.swift
//  NKBill
//
//  Created by nick on 16/2/3.
//  Copyright © 2016年 NickChen. All rights reserved.
//

import UIKit

class NKScheduleCell: NKBaseTableViewCell {

    @IBOutlet weak var unreadIcon: UIImageView!
    @IBOutlet weak var repayDateLabel: UILabel!
    @IBOutlet weak var investLabel: UILabel!
    @IBOutlet weak var principleLabel: UILabel!
    
    @IBOutlet weak var spanLabel: UILabel!
    @IBOutlet weak var interestLabel: UILabel!
    @IBOutlet weak var platNameLabel: NKIconLabel!
    
    var item: NKItem? {
        didSet {
            repayDateLabel.text = item!.schedule_repayDate()
            investLabel.text = item!.schedule_sum()
            principleLabel.text = item!.schedule_principal()
            interestLabel.text = item!.schedule_interest()
            spanLabel.text = item!.schedule_progress()
            platNameLabel.text = item!.schedule_platName()
            unreadIcon.hidden = true
        }
    }
    
    override func awakeFromNib() {
                super.awakeFromNib()
        // Initialization code
        repayDateLabel.textColor = Constant.Color.ThemeBlueColor
    }

//    override func setData(data: Any?) {
//        if let item = data as? NKItem {
//            repayDateLabel.text = item.schedule_repayDate()
//            investLabel.text = item.schedule_sum()
//            principleLabel.text = item.schedule_principal()
//            interestLabel.text = item.schedule_interest()
//            spanLabel.text = item.schedule_progress()
//            platNameLabel.text = item.schedule_platName()
//            
////            if item.repayDate.isAfterToday() == false && item.state == State.Waiting.rawValue {
////                unreadIcon.hidden = false
////            }else {
//                unreadIcon.hidden = true
//            //}
//
//        }
//    }
    
}
