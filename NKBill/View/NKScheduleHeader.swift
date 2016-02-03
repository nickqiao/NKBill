//
//  NKScheduleHeader.swift
//  NKBill
//
//  Created by nick on 16/2/3.
//  Copyright © 2016年 NickChen. All rights reserved.
//

import UIKit

class NKScheduleHeader: UIView {

    static func scheduleHeader() -> NKScheduleHeader {
        return NSBundle.mainBundle().loadNibNamed("NKScheduleHeader", owner: nil, options: nil).last as! NKScheduleHeader
    }

}
