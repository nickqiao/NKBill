//
//  NKPieChartController.swift
//  NKBill
//
//  Created by nickchen on 16/2/14.
//  Copyright © 2016年 NickChen. All rights reserved.
//

import UIKit

class NKPieChartController: UIViewController {
    
    @IBOutlet weak var centerLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var pieChart: XYPieChart!
    
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
        pieChart.delegate = self
        pieChart.dataSource = self
        pieChart.animationSpeed = 1.0
        pieChart.startPieAngle = CGFloat(M_1_PI)
        pieChart.showLabel = true
        pieChart.showPercentage = true
        centerLabel.layer.cornerRadius = 25
        centerLabel.layer.masksToBounds = true
        centerLabel.text = "投资总额\n\(NKLibraryAPI.sharedInstance.getSumInvest())"
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        pieChart.reloadData()
    }
    
    @IBAction func disimiss(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "pieToDetail" {
            let detailVc = segue.destinationViewController as! NKDetailController
            detailVc.account = selectedAccount
        }
    }
    
}

extension NKPieChartController: XYPieChartDataSource {
    func numberOfSlicesInPieChart(pieChart: XYPieChart!) -> UInt {
        return UInt(platforms.count)
    }
    
    func pieChart(pieChart: XYPieChart!, valueForSliceAtIndex index: UInt) -> CGFloat {
        let p = platforms[Int(index)]
        return  CGFloat(p.ratio)
    }
    
    func pieChart(pieChart: XYPieChart!, textForSliceAtIndex index: UInt) -> String! {
        return "sd"
    }
    
    func pieChart(pieChart: XYPieChart!, colorForSliceAtIndex index: UInt) -> UIColor! {
        return sliceColors[ Int(index) % sliceColors.count]
    }
    
}


extension NKPieChartController: XYPieChartDelegate {
    
    func pieChart(pieChart: XYPieChart!, didSelectSliceAtIndex index: UInt) {
        selectedPlatform = platforms[Int(index)]
        centerLabel.text = "\(selectedPlatform!.name)\n\(selectedPlatform!.sum)"
        tableView.reloadData()
    }
    
    func pieChart(pieChart: XYPieChart!, willDeselectSliceAtIndex index: UInt) {
        centerLabel.text = "投资总额\n\(NKLibraryAPI.sharedInstance.getSumInvest())"
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
