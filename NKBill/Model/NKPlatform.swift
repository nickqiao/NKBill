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
    let accounts = List<NKAccount>()
    override static func primaryKey() -> String? {
        return "name"
    }
    
    var sum: Int {
        return NKLibraryAPI.sharedInstance.getSumInvestFromPlatform(self)
    }
    
    var ratio: Double {
        return Double(sum) / Double(NKLibraryAPI.sharedInstance.getSumInvest())
    }
    
}

extension NKPlatform: NKRecordControllerDatasource {
    var title: String {
        return self.name
    }
    
    var accountsArray: Results<NKAccount> {
        return  NKLibraryAPI.sharedInstance.getAccountsFromPlatform(self)
    }
}

