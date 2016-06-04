//
//  NKHorizontalChartController.swift
//  NKBill
//
//  Created by nick on 16/2/20.
//  Copyright © 2016年 NickChen. All rights reserved.
//

import UIKit
import Charts

class NKBarChartController: UIViewController {

    @IBOutlet weak var tableView: NKBaseTableView!
    @IBOutlet weak var chartView: BarChartView!

    private var selectedIndex = 2
    private var xyValues = NKLibraryAPI.sharedInstance.getInterestAndItem(before: 2, after: 6)
    var yVals: [BarChartDataEntry] = []
    var xVals:[String] = []
    var titles: [String] = []
    
    let reuseIdentifier = "schedule"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "报表分析"
        
        configureCharts()
        // 为饼状图配置数据
        setData()
        
        tableView.registerNib(UINib(nibName: "NKScheduleCell", bundle: nil), forCellReuseIdentifier: reuseIndentifier)
        self.tableView.rowHeight = 64
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        chartView.highlightValue(xIndex: selectedIndex, dataSetIndex: 0, callDelegate: true)
    }
    
    private func configureCharts() {
        
        chartView.delegate = self
        chartView.backgroundColor = Constant.Color.BGColor
        chartView.pinchZoomEnabled = true
        chartView.descriptionText = ""
        chartView.xAxis.labelPosition = .Bottom
        chartView.xAxis.labelFont = UIFont.systemFontOfSize(8.0)
        chartView.rightAxis.enabled = false
        chartView.xAxis.drawGridLinesEnabled = false
        
        chartView.legend.horizontalAlignment = .Left
        chartView.legend.verticalAlignment = .Top
        chartView.legend.form = .Square;
        chartView.legend.formSize = 8.0;
        chartView.legend.font =  UIFont(name: "HelveticaNeue-Light", size: 11.0)!
        chartView.legend.xEntrySpace = 4.0;
       
        chartView.animate(yAxisDuration: 1.5)
    }

    private func setData() {
        
        let count = xyValues.count
        
        for i in 0..<count {
            let t = xyValues[i]
            if t.date.month == 1 {
                xVals += ["\(t.date.year)年"]
            }else {
                xVals += ["\(t.date.month)月"]
            }
            titles += ["\(t.date.year)年\(t.date.month)月回款项目"]
            yVals += [BarChartDataEntry(value: t.sum, xIndex: i)]
        }
        
        let set1 = BarChartDataSet(yVals: yVals, label: "每月利息")
        set1.barSpace = 0.35
        set1.setColor(UIColor.flatGreenColor())
        set1.valueFont = UIFont.systemFontOfSize(10.0)
        chartView.data = BarChartData(xVals: xVals, dataSet: set1 )
        
    }
    
}

extension NKBarChartController: ChartViewDelegate {
    
    func chartValueSelected(chartView: ChartViewBase, entry: ChartDataEntry, dataSetIndex: Int, highlight: ChartHighlight) {
        
        selectedIndex = entry.xIndex
        tableView.reloadSections(NSIndexSet(index: 0), withRowAnimation: .Right)
        
    }
    
    func chartValueNothingSelected(chartView: ChartViewBase) {
        selectedIndex = 2
        tableView.reloadSections(NSIndexSet(index: 0), withRowAnimation: .Right)

    }
}

extension NKBarChartController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if selectedIndex >= 0 {
            return xyValues[selectedIndex].items.count
        }
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier(reuseIndentifier) as! NKScheduleCell
        if selectedIndex >= 0 {
            cell.item = xyValues[selectedIndex].items[indexPath.row]
        }
       return cell
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if selectedIndex >= 0 {
            return titles[selectedIndex]
        }
        return ""
    }
    
}

extension NKBarChartController : UITableViewDelegate {
    func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.font = UIFont.systemFontOfSize(12)
        header.textLabel?.textColor = UIColor.redColor()
    }
}
