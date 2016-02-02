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
    
    func getSumInvest() -> Int {
        return getAccountsResults().sum("invest")
    }
  
    func getSumInvestFromPlatform(platform: NKPlatform) -> Int{
        return getAccountsByPlatform(platform).sum("invest")
    }
    
    func getPassedInterest() -> Double {
        return getPassedItemResults().sum("interest")
    }
    
    func getWatingInterest() -> Double {
        return getWaitingItemResults().sum("interest") + getOverdueItemResults().sum("interest")
    }
    
}

// CRUD
extension NKAccountManager {
    func saveAccount(account:NKAccount) {
        try! realm.write { () -> Void in
            appendItems(account)
            account.platform?.accounts.append(account)
        }
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

// Accounts
extension NKAccountManager {
    
    func getAccountsByPlatform(platform:NKPlatform) -> Results<NKAccount> {
        return getAccountsResults().filter("platform == %@", platform)
    }
    
    func getAccountsByDate() -> [NKAccount] {
        return getAccountsResults().sorted("created", ascending: false).map{ $0 }
    }
    
    private func getAccountsResults() -> Results<NKAccount> {
        return self.realm.objects(NKAccount)
    }
}


// Item
extension NKAccountManager {
    
    func getOverdueItems() -> [NKItem] {
        return getOverdueItemResults().map({ $0 })
    }
    
    func getWaitingItems() -> [NKItem] {
        return getWaitingItemResults().map({ $0 })
    }
    
    func getPassedItems() -> [NKItem] {
        return getPassedItemResults().map({ $0 })
    }
    
    private func appendItems(account:NKAccount) {
        createItemsFor(account).forEach({ account.items.append($0) })
    }
    
    private func getOverdueItemResults() -> Results<NKItem> {
        return getAllItems().filter("state == %@",State.Overdue.rawValue).sorted("repayDate", ascending: true)
    }
    
    private func getWaitingItemResults() -> Results<NKItem> {
        return getAllItems().filter("state == %@",State.Waiting.rawValue).sorted("repayDate", ascending: true)
    }
    
    private func getPassedItemResults() -> Results<NKItem> {
        return getAllItems().filter("state == %@",State.Passed.rawValue).sorted("repayDate", ascending: false)
    }
    
    private func getAllItems() -> Results<NKItem> {
        return self.realm.objects(NKItem)
    }
    
}

// Platform
extension NKAccountManager {
    
    func getInvestedPlatforms() -> [NKPlatform] {
        return getInvestedPlatformsResults().map( {$0} )
    }
    
    private func getInvestedPlatformsResults() -> Results<NKPlatform> {
        return self.realm.objects(NKPlatform).filter("accounts.@count > 0")
    }
}
