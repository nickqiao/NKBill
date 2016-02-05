//
//  NKScheduleHeader.swift
//  NKBill
//
//  Created by nick on 16/2/3.
//  Copyright © 2016年 NickChen. All rights reserved.
//

import UIKit

class NKDetailHeader: UIView {

    static func detailHeader() -> NKDetailHeader {
        return NSBundle.mainBundle().loadNibNamed("NKDetailHeader", owner: nil, options: nil).last as! NKDetailHeader
    }

}
