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
        descTextView.text = "请输入项目备注"
        descTextView.textColor = UIColor.flatGrayColor()
        
    }
    
    private func addNewAccount() {
        
        let account = NKAccount()
        // 每笔投资id
        account.id = NSUUID().UUIDString
        // 投资平台
        account.platform = selectedPlatform
        // 投资金额
        account.invest = Int(investField.text!)!
        
        // 利率
        account.rate = Double(rateField.text!)! / Double(100)
        
        // 投资时长
        account.timeSpan = Int(timeSpanField.text!)!
        
        // 投资期限的类型(月/日)
        account.timeType = TimeType.MONTH.rawValue
        
        // 创建日期
        account.created = datePicker.date
        
        // 还款方式
        account.repayType = selectedRepayType
        
        // 描述
        account.desc = descTextView.text
        
       
        
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
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        
        if textField == investField {
            // 一开始就禁止输入0
            if string == "0" {
                return false
            }
            
            let currentCharacterCount = textField.text?.characters.count ?? 0
            if (range.length + range.location > currentCharacterCount){
                return false
            }
            let newLength = currentCharacterCount + string.characters.count - range.length
            return newLength <= 9
        }
        
        return true
    }

}

extension NKComposeController: UITextViewDelegate {
    func textViewDidBeginEditing(textView: UITextView) {
        if (textView.text == "请输入项目备注") {
            textView.text = "";
            textView.textColor = UIColor.flatBlackColor()
        }
        textView.becomeFirstResponder()
    }
    
    func textViewDidEndEditing(textView: UITextView) {
        if (textView.text == "") {
            textView.text = "请输入项目备注"
            textView.textColor = UIColor.flatGrayColor()
        }
        textView.resignFirstResponder()
    }
}

