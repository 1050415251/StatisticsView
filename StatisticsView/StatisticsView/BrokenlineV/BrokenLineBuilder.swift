//
//  BrokenLineBuilder.swift
//  StatisticsView
//
//  Created by 国投 on 2018/10/12.
//  Copyright © 2018 FlyKite. All rights reserved.
//

import Foundation
import UIKit

/// 折线图定制
class BrokenLineBuilder: NSObject {

    var frame: CGRect!
    var xdistance: CGFloat? ///   - xdistance: x轴间距
    var ydistance: CGFloat? ///   - ydistance: y轴间距
    var lineWidth: CGFloat? ///   - lineWidth: 线条宽度
    var xWidth: CGFloat? ///   - xWidth: x轴宽度
    var yWidth: CGFloat? ///   - yWidth: y轴宽度

    var lineColor: Any? ///   - linecolor: 线条颜色Any类型 可传数组和单个颜色，如果请保持与数据长度相同
    var xbgColor: CGColor? ///   - xbgcolor: x轴背景颜色
    var xTextColor: CGColor? ///   - xTextColor: x轴字体颜色
    var xUnitTextColor: CGColor? ///   - xUnitTextColor: x轴单位字体颜色
    var ybgColor: CGColor? ///   - ybgcolor: y轴背景颜色
    var yTextColor: CGColor? ///   - yTextColor: x轴字体颜色
    var yUnitTextColor: CGColor? ///   - yUnitTextColor: x轴单位字体颜色

    var originPoint: CGPoint? /// 原点坐标


    var xunit: String? /// x轴单位 比如 月份 年份
    var yunit: String? /// y轴单位



    var adapter: BrokenLineAdapter! /// 适配器

    /// 设置必须折线图相关属性
    ///
    /// - Parameters:
    ///   - xdistance: x轴间距
    ///   - ydistance: y轴间距
    ///   - linecolor: 线条颜色Any类型 可传数组和单个颜色，如果请保持与数据长度相同否则多余的按最后一个颜色处理避免崩溃
    ///   - lineWidth: 线条宽度
    func setNormalPropretry(xdistance: CGFloat,ydistance:CGFloat,lineColor:Any,lineWidth: CGFloat) {
        self.xdistance = xdistance
        self.ydistance = ydistance
        self.lineColor = lineColor
        self.lineWidth = lineWidth
    }


    /// 设置原点坐标
    ///
    /// - Parameter point: 原点坐标
    func setOriginPoint(point:CGPoint) {
        self.originPoint = point
    }

    /// 设置非必须折线图属性
    ///
    /// - Parameters:
    ///   - xWidth: x轴宽度
    ///   - yWidth: y轴宽度
    ///   - xbgcolor: x轴背景颜色
    ///   - ybgcolor: y轴背景颜色
    func setUnNormalPropretry(xWidth:CGFloat,yWidth: CGFloat,xbgcolor: CGColor,xTextColor: CGColor,ybgcolor: CGColor?,yTextColor: CGColor) {
        self.xWidth = xWidth
        self.yWidth = yWidth

        self.xbgColor = xbgcolor
        self.xTextColor = xTextColor

        self.ybgColor = ybgcolor
        self.yTextColor = yTextColor

        self.xUnitTextColor = xTextColor
        self.yUnitTextColor = yTextColor
    }

    func setUnitTextColor(xUnitTextColor: CGColor,yUnitTextColor: CGColor) {
        self.xUnitTextColor = xUnitTextColor
        self.yUnitTextColor = yUnitTextColor
    }


    func builderNewBrokenlineV() -> BrokenLineView {
        let brokenlineV = BrokenLineView.init(frame: frame)
        brokenlineV.builder = self
        brokenlineV.adapter =  adapter
        brokenlineV.initView()
        return brokenlineV
    }


}
