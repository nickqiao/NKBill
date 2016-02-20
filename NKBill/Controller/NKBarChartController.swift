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

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var chartView: BarChartView!
    
    private lazy var lastYear = (
        NKLibraryAPI.sharedInstance.getLastYearMonthInterest(),
        NKLibraryAPI.sharedInstance.getLastYearMonthItems()
    )
    private lazy var  thisYear = (
        NKLibraryAPI.sharedInstance.getThisYearMonthInterest(),
        NKLibraryAPI.sharedInstance.getThisYearMonthItems()
    )
    private lazy var nextYear = (
        NKLibraryAPI.sharedInstance.getNextYearMonthInterest(),
        NKLibraryAPI.sharedInstance.getNextYearMonthInterest()
    )
    
    var selectedItems: [NKItem] = []
    
    let reuseIdentifier = "schedule"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        navigationItem.title = "每月利息"
        // Do any additional setup after loading the view.
        
        tableView.registerNib(UINib(nibName: "NKScheduleCell", bundle: nil), forCellReuseIdentifier: reuseIdentifier)
        configureCharts()
        
        
    }

    private func configureCharts() {
        chartView.delegate = self
        chartView.descriptionText = "单位:元"
        
        
        chartView.xAxis.labelPosition = .Bottom
        
        chartView.rightAxis.enabled = false
        
        
        chartView.legend.position = .AboveChartLeft
        chartView.legend.form = .Square;
        chartView.legend.formSize = 8.0;
//        chartView.legend.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:11.f];
        chartView.legend.xEntrySpace = 4.0;
        
        chartView.animate(yAxisDuration: 2.0)
        
        let xVals = (1...12).map({"\($0)月"})
        
        var yVals: [BarChartDataEntry] = []
        
        (1...thisYear.0.count).forEach({yVals.append(BarChartDataEntry(value:thisYear.0[$0 - 1], xIndex: $0 - 1))})
        
        let set1 = BarChartDataSet(yVals: yVals, label: "?")
        set1.barSpace = 0.35
        set1.setColor(UIColor.flatGreenColor())
        set1.valueFont = UIFont.systemFontOfSize(10.0)
        chartView.data = BarChartData(xVals: xVals, dataSet: set1 )
        
    }

}

extension NKBarChartController: ChartViewDelegate {
    func chartValueSelected(chartView: ChartViewBase, entry: ChartDataEntry, dataSetIndex: Int, highlight: ChartHighlight) {
        
    }
}

extension NKBarChartController :UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectedItems.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(reuseIdentifier) as! NKScheduleCell
        cell.item = selectedItems[indexPath.row]
        return cell
    }
    
}

extension NKBarChartController: UITableViewDelegate {
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
}
