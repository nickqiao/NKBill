//
//  NKPieChartController.swift
//  NKBill
//
//  Created by nickchen on 16/2/14.
//  Copyright © 2016年 NickChen. All rights reserved.
//

import UIKit
import Charts

class NKPieChartController: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
  
    @IBOutlet weak var pieChart: PieChartView!
    
    private lazy var sliceColors = [UIColor.flatGreenColor(),UIColor.flatRedColor(),UIColor.flatSkyBlueColor(),UIColor.flatYellowColor(),UIColor.flatBrownColor()]
    
    private lazy var platforms = NKLibraryAPI.sharedInstance.getInvestedPlatforms()
    
    let reuseIdentifier = "record"
    
    private var selectedPlatform: NKPlatform?
    private var selectedAccount: NKAccount?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.backgroundColor = NKBackGroundColor()
        tableView.registerNib(UINib(nibName: "NKAccountCell", bundle: nil), forCellReuseIdentifier: reuseIdentifier)
        tableView.rowHeight = 64
        // Do any additional setup after loading the view.
        configurePieChart()
        setData()
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    func configurePieChart() {
        pieChart.delegate = self
        
        pieChart.drawSliceTextEnabled = false
        
        pieChart.usePercentValuesEnabled = true
        pieChart.holeTransparent = true
        pieChart.holeRadiusPercent = 0.58
        pieChart.transparentCircleRadiusPercent = 0.61
        pieChart.descriptionText = ""
        
        pieChart.setExtraOffsets(left: 5.0, top: 10.0, right: 5.0, bottom: 5.0)
        pieChart.drawCenterTextEnabled = true
        
        pieChart.centerText = "投资总额\n\(NKLibraryAPI.sharedInstance.getSumInvest())"
        
        pieChart.drawHoleEnabled = true
        pieChart.rotationAngle = 0.0;
        pieChart.rotationEnabled = true
        pieChart.highlightPerTapEnabled = true
    
        
        let l = pieChart.legend;
        l.position = .LeftOfChart;
        l.xEntrySpace = 7.0;
        l.yEntrySpace = 0.0;
        l.yOffset = 0.0;
        
        pieChart.animate(xAxisDuration: 1.4, easingOption:.EaseOutBack)
        
    }
    
    private func setData() {
        let count = platforms.count
        var yValues:[BarChartDataEntry] = []
        var xValues:[String] = []
        var colors: [UIColor] = []
        for i in 0..<count {
            yValues += [BarChartDataEntry(value: platforms[i].ratio, xIndex:i )]
            xValues += ["\(platforms[i].name)"]
            colors += [sliceColors[i % count]]
        }
        
        let dataSet = PieChartDataSet(yVals: yValues, label: "平台名称")
        dataSet.sliceSpace = 2.0
        dataSet.colors = colors
        
        let data = PieChartData(xVals: xValues, dataSet: dataSet)
        let pFormatter = NSNumberFormatter()
        pFormatter.numberStyle = .PercentStyle;
        pFormatter.maximumFractionDigits = 1
        pFormatter.multiplier = 1.0
        pFormatter.percentSymbol = " %";
        data.setValueFormatter(pFormatter)
        data.setValueFont(UIFont(name: "HelveticaNeue-Light", size: 11.0))
        data.setValueTextColor(UIColor.whiteColor())
        pieChart.data = data
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "pieToDetail" {
            let detailVc = segue.destinationViewController as! NKDetailController
            detailVc.account = selectedAccount
        }
    }
    
}

extension NKPieChartController: ChartViewDelegate {
    func chartValueSelected(chartView: ChartViewBase, entry: ChartDataEntry, dataSetIndex: Int, highlight: ChartHighlight) {
        
        selectedPlatform = platforms[entry.xIndex]
        pieChart.centerText = "\(selectedPlatform!.name)\n\(selectedPlatform!.sum)"
        tableView.reloadData()
    }
    
    func chartValueNothingSelected(chartView: ChartViewBase) {
        selectedPlatform = nil
        pieChart.centerText = "投资总额\n\(NKLibraryAPI.sharedInstance.getSumInvest())"
        tableView.reloadData()
    }
    
}

extension NKPieChartController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let x = selectedPlatform else {
           return 0
        }
        return x.accounts.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier(reuseIdentifier) as! NKAccountCell
        let account = selectedPlatform?.accounts[indexPath.row]
        configureCell(cell, account: account!)
        
        return cell

    }
    
    private func configureCell(cell:NKAccountCell, account:NKAccount) {
        
        cell.platNameLabel.text = account.record_name()
        cell.investLabel.text = account.record_invest()
        cell.dateLabel.text = account.record_date()
        cell.rateLabel.text = account.record_rate()
        
        cell.circleProgressView.value = CGFloat(account.progress())
    }

    
}

extension NKPieChartController: UITableViewDelegate {
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        selectedAccount = selectedPlatform?.accounts[indexPath.row]
        performSegueWithIdentifier("pieToDetail", sender: nil)
    }
}
