//
//  BrokrnLineAdapter.swift
//  StatisticsView
//
//  Created by 国投 on 2018/10/12.
//  Copyright © 2018 FlyKite. All rights reserved.
//

import Foundation

protocol BrokenLineAdapter {

    typealias xdata = NSNumber

    typealias ydata = NSNumber

  
    /// x轴区间 比如 2018 2019 2020
    var xsections:[NSNumber] { get }
    /// y轴区间 代表数据
    var ysections:[NSNumber] { get }
    /// 数据
    var datas:[(xdata,ydata)] { get }


}
