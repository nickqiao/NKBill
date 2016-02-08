//
//  NKComposeController.swift
//  NKBill
//
//  Created by nick on 16/1/30.
//  Copyright © 2016年 NickChen. All rights reserved.
//

import UIKit

class NKComposeController: UITableViewController {
    
    @IBOutlet weak var platformCell: UITableViewCell!
    @IBOutlet weak var investField: UITextField!
    @IBOutlet weak var timeSpanField: UITextField!
    @IBOutlet weak var repayTypeField: UITextField!
    @IBOutlet weak var dateField: UITextField!
    @IBOutlet weak var rateField: UITextField!

    @IBOutlet weak var descTextView: UITextView!
    var account: NKAccount!
    var selectedPlatform: NKPlatform!
    var selectedRepayType: String!
    
    lazy var datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .Date
        picker.addTarget(self , action: "datePickerChanged:", forControlEvents: .ValueChanged)
        return picker
    }()
    
    lazy var inputAccessory: UIToolbar = {
        let accessory = UIToolbar(frame: CGRectMake(0, 0, 320, 44))
        let item0 = UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: nil , action: nil)
        let item1 = UIBarButtonItem(barButtonSystemItem: .Done, target: self, action: "inputAccessoryDone")
        accessory.items = [item0,item1]
        
        return accessory
    }()
    
    // MARK: lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        
        if let _ = account {
            title = "编辑投资"
            
            fillText()
        }else {
            title = "记一笔"
        }
        
    }
    
    // MARK:IBAction
    
    @IBAction func saveAccount(sender: AnyObject) {

        if account != nil {
            updateAccount()
        }else {
            addNewAccount()
        }
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    @IBAction func quit(sender: AnyObject) {
         self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func unwindFromPlatform(segue: UIStoryboardSegue) {
        
        let platVc = segue.sourceViewController as! NKPlatformController
        selectedPlatform = platVc.selectedPlatform
        platformCell.detailTextLabel?.text = selectedPlatform.name
        platformCell.accessoryType = .None
        
    }
    
    // MARK: handler
    func inputAccessoryDone() {
        dateField.endEditing(true)
    }
    
    func datePickerChanged(picker:UIDatePicker) {
        
        dateField.text = "\(picker.date.NK_formatDate())"
        
    }
    
    // MARK: Private
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
        repayTypeField.resignFirstResponder()
        let alertVc = UIAlertController(title: "选择还款方式", message: "", preferredStyle: .ActionSheet)
        let cancelAction = UIAlertAction(title: "取消", style: .Cancel, handler: nil)
        let action1 = UIAlertAction(title: "等额本息", style: .Default) { (_) -> Void in
            self.selectedRepayType = RepayType.AverageCapital.rawValue
            self.repayTypeField.text = "等额本息"
        }
        let action2 = UIAlertAction(title: "按月计息,到期还本", style: .Default) { (_) -> Void in
            self.selectedRepayType = RepayType.InterestByMonth.rawValue
            self.repayTypeField.text = "按月计息,到期还本"
        }
        let action3 = UIAlertAction(title: "按日计息,到期还本", style: .Default) { (_) -> Void in
            self.selectedRepayType = RepayType.InterestByDay.rawValue
            self.repayTypeField.text = "按日计息,到期还本"
        }
        let action4 = UIAlertAction(title: "到期还本息", style: .Default) { (_) -> Void in
            self.selectedRepayType = RepayType.RepayAllAtLast.rawValue
            self.repayTypeField.text = "到期还本息"

        }
        alertVc.addAction(cancelAction)
        alertVc.addAction(action1)
        alertVc.addAction(action2)
        alertVc.addAction(action3)
        alertVc.addAction(action4)
        presentViewController(alertVc, animated: true, completion: nil)
    }
    
    private func selectDescCell() {
        
    }
    
    private func fillText() {
        platformCell.detailTextLabel?.text = account.compose_name().1
        investField.text = account.compose_invest().1
        rateField.text = account.compose_rate().1
        timeSpanField.text = account.compose_timeSpan().1
        dateField.text = account.compose_created().1
        repayTypeField.text = account.compose_repayType().1
    }
    
    private func configureView() {
        
        investField.keyboardType = .NumberPad
        rateField.keyboardType = .DecimalPad
        timeSpanField.keyboardType = .NumberPad
        dateField.inputView = datePicker
        dateField.inputAccessoryView = inputAccessory
        dateField.text = "\(NSDate().NK_formatDate())"
        descTextView.layer.borderColor = UIColor.flatBlackColor().CGColor
        descTextView.layer.borderWidth = 1.0
    }
    
    private func addNewAccount() {
        
            let account = NKAccount()
            account.id = NSUUID().UUIDString
            account.platform = selectedPlatform
            account.invest = Int(investField.text!)!
            account.rate = Double(rateField.text!)!
            account.timeSpan = Int(timeSpanField.text!)!
            account.created = datePicker.date
//            account.invest = 10000 * randomInRange(1...10)
//            account.rate = Double(randomInRange(12...24)) / Double(100)
//            account.timeSpan = randomInRange(1...10)
//            account.created = datePicker.date
//            account.desc = "good\(randomInRange(1...10))"
            //            var x = timeSpanField.text!
            //            let range = x.endIndex.advancedBy(-2)..<x.endIndex
            //            account.timeSpan = Int(x.removeRange(range))
            
            
            account.timeType = TimeType.MONTH.rawValue
            account.repayType = selectedRepayType
        
            
        NKLibraryAPI.sharedInstance.saveAccount(account)
           
    }
    
    private func updateAccount() {
        
    }
    
    // MARK: Tableview delegate
  
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        switch indexPath.row {
        case 1:
            selectInvestCell()
        case 2:
            selectRateCell()
        case 3:
           selectTimeSpanCell()
        case 4:
            selectDateCell()
        case 5:
            selectRepayTypeCell()
        case 6:
            selectDescCell()
        default:
            break

        }
    }
    
}

extension NKComposeController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(textField: UITextField) {
        if textField == repayTypeField {
            
            selectRepayTypeCell()
        }
    }
    
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
}


