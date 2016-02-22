//
//  NKLibraryAPI.swift
//  NKBill
//
//  Created by nick on 16/1/31.
//  Copyright © 2016年 NickChen. All rights reserved.
//

import UIKit
import RealmSwift
class NKLibraryAPI: NSObject {
    
    private var platformManager: NKPlatformManager
    private var accountManager: NKAccountManager
    static let sharedInstance = NKLibraryAPI()
    
    private override init() {
        
        platformManager = NKPlatformManager()
        accountManager = NKAccountManager()
        super.init()
    }

    func updateUIWith(controller: String,with closure:() -> Void) {
        accountManager.updateUI(controller, with: closure)
    }
    
    func removeClosure(controller: String) {
        accountManager.removeClosure(controller)
    }
    
    func saveAccount(account: NKAccount) {
        accountManager.addAccount(account)
    }
    
    func deleteAccount(account: NKAccount) {
        accountManager.deleteAccount(account)
    }
    
    func updateAccount(oldAccount: NKAccount, with newAccount: NKAccount) {
        accountManager.updateAccount(oldAccount, with: newAccount)
    }
    
}


extension NKLibraryAPI {
    func getPlatforms() -> Results<NKPlatform> {
        return platformManager.getPlatforms()
    }
    
    func getInvestedPlatforms() -> Results<NKPlatform> {
        
        return platformManager.getInvestedPlatforms()

    }
    
    func addPlatform(platfrom: NKPlatform) {
        platformManager.addPlatform(platfrom)
    }
    
    func deletePlatform(platform:NKPlatform) {
        platformManager.deleteplatform(platform)
    }
    
}

extension NKLibraryAPI {
    
    func getAccountsByRate(from from: Double,to: Double) -> Double {
        return accountManager.getAccountsByRate(from: from, to: to)
    }
    
    func getAccountsByDate() -> Results<NKAccount>{
        return accountManager.getAccountsByDate()
    }
    
    func getWatingSumInvest() -> Double {
        return accountManager.getWatingSumInvest()
    }
    /// 此数值是算了等额本息回款的金额
    func getSumInvest() -> Int {
        return accountManager.getSumInvest()
    }
    
    func getWeightRate() -> Double {
        return accountManager.getWeightRate()
    }
    
    /// 待处理中需要在badgeValue处通知的个数
    func getUnsolvedItemsCount() -> Int {
        return accountManager.getUnsolvedItemsCount()
    }
    
    func getPassedInterest() -> Double {
        return accountManager.getPassedInterest()
    }
    
    func getWatingInterest() -> Double {
        return accountManager.getWatingInterest()
    }
    
    func getAccountsFromPlatform(platform: NKPlatform) -> Results<NKAccount> {
        return accountManager.getAccountsByPlatform(platform)
    }
    
    func getSumInvestFromPlatform(platform: NKPlatform) -> Int {
        return accountManager.getSumInvestFromPlatform(platform)
    }
    
    /// 需要本地通知的条目
    func getNeedNoticeItems() -> Results<NKItem> {
        return accountManager.getNeedNoticeItems()
    }
    
    func getOverdueItems() -> Results<NKItem> {
        return accountManager.getOverdueItems()
    }
    
    func getWaitingItems() -> Results<NKItem> {
        return accountManager.getWaitingItems()
    }
    
    func getBeforeWatingItems() -> Results<NKItem> {
        return accountManager.getBeforeWatingItems()
    }
    
    func getTodayWatingItems()-> Results<NKItem> {
        return accountManager.getTodayWatingItems()
    }
    
    func getInAmonthWatingItems() -> Results<NKItem> {
        return accountManager.getInAmonthWatingItems()
    }

    func getAfterAmonthWatingItems() -> Results<NKItem> {
        return accountManager.getOneMonthLaterWatingItems()
    }
    
    func getPassedItems() -> Results<NKItem> {
        return accountManager.getPassedItems()
    }
 
    func changeItemState(item: NKItem,toState:State) {
        accountManager.changeItemState(item, toState: toState)
    }
    
    
    /// 获得当前前后month个月,比如month传入12,获得当前日前后一年的数据
    func getInterestAndItem(before before:Int, after:Int) -> [(date:NSDate,sum:Double,items:Results<NKItem>)] {
     
        var empty: [(date:NSDate,sum:Double,items:Results<NKItem>)] = []
        
        for i in (-1 * before)...(after - 1) {
            
            let d = NSDate().NK_startOfMonth().NK_dateByAddingMonths(i)
            
            let d1 = d.NK_dateByAddingMonths(1)
            
            empty += [(
                d,
                accountManager.getInterestSumAndItems(from: d, to: d1).sum,
                accountManager.getInterestSumAndItems(from: d, to: d1).items
                )]

        }
        
        return empty
    }
  

    
}
