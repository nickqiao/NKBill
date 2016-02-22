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
    
    static let span = 4
    private var selectedItems: [NKItem] = []
    private var xyValues = NKLibraryAPI.sharedInstance.getInterestAndItem(beforeAndAfter: span)
    
    let reuseIdentifier = "schedule"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "报表分析"
        // Do any additional setup after loading the view.
        
        configureCharts()
        
        tableView.registerNib(UINib(nibName: "NKScheduleCell", bundle: nil), forCellReuseIdentifier: reuseIdentifier)
        
    }
    
    private func configureCharts() {
        
        chartView.delegate = self
        chartView.backgroundColor = NKBackGroundColor()
        chartView.pinchZoomEnabled = true
        chartView.descriptionText = ""
        chartView.xAxis.labelPosition = .Bottom
        chartView.xAxis.labelFont = UIFont.systemFontOfSize(8.0)
        chartView.rightAxis.enabled = false
        chartView.xAxis.drawGridLinesEnabled = false
        
        chartView.legend.position = .AboveChartLeft
        chartView.legend.form = .Square;
        chartView.legend.formSize = 8.0;
//        chartView.legend.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:11.f];
        chartView.legend.xEntrySpace = 4.0;
       
        
        chartView.animate(yAxisDuration: 2.0)
        
        let xVals = xyValues.map { (t) -> String in
            if t.date.month() == 1 {
                return "\(t.date.year())年"
            }else {
                return "\(t.date.month())月"
            }
        }
        
        var yVals: [BarChartDataEntry] = []
        
        (1...2 * NKBarChartController.span).forEach({yVals.append(BarChartDataEntry(value:xyValues[$0 - 1].sum, xIndex: $0 - 1))})
        
        let set1 = BarChartDataSet(yVals: yVals, label: "每月利息")
        set1.barSpace = 0.35
        set1.setColor(UIColor.flatGreenColor())
        set1.valueFont = UIFont.systemFontOfSize(10.0)
        chartView.data = BarChartData(xVals: xVals, dataSet: set1 )
        
    }

}

extension NKBarChartController: ChartViewDelegate {
    func chartValueSelected(chartView: ChartViewBase, entry: ChartDataEntry, dataSetIndex: Int, highlight: ChartHighlight) {
        selectedItems.removeAll()
        print(entry.xIndex)
       Array( xyValues[entry.xIndex].items).forEach({ selectedItems += [$0] })
        tableView.reloadData()
    }
    
    func chartValueNothingSelected(chartView: ChartViewBase) {
        selectedItems.removeAll()
        tableView.reloadData()
    }
}

extension NKBarChartController: UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(selectedItems.count)
        return selectedItems.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        print(indexPath)
        let cell = tableView.dequeueReusableCellWithIdentifier(reuseIndentifier) as! NKScheduleCell
        cell.item = selectedItems[indexPath.row]
        return cell

    }
}
