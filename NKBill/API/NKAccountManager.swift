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
           token.stop()
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
    
    /// 加权利率
    func getWeightRate() -> Double {
        
        var rate = 0.0
        var x = 0.0
        getAccounts().forEach { (account) -> () in
            if account.repayType == RepayType.AverageCapital.rawValue {
                x = x + Double(account.invest) * account.rate * 0.559
            }else {
                x = x + Double(account.invest) * account.rate
            }
            rate = x / Double(getSumInvest())
        }
        return rate
    }
    
    func getWatingSumInvest() -> Double {
        return getAllItems().filter("state == %@ OR state == %@",State.Overdue.rawValue,State.Waiting.rawValue).sum("principal")
    }
    
    /// 投资总额
    func getSumInvest() -> Int {
        return getAccounts().sum("invest")
    }
    /// 每个平台的投资总额
    func getSumInvestFromPlatform(platform: NKPlatform) -> Int{
        return getAccountsByPlatform(platform).sum("invest")
    }
    /// 待处理的数目
    func getUnsolvedItemsCount() -> Int {
        return getWaitingItems().filter("repayDate < %@",NSDate().NK_zeroMorning().NK_dateByAddingDays(1)).count
    }
    /// 已还利息
    func getPassedInterest() -> Double {
        return getPassedItems().sum("interest")
    }
    /// 未还利息
    func getWatingInterest() -> Double {
        return getWaitingItems().sum("interest") + getOverdueItems().sum("interest")
    }

}

// Accounts
extension NKAccountManager {
    
    /// 按平台获取account
    func getAccountsByPlatform(platform:NKPlatform) -> Results<NKAccount> {
        return getAccounts().filter("platform == %@", platform)
    }
    
    /// 按日期排序之后的account
    func getAccountsByDate() -> Results<NKAccount> {
        return getAccounts().sorted("created", ascending: false)
    }
    ///  获取所有account
    func getAccounts() -> Results<NKAccount> {
        return realm.objects(NKAccount)
    }
    
    ///  获取所有account
    func getAccountsByRate(from from: Double,to: Double) -> Double {
        return getAccounts().filter("rate > %@ AND rate <= %@",from,to).sum("invest")
    }
    
}


// Item
extension NKAccountManager {
    /// 获取需要通知的items
    func getNeedNoticeItems() -> Results<NKItem> {
        return getWaitingItems().filter("repayDate > %@",NSDate().NK_zeroMorning())
    }
    /// 今天之前的待还item
    func getBeforeWatingItems() -> Results<NKItem> {
        return getWaitingItems().filter("repayDate < %@",NSDate().NK_zeroMorning())
    }
    /// 今天的待还item
    func getTodayWatingItems() -> Results<NKItem> {
        return getWaitingItems().filter("repayDate > %@ AND repayDate < %@",NSDate().NK_zeroMorning(),NSDate().NK_zeroMorning().NK_dateByAddingDays(1))
    }
    /// 从今天算起的一个月内的item
    func getInAmonthWatingItems() -> Results<NKItem> {
        return getWaitingItems().filter("repayDate <= %@ AND repayDate > %@",NSDate().NK_dateByAddingMonths(1),NSDate().NK_zeroMorning().NK_dateByAddingDays(1))
    }
    /// 一个月后的item
    func getOneMonthLaterWatingItems() -> Results<NKItem> {
        return getWaitingItems().filter("repayDate > %@",NSDate().NK_dateByAddingMonths(1))
    }
    /// 逾期的item
    func getOverdueItems() -> Results<NKItem> {
        return getAllItems().filter("state != %@ AND repayDate < %@",State.Passed.rawValue,NSDate().NK_zeroMorning()).sorted("repayDate", ascending: true)
    }
    /// 所有的待还
    func getWaitingItems() -> Results<NKItem> {
        return getAllItems().filter("state == %@",State.Waiting.rawValue).sorted("repayDate", ascending: true)
    }
    /// 所有的已还item
    func getPassedItems() -> Results<NKItem> {
        return getAllItems().filter("state == %@",State.Passed.rawValue).sorted("repayDate", ascending: false)
    }
    /// 所有的item
    func getAllItems() -> Results<NKItem> {
        return realm.objects(NKItem)
    }
    /// 改变item状态
    func changeItemState(item: NKItem,toState:State) {
        try! realm.write({ () -> Void in
            item.state = toState.rawValue
        })
    }
    
    /// 一段时间内的item
    func getItems(from from: NSDate  ,to: NSDate) -> Results<NKItem> {
        return getAllItems().filter("repayDate <= %@ AND repayDate >= %@" , to,from)
    }
    
    func getInterestSumAndItems(from from: NSDate  ,to: NSDate) -> (passedSum : Double,sum:Double,items:Results<NKItem>) {
        
        return (getItems(from: from, to: to).filter("state == %@",State.Passed.rawValue).sum("interest"),
            getItems(from: from, to: to).sum("interest"),
            getItems(from: from, to: to))
    }
    
    /// 获得某年某月的item
    func getItems(month month: Int,year: Int) -> Results<NKItem> {
        
        let date1 = NSDate.NK_dateFrom(year: year, month: month)
        
        return getAllItems().filter("repayDate <= %@ AND repayDate >= %@" , date1.NK_dateByAddingMonths(1),date1)
    }
    /// 获得某个月的利息
    func getSumInterest(month month: Int,year:Int) -> Double {
        return getItems(month: month, year: year).sum("interest")
    }
    
    /// 获得某个月的本金
    func getSumPrinciple(month month: Int,year:Int) -> Double {
        return getItems(month: month, year: year).sum("principal")
    }
    
}

