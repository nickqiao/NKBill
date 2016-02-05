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

    func saveAccount(account: NKAccount) {
        accountManager.addAccount(account)
    }
    
    func deleteAccount(account: NKAccount) {
        accountManager.deleteAccount(account)
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
