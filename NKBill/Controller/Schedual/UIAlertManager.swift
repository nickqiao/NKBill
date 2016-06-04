//
//  SchedualCellProtocol.swift
//  NKBill
//
//  Created by nick on 16/6/4.
//  Copyright © 2016年 NickChen. All rights reserved.
//

import Foundation

class UIAlertManager {
    
    static func showAcitonSheet(item : NKItem) {
        let sheet = UIAlertController(title: "处理该笔还款状态", message: nil, preferredStyle: .ActionSheet)
        
        let watingHandler = UIAlertAction(title: "未还", style: .Default){(_) -> Void in
            
            NKLibraryAPI.sharedInstance.changeItemState(item, toState: .Waiting)
        }
        
        let passedHandler = UIAlertAction(title: "已还", style: .Default){(_) -> Void in
            
            NKLibraryAPI.sharedInstance.changeItemState(item, toState: .Passed)
        }
        
        let overDueHandler = UIAlertAction(title: "逾期", style: .Default){(_) -> Void in
            
            NKLibraryAPI.sharedInstance.changeItemState(item, toState: .Overdue)
        }
        
        let cancelAction = UIAlertAction(title: "取消", style: .Cancel, handler: nil)
        
        
        switch item.state {
            
        case State.Waiting.rawValue:
            if item.repayDate.timeIntervalSince1970 < NSDate().timeIntervalSince1970 {
                sheet.addAction(passedHandler)
                sheet.addAction(overDueHandler)
                sheet.addAction(cancelAction)
                UIApplication.topViewController()!.presentViewController(sheet, animated: true, completion: nil)
            }else {
                sheet.addAction(passedHandler)
                sheet.addAction(cancelAction)
                UIApplication.topViewController()!.presentViewController(sheet, animated: true, completion: nil)
                
            }
        case State.Passed.rawValue:
            sheet.addAction(watingHandler)
            sheet.addAction(overDueHandler)
            sheet.addAction(cancelAction)
            UIApplication.topViewController()!.presentViewController(sheet, animated: true, completion: nil)
        case State.Overdue.rawValue:
            sheet.addAction(watingHandler)
            sheet.addAction(passedHandler)
            sheet.addAction(cancelAction)
            UIApplication.topViewController()!.presentViewController(sheet, animated: true, completion: nil)
        default:
            break
            
        }

    }
}