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
    var tokens = [String : NotificationToken]()
    
    func updateUI(controller: String,with closure:() -> Void) {
        
        let token = realm.addNotificationBlock { (notification, realm) -> Void in
            closure()
        }
        tokens[controller] = token
        
    }
    
    func removeClosure(controller: String) {
        
        if let token = tokens[controller] {
            realm.removeNotification(token)
        }
        
    }
    
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
    
    func updateAccount(oldAccount: NKAccount, with newAccount: NKAccount) {
        
        let newItems = createItems(newAccount)
        
        try! realm.write({ () -> Void in
            
            oldAccount.platform.sum = oldAccount.platform.sum - oldAccount.invest
            newAccount.platform.sum = newAccount.platform.sum + newAccount.invest
            let index = oldAccount.platform.accounts.indexOf(oldAccount)
            oldAccount.platform.accounts.removeAtIndex(index!)
            realm.delete(oldAccount.items)
            
            realm.add(newAccount,update: true)
            newItems.forEach({ newAccount.items.append($0) })
            realm.add(newItems)
            newAccount.platform.accounts.append(newAccount)
            realm.add(newAccount.platform)
            
        })
    }
    
}


// statics
extension NKAccountManager {
    
    func getWeightRate() -> Double {
        
        var rate = 0.0
        var x = 0.0
        getAccounts().forEach { (account) -> () in
            if account.repayType == RepayType.AverageCapital.rawValue {
                x = x + Double(account.invest) * account.rate * 0.55
            }else {
                x = x + Double(account.invest) * account.rate
            }
            rate = x / Double(getSumInvest())
        }
        return rate
    }
    
    func getSumInvest() -> Int {
        return getAccounts().sum("invest")
    }
    
    func getSumInvestFromPlatform(platform: NKPlatform) -> Int{
        return getAccountsByPlatform(platform).sum("invest")
    }
    
    func getUnsolvedItemsCount() -> Int {
        return getWaitingItems().filter("repayDate < %@",NSDate().NK_zeroMorning().NK_dateByAddingDays(1)).count
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
    
    func getNeedNoticeItems() -> Results<NKItem> {
        return getWaitingItems().filter("repayDate > %@",NSDate().NK_zeroMorning())
    }
    
    func getBeforeWatingItems() -> Results<NKItem> {
        return getWaitingItems().filter("repayDate < %@",NSDate().NK_zeroMorning())
    }
    
    func getTodayWatingItems() -> Results<NKItem> {
        return getWaitingItems().filter("repayDate > %@ AND repayDate < %@",NSDate().NK_zeroMorning(),NSDate().NK_zeroMorning().NK_dateByAddingDays(1))
    }
    
    func getInAmonthWatingItems() -> Results<NKItem> {
        return getWaitingItems().filter("repayDate <= %@ AND repayDate > %@",NSDate().NK_dateByAddingMonths(1),NSDate().NK_zeroMorning().NK_dateByAddingDays(1))
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
    
    func changeItemState(item: NKItem,toState:State) {
        try! realm.write({ () -> Void in
            item.state = toState.rawValue
        })
    }
    
}

