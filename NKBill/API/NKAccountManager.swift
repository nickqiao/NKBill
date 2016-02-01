//
//  NKAccountManager.swift
//  NKBill
//
//  Created by nick on 16/2/1.
//  Copyright © 2016年 NickChen. All rights reserved.
//

import UIKit
import RealmSwift
class NKAccountManager: NSObject {
    
    let realm = try! Realm()
    
    func getAccounts() -> [NKAccount] {
        
        return getAccountsResults().map{ $0 }
    }
    
    func sumInvest() -> Int {
        return getAccountsResults().sum("invest")
    }
    
    func getAccountsByPlatform(platform:NKPlatform) -> [NKAccount] {
        return getAccountsResults().filter("platform == %@", platform).map{ $0 }
    }
    
    func getAccountsByDate() -> [NKAccount] {
        return getAccountsResults().sorted("created", ascending: true).map{ $0 }
    }
    
    private func getAccountsResults() -> Results<NKAccount> {
        return self.realm.objects(NKAccount)
    }
    
    func saveAccount(account:NKAccount) {
        try! realm.write { () -> Void in
            appendItems(account)
            realm.add(account)
        }
    }
    
    private func appendItems(account:NKAccount) {
        itemsFromAccount(account).forEach({ account.items.append($0) })
    }
    
    private func itemsFromAccount(account: NKAccount) -> [NKItem]{
        return createItems(account.invest, rate: account.rate, length: account.timeSpan, repayType: account.repayTypeEnum, date: account.created)
    }
    
    func deleteAccount(account:NKAccount) {
        try! realm.write({ () -> Void in
            realm.delete(account)
        })
    }
    
    func deleteAccounts(accounts: [NKAccount]) {
        try! realm.write({ () -> Void in
            realm.delete(accounts)
        })
    }
    
}



