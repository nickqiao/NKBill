//
//  NKRecordModel.swift
//  NKBill
//
//  Created by nick on 16/2/3.
//  Copyright © 2016年 NickChen. All rights reserved.
//

import Foundation
import RealmSwift

enum NKRecordDatasource: NKRecordControllerDatasource{
    
    case placeholder
    case platform(NKPlatform)
    
    var title: String {
        
        switch self {
        case .placeholder:
            return ""
        case .platform(let plat):
            return plat.name
        }
    }
    
    var accounts: Results<NKAccount> {
        
        switch self {
        case .placeholder:
            return NKLibraryAPI.sharedInstance.getAccountsByDate()
        case .platform(let plat):
            return NKLibraryAPI.sharedInstance.getAccountsFromPlatform(plat)
        }
    }
    
}