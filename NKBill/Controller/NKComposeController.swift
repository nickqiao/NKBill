//
//  NKComposeController.swift
//  NKBill
//
//  Created by nick on 16/1/30.
//  Copyright © 2016年 NickChen. All rights reserved.
//

import UIKit

class NKComposeController: NKBaseTableViewController {
    
    @IBOutlet weak var platformCell: UITableViewCell!
    @IBOutlet weak var investField: UITextField!
    @IBOutlet weak var timeSpanField: UITextField!
    @IBOutlet weak var repayTypeField: UITextField!
    @IBOutlet weak var dateField: UITextField!
    @IBOutlet weak var rateField: UITextField!
    
    var account: NKAccount!
    var selectedPlatform: NKPlatform!
    
    lazy var datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .Date
        picker.addTarget(self , action: "datePickerChanged:", forControlEvents: .ValueChanged)
        return picker
    }()
    
    lazy var inputAccessory: UIToolbar = {
        let accessory = UIToolbar(frame: CGRectMake(0, 0, 320, 44))
        let item0 = UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: nil , action: nil)
        let item1 = UIBarButtonItem(barButtonSystemItem: .Done, target: self, action: "done")
        accessory.items = [item0,item1]
        return accessory
    }()
    
    
    func done() {
        dateField.endEditing(true)
    }
    
    func datePickerChanged(picker:UIDatePicker) {
        
        dateField.text = "\(picker.date.NK_formatDate())"
        
    }

    
    static func composeController() -> NKComposeController {
        let st = UIStoryboard(name: "NKComposeController", bundle: nil)
        return st.instantiateInitialViewController() as! NKComposeController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Cancel, target: self, action: "close")
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Save, target: self, action: "save")
        
        configureView()
        
        if let _ = account {
            title = "记一笔"
            fillText()
        }else {
            title = "投资详情"
        }
        
    }
    
    private func fillText() {
        platformCell.detailTextLabel?.text = account.compose_name()
        investField.text = account.compose_invest()
        rateField.text = account.compose_rate()
        timeSpanField.text = account.compose_timeSpan()
        dateField.text = account.compose_created()
        repayTypeField.text = account.compose_repayType()
    }
    
    private func configureView() {
        
        investField.keyboardType = .NumberPad
        rateField.keyboardType = .DecimalPad
        timeSpanField.keyboardType = .NumberPad
        dateField.inputView = datePicker
        dateField.inputAccessoryView = inputAccessory
        
    }

    private func addNewAccount() {
        
        let account = NKAccount()
        account.id = NSUUID().UUIDString
        account.platform = selectedPlatform
//        account.invest = Int(investField.text!)!
//        account.rate = Double(rateField.text!)!
        //account.timeSpan = Int(timeSpanField.text!)!
        //account.created = datePicker.date
        account.invest = 100000
        account.rate = 0.24
        account.timeSpan = 10
        account.created = NSDate()
        
        //            var x = timeSpanField.text!
        //            let range = x.endIndex.advancedBy(-2)..<x.endIndex
        //            account.timeSpan = Int(x.removeRange(range))
       
        
        account.timeTypeEnum = TimeType.MONTH
        account.repayTypeEnum = RepayType.AverageCapital
        
        NKLibraryAPI.sharedInstance.saveAccount(account)
    }
    
    private func updateAccount() {
        
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        switch indexPath.row {
        case 0:
            selectPlatcell()
        case 1:
            selectInvestCell()
        case 2:
            selectRateCell()
        case 3:
           selectTimeSpanCell()
        case 4:
            selectDateCell()
        case 5:
            selectDateCell()
        case 6:
            selectRepayTypeCell()
        default:
            break

        }
    }
    
    private func selectPlatcell() {
        let platVc = NKPlatformController()
        platVc.delegate = self
        self.navigationController?.pushViewController(platVc, animated: true)
    }
   
    private func selectInvestCell() {
        investField.becomeFirstResponder()
    }
    
    private func selectRateCell() {
        rateField.becomeFirstResponder()
    }
    private func selectTimeSpanCell() {
        timeSpanField.becomeFirstResponder()
    }
    
    private func selectDateCell() {
        dateField.becomeFirstResponder()
    }
    
    private func selectRepayTypeCell() {
        repayTypeField.becomeFirstResponder()
    }
    
    func close() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func save() {
        
        if account != nil {
            updateAccount()
        }else {
            addNewAccount()
        }
        self.dismissViewControllerAnimated(true, completion: nil)        
    }
    
}

extension NKComposeController: NKPlatformControllerDelegate {
    
    func platformControllerSelectPlatform(platform: NKPlatform) {
        selectedPlatform = platform
        platformCell.detailTextLabel?.text = platform.name
        platformCell.accessoryType = .None
    }
    
}

//extension NKComposeController: UITextFieldDelegate {
//    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
//        
//        if textField == investField {
//            // 一开始就禁止输入0
//            if textField.text == "¥0" && string == "0" {
//                return false
//            }
//            // 开始输入之后把第一个0去掉
//            if textField.text == "¥0" {
//                textField.text = "¥"
//                return true
//            }
//            
//            let currentCharacterCount = textField.text?.characters.count ?? 0
//            if (range.length + range.location > currentCharacterCount){
//                return false
//            }
//            let newLength = currentCharacterCount + string.characters.count - range.length
//            return newLength <= 9
//        }
//        
//        return true
//    }
//
//}


