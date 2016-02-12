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
    
    func getAccountsByDate() -> Results<NKAccount>{
        return accountManager.getAccountsByDate()
    }
    
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
    
}
