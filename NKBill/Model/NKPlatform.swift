//
//  NKCompany.swift
//  NKBill
//
//  Created by nick on 16/1/30.
//  Copyright © 2016年 NickChen. All rights reserved.
//

import UIKit
import RealmSwift

class NKPlatform: Object {
    
    dynamic var name = ""
    override static func primaryKey() -> String? {
        return "name"
    }
}
