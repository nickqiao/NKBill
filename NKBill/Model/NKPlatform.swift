//
//  NKCompany.swift
//  NKBill
//
//  Created by nick on 16/1/30.
//  Copyright © 2016年 NickChen. All rights reserved.
//

import UIKit

class NKPlatform: NSObject {
    
    var name: String?
    var icon: String?
    
    init(name: String,icon: String) {
        super.init()
        self.name = name
        self.icon = icon
    }
    
}
