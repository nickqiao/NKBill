//
//  NKIndexSectionHeader.swift
//  NKBill
//
//  Created by nickchen on 16/2/13.
//  Copyright © 2016年 NickChen. All rights reserved.
//

import UIKit

class NKIndexSectionHeader: UIView {

    static func indexSectionHeader() -> NKIndexSectionHeader {
        return NSBundle.mainBundle().loadNibNamed("NKIndexSectionHeader", owner: nil, options: nil).last as! NKIndexSectionHeader
    }


}
