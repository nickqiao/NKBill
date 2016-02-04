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
    
    func addAccount(account: NKAccount) {
        let items = createItems(account)
        
        try! realm.write { () -> Void in
            
            items.forEach({ account.items.append($0) })
            realm.add(items)
            realm.add(account)
            account.platform.accounts.append(account)
            account.platform.sum = account.platform.sum + account.invest
            realm.add(account.platform)
        }
    }
    
    func deleteAccount(account: NKAccount) {
        try! realm.write { () -> Void in
            account.platform.sum = account.platform.sum - account.invest
            realm.delete(account.items)
            realm.delete(account)
        }
    }
    
}


// statics
extension NKAccountManager {
    func getSumInvest() -> Int {
        return getAccounts().sum("invest")
    }
    
    func getSumInvestFromPlatform(platform: NKPlatform) -> Int{
        return getAccountsByPlatform(platform).sum("invest")
    }
    
    func getPassedInterest() -> Double {
        return getPassedItems().sum("interest")
    }
    
    func getWatingInterest() -> Double {
        return getWaitingItems().sum("interest") + getOverdueItems().sum("interest")
    }

}

// Accounts
extension NKAccountManager {
    
    
    func getAccountsByPlatform(platform:NKPlatform) -> Results<NKAccount> {
        return getAccounts().filter("platform == %@", platform)
    }
    
    func getAccountsByDate() -> Results<NKAccount> {
        return getAccounts().sorted("created", ascending: false)
    }
    
    func getAccounts() -> Results<NKAccount> {
        return realm.objects(NKAccount)
    }
}


// Item
extension NKAccountManager {
    
    func getBeforeWatingItems() -> Results<NKItem> {
        return getWaitingItems().filter("repayDate < %@",NSDate().NK_date())
    }
    
    func getTodayWatingItems() -> Results<NKItem> {
        return getWaitingItems().filter("repayDate > %@ AND repayDate < %@",NSDate().NK_date(),NSDate().NK_date().NK_dateByAddingDays(1))
    }
    
    func getInAmonthWatingItems() -> Results<NKItem> {
        return getWaitingItems().filter("repayDate < %@ AND repayDate > %@",NSDate().NK_dateByAddingMonths(1),NSDate().NK_date().NK_dateByAddingDays(1))
    }
    
    func getOneMonthLaterWatingItems() -> Results<NKItem> {
        return getWaitingItems().filter("repayDate > %@",NSDate().NK_dateByAddingMonths(1))
    }
    
    func getOverdueItems() -> Results<NKItem> {
        return getAllItems().filter("state == %@",State.Overdue.rawValue).sorted("repayDate", ascending: true)
    }
    
    func getWaitingItems() -> Results<NKItem> {
        return getAllItems().filter("state == %@",State.Waiting.rawValue).sorted("repayDate", ascending: true)
    }
    
    func getPassedItems() -> Results<NKItem> {
        return getAllItems().filter("state == %@",State.Passed.rawValue).sorted("repayDate", ascending: false)
    }
    
    func getAllItems() -> Results<NKItem> {
        return realm.objects(NKItem)
    }
    
}

