//
//  NKWaitingController.swift
//  NKBill
//
//  Created by nick on 16/6/3.
//  Copyright © 2016年 NickChen. All rights reserved.
//

import UIKit
import RealmSwift
class NKWaitingController: NKBaseViewController {

    static func WaitingController() -> NKWaitingController {
        let sb = UIStoryboard(name:String.className(NKWaitingController) , bundle: nil)
        return sb.instantiateViewControllerWithIdentifier("ff") as! NKWaitingController
    }
    
    // Calendar
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var menuView: CVCalendarMenuView!
    @IBOutlet weak var calendarView: CVCalendarView!
    @IBOutlet weak var tableView: UITableView!
    
    var selectedItem: NKItem!
    private var selectedDate = NSDate()
    private var state = State.Waiting
    private var allWaitingItems = NKLibraryAPI.sharedInstance.getWaitingItems()
    private var items : Results<NKItem> {
            return  NKLibraryAPI.sharedInstance.getWaitingItemsByDate(selectedDate)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.tableView.registerCellNib(NKScheduleCell)
        tableView.rowHeight = 64
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = Constant.Color.BGColor
        NKLibraryAPI.sharedInstance.updateUIWith(String(self)) { [unowned self]() -> Void in
            self.tableView.reloadData()
            self.calendarView.contentController.refreshPresentedMonth()
        }
        
        self.setupMonthLabel()
        
    }
    
    deinit {
        NKLibraryAPI.sharedInstance.removeClosure(String(self))
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        menuView.commitMenuViewUpdate()
        calendarView.commitCalendarViewUpdate()
    }
    
    private func setupMonthLabel() {
        monthLabel.text = CVDate(date: NSDate()).globalDescription
        monthLabel.textColor = UIColor.flatBlackColor()
        monthLabel.font = UIFont.systemFontOfSize(14.0)
    }
    
}

extension NKWaitingController: UITableViewDataSource {
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count ?? 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(NKScheduleCell.identifier) as! NKScheduleCell
        cell.item = items[indexPath.row]
        return cell
    }
    
}

extension NKWaitingController: UITableViewDelegate {
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        selectedItem = items[indexPath.row]
        
        showActionSheet()
    }
    
    func showActionSheet() {
        
        let sheet = UIAlertController(title: "处理该笔还款状态", message: nil, preferredStyle: .ActionSheet)
        
        let watingHandler = UIAlertAction(title: "未还", style: .Default){(_) -> Void in
            
            NKLibraryAPI.sharedInstance.changeItemState(self.selectedItem, toState: .Waiting)
        }
        
        let passedHandler = UIAlertAction(title: "已还", style: .Default){(_) -> Void in
            
            NKLibraryAPI.sharedInstance.changeItemState(self.selectedItem, toState: .Passed)
        }
        
        let overDueHandler = UIAlertAction(title: "逾期", style: .Default){(_) -> Void in
            
            NKLibraryAPI.sharedInstance.changeItemState(self.selectedItem, toState: .Overdue)
        }
        
        let cancelAction = UIAlertAction(title: "取消", style: .Cancel, handler: nil)
        
        
        switch selectedItem.state {
            
        case State.Waiting.rawValue:
            if selectedItem.repayDate.timeIntervalSince1970 < NSDate().timeIntervalSince1970 {
                sheet.addAction(passedHandler)
                sheet.addAction(overDueHandler)
                sheet.addAction(cancelAction)
                presentViewController(sheet, animated: true, completion: nil)
            }else {
                sheet.addAction(passedHandler)
                sheet.addAction(cancelAction)
                presentViewController(sheet, animated: true, completion: nil)
                
            }
        case State.Passed.rawValue:
            sheet.addAction(watingHandler)
            sheet.addAction(overDueHandler)
            sheet.addAction(cancelAction)
            presentViewController(sheet, animated: true, completion: nil)
        case State.Overdue.rawValue:
            sheet.addAction(watingHandler)
            sheet.addAction(passedHandler)
            sheet.addAction(cancelAction)
            presentViewController(sheet, animated: true, completion: nil)
        default:
            break
            
        }
        
    }
    
}

extension NKWaitingController : CVCalendarViewDelegate {
    
    func presentationMode() -> CalendarMode {
        return .MonthView
    }
  
    func shouldShowWeekdaysOut() -> Bool {
        return false
    }
    
    func shouldAutoSelectDayOnMonthChange() -> Bool {
        return true
    }
    
    func didSelectDayView(dayView: DayView, animationDidFinish: Bool) {
        selectedDate = dayView.date.convertedDate()!
        self.tableView.reloadData()
    }
    
    func presentedDateUpdated(date: Date) {
        if monthLabel.text != date.globalDescription {
            monthLabel.text = date.globalDescription
        }
    }
    
    func shouldScrollOnOutDayViewSelection() -> Bool {
        return false
    }
    
    func dotMarker(shouldShowOnDayView dayView: CVCalendarDayView) -> Bool {
        
        var show = false
        
        allWaitingItems.forEach { (item) in
            if dayView.date != nil{
                if dayView.date.convertedDate()!.isSameDay(item.repayDate) {
                    show = true
                }
                
            }
        }
        
        return show
        
    }
    
    func dotMarker(colorOnDayView dayView: CVCalendarDayView) -> [UIColor] {
        return [UIColor.flatRedColor()]
    }
    
    func dotMarker(shouldMoveOnHighlightingOnDayView dayView: CVCalendarDayView) -> Bool {
        return true
    }
    
    func dotMarker(sizeOnDayView dayView: DayView) -> CGFloat {
        return 15
    }
    
}



extension NKWaitingController : CVCalendarMenuViewDelegate {
    //  in the Gregorian calendar, Sunday is represented by 1.
    func firstWeekday() -> Weekday {
        return .Monday
    }
}
