//
//  ViewController.swift
//  StatisticsView
//
//  Created by 国投 on 2018/10/12.
//  Copyright © 2018 FlyKite. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.backgroundColor = UIColor.gray
        initView()
    }


    private func initView() {
        let brokenlineV = BrokenLineView.newInstanceBrokenlineV { (builder) in
            builder.frame = CGRect.init(x: 30, y: 80, width: 354, height: 250)
            builder.xunit = "月"
            builder.yunit = "元"
            builder.xdistance = 80
            builder.ydistance = 50
        }
        brokenlineV.adapter = self
        brokenlineV.backgroundColor = UIColor.white
        self.view.addSubview(brokenlineV)
        brokenlineV.drawBrokenline(true)


    }

}

extension ViewController: BrokenLineAdapter {


    var xsections: [NSNumber] {
        return [1,2,3,4,5,6,7,8,9,10,11,12]
    }

    var ysections: [NSNumber] {
        return [1000,2000,3000,4000,5000]
    }

    var datas: [(BrokenLineAdapter.xdata, BrokenLineAdapter.ydata)] {
        return [(1,2500),(2,1500),(3,400),(4,5000),(5,500),(6,4800),(7,1250),(8,2500),(9,2500),(10,2500),(11,2500),(12,2500)]
    }



}
