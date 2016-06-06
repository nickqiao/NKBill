//
//  PasscodeVcManager.swift
//  NKBill
//
//  Created by nick on 16/6/4.
//  Copyright © 2016年 NickChen. All rights reserved.
//

import Foundation
import PasscodeLock
import LocalAuthentication
class PasscodeVcManager {
    
    private init () {}
    
    static let sharedInstance = PasscodeVcManager()
    
    private var configuration = PasscodeLockConfiguration(repository: UserDefaultsPasscodeRepository())
    
    private var passcodeVC : PasscodeLockViewController?
    
//    static func canUseTouchId() -> Bool {
//        
//        let context: LAContext! = LAContext()
//        var errora: NSError?
//        
//        let os = NSProcessInfo().operatingSystemVersion
//        if os.majorVersion < 8 {
//            return false
//        }
//        
//        return context.canEvaluatePolicy(LAPolicy.DeviceOwnerAuthenticationWithBiometrics, error: &errora)
//       
//    }
    
    
    func showSetcodeVc() {
        passcodeVC = PasscodeLockViewController(state: .SetPasscode, configuration: configuration)
        UIApplication.topViewController()?.presentViewController(passcodeVC!, animated: true, completion: nil)
    }
    
    func showDeleteCodeVc() {
        passcodeVC = PasscodeLockViewController(state: .RemovePasscode, configuration: configuration)
        
        passcodeVC!.successCallback = { lock in
            
            lock.repository.deletePasscode()
        }
        UIApplication.topViewController()?.presentViewController(passcodeVC!, animated: true, completion: nil)
    }
    
}