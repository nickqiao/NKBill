//
//  NKAnalyzeController.swift
//  NKBill
//
//  Created by nick on 16/2/21.
//  Copyright © 2016年 NickChen. All rights reserved.
//

import UIKit
import Charts

class NKAnalyzeController: UIViewController {

    @IBOutlet weak var pieChart: PieChartView!
    
    private var sliceColors = [
        
        UIColor.flatYellowColor()!,
        UIColor.flatGreenColor()!,
        UIColor.flatSkyBlueColor()!,
        UIColor.flatRedColor()!,
        UIColor.flatOrangeColor()!
        
    ]

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = "投资分析"
        configurePieChart()
        setData()
    }

    func configurePieChart() {
        
        pieChart.drawSliceTextEnabled = false
        
        pieChart.usePercentValuesEnabled = true
        //pieChart.holeTransparent = true
        pieChart.holeRadiusPercent = 0.0
        pieChart.transparentCircleRadiusPercent = 0.0
        pieChart.descriptionText = ""
        
        pieChart.setExtraOffsets(left: 5.0, top: 10.0, right: 5.0, bottom: 5.0)
        pieChart.drawCenterTextEnabled = true
        
        //pieChart.centerText = "投资总额\n\(NKLibraryAPI.sharedInstance.getSumInvest())"
        
        pieChart.drawHoleEnabled = true
        pieChart.rotationAngle = 0.0;
        pieChart.rotationEnabled = true
        pieChart.highlightPerTapEnabled = false
        
        
        let l = pieChart.legend;
        l.position = .LeftOfChart;
        l.xEntrySpace = 7.0;
        l.yEntrySpace = 0.0;
        l.yOffset = 0.0;
        
        pieChart.animate(xAxisDuration: 1.4, easingOption:.EaseOutBack)
        
    }

    private func setData() {
        let sum = Double( NKLibraryAPI.sharedInstance.getSumInvest())
        var yValues: [BarChartDataEntry] = []
        var xValues: [String] = []
        let y0 = NKLibraryAPI.sharedInstance.getAccountsByRate(from: 0.0, to: 0.05) / sum
        let y1 = NKLibraryAPI.sharedInstance.getAccountsByRate(from: 0.05, to: 0.12) / sum
        let y2 = NKLibraryAPI.sharedInstance.getAccountsByRate(from: 0.12, to: 0.18) / sum
        let y3 = NKLibraryAPI.sharedInstance.getAccountsByRate(from: 0.18, to: 0.36) / sum
        let y4 = NKLibraryAPI.sharedInstance.getAccountsByRate(from: 0.36, to: 1.0) / sum
        
        if y0 > 0 {
            yValues += [BarChartDataEntry(value: y0, xIndex:0 )]
            xValues += ["0~5%(含5%)"]
        }
        
        if y1 > 0 {
            yValues += [BarChartDataEntry(value: y1, xIndex:0 )]
            xValues += ["5%~12%(含12%)"]
        }
        
        if y2 > 0 {
            yValues += [BarChartDataEntry(value: y2, xIndex:0 )]
            xValues += ["12%~18%(含18%)"]
        }
        if y3 > 0 {
            yValues += [BarChartDataEntry(value: y3, xIndex:0 )]
            xValues += ["18%~36%(含36%)"]
        }
        if y4 > 0 {
            yValues += [BarChartDataEntry(value: y4, xIndex:0 )]
            xValues += [">36%"]
        }
    
        
        let dataSet = PieChartDataSet(yVals: yValues, label: "年化利率范围")
        dataSet.sliceSpace = 0.0
        dataSet.colors = sliceColors
        
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

    

}
