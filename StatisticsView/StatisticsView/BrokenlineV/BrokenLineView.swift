//
//  BrokenLineView.swift
//  StatisticsView
//
//  Created by 国投 on 2018/10/12.
//  Copyright © 2018 FlyKite. All rights reserved.
//

import Foundation
import UIKit

class BrokenLineView: UIView {

    var adapter: BrokenLineAdapter!

    var builder: BrokenLineBuilder!

    private var xLayer: CALayer!
    private var yLayer: CALayer!
    private var scrollLayer: CAScrollLayer!
    private var xScrollLayer: CAScrollLayer!
    private var yScrollLayer: CAScrollLayer!
    private var dataLayer: CAShapeLayer!

    private let default_color = UIColor.black
    private let default_xdistance:CGFloat = 25
    private let default_ydistance:CGFloat = 25

    // MARK: -初始化折线图控件
    class func newInstanceBrokenlineV(_ callback:((BrokenLineBuilder)->Void)?) -> BrokenLineView {
        let builder = BrokenLineBuilder()
        callback?(builder)
        return builder.builderNewBrokenlineV()
    }

    

    override init(frame: CGRect) {
        super.init(frame: frame)

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // TODO: -初始化view
    func initView() {
        

        drawX()
        drawY()
        addGesture()
    }

    private func addGesture() {
        self.isUserInteractionEnabled = true
        let pan = UIPanGestureRecognizer.init(target: self, action: #selector(panGesture(sender:)))
        self.addGestureRecognizer(pan)
    }

    private func drawX() {

        let point = builder.originPoint ?? CGPoint.init(x: 30, y: self.frame.height - 30)
        let xframe =  CGRect.init(origin:point ,size: CGSize.init(width: self.frame.width - point.x * 2, height: builder.xWidth ?? 0.5))

        xLayer = CALayer()
        xLayer.backgroundColor = builder.xbgColor ?? default_color.cgColor
        xLayer.frame = xframe
        self.layer.addSublayer(xLayer)

        let arrowLayer = CAShapeLayer()
        arrowLayer.backgroundColor = builder.xbgColor ?? default_color.cgColor

        let path = UIBezierPath()
        path.lineWidth = 1
        path.move(to: CGPoint.init(x: xframe.maxX + 5, y: xframe.origin.y))
        path.addLine(to: CGPoint.init(x: xframe.maxX, y: xframe.origin.y - 2.5))
        path.addLine(to: CGPoint.init(x: xframe.maxX, y: xframe.origin.y + 2.5))
        path.close()

        arrowLayer.path = path.cgPath
        arrowLayer.strokeColor = builder.xbgColor ?? default_color.cgColor
        self.layer.addSublayer(arrowLayer)

        let xunit = builder?.xunit ?? ""
        let xTextLayer = CATextLayer()
        xTextLayer.string = xunit
        xTextLayer.fontSize = 12
        xTextLayer.contentsScale = UIScreen.main.scale
        xTextLayer.bounds = CGRect.init(x: 0, y: 0, width: 20, height: 15)
        xTextLayer.position = CGPoint.init(x: xframe.maxX + 20, y: xframe.midY)
        xTextLayer.foregroundColor = builder.xUnitTextColor ?? (builder.xbgColor ?? UIColor.black.cgColor)
        self.layer.addSublayer(xTextLayer)
    }

    private func drawY() {
        let point = builder.originPoint ?? CGPoint.init(x: 30, y: self.frame.height - 30)
        let size = CGSize.init(width:builder.yWidth ?? 1 , height: self.frame.height - (self.frame.height - point.y) * 2)
        let realpoint = CGPoint.init(x: point.x, y: point.y - size.height)
        let yframe =  CGRect.init(origin:realpoint ,size: size)

        yLayer = CALayer()
        yLayer.backgroundColor = builder.ybgColor ?? default_color.cgColor
        yLayer.frame = yframe
        self.layer.addSublayer(yLayer)

        let arrowLayer = CAShapeLayer()
        arrowLayer.backgroundColor = builder.ybgColor ?? default_color.cgColor

        let path = UIBezierPath()
        path.lineWidth = 1
        path.move(to: CGPoint.init(x: yframe.origin.x, y: yframe.minY - 5))
        path.addLine(to: CGPoint.init(x: yframe.origin.x - 2.5, y: yframe.minY))
        path.addLine(to: CGPoint.init(x: yframe.origin.x + 2.5, y: yframe.minY))
        path.close()

        arrowLayer.path = path.cgPath
        arrowLayer.strokeColor = builder.ybgColor ?? default_color.cgColor

        self.layer.addSublayer(arrowLayer)

        let yunit = builder?.yunit ?? ""
        let yTextLayer = CATextLayer()
        yTextLayer.string = yunit
        yTextLayer.fontSize = 12
        yTextLayer.frame = CGRect.init(x: yframe.maxX + 10, y: yframe.minY - 10, width: 20, height: 15)
        yTextLayer.foregroundColor = builder.xUnitTextColor ?? (builder.xbgColor ?? UIColor.black.cgColor)
        yTextLayer.contentsScale = UIScreen.main.scale
        self.layer.addSublayer(yTextLayer)
    }

    private func drawMainLayer() {
        let point = builder.originPoint ?? CGPoint.init(x: 30, y: self.frame.height - 30)
        let size = CGSize.init(width:builder.yWidth ?? 1 , height: self.frame.height - (self.frame.height - point.y) * 2)
        let realpoint = CGPoint.init(x: point.x, y: point.y - size.height)

        let xframe =  CGRect.init(origin:point ,size: CGSize.init(width: self.frame.width - point.x * 2, height: builder.xWidth ?? 1))
        let yframe =  CGRect.init(origin:realpoint ,size: size)

        let scrolllayer = CAScrollLayer()
        scrolllayer.scrollMode = .both
        scrolllayer.frame = CGRect.init(x: yframe.maxX, y: yframe.minY + 30, width: xframe.width - 30, height: yframe.size.height - 30)
        scrolllayer.backgroundColor = UIColor.red.cgColor
        self.layer.addSublayer(scrolllayer)
        self.scrollLayer = scrolllayer
    }

    // TODO: 绘制x数据
    private func drawXUnitData() {
        let point = builder.originPoint ?? CGPoint.init(x: 30, y: self.frame.height - 30)
        let size = CGSize.init(width:builder.yWidth ?? 1 , height: self.frame.height - (self.frame.height - point.y) * 2)
        let realpoint = CGPoint.init(x: point.x, y: point.y - size.height)

       // let xframe =  CGRect.init(origin:point ,size: CGSize.init(width: self.frame.width - point.x * 2, height: builder.xWidth ?? 1))
        let yframe =  CGRect.init(origin:realpoint ,size: size)


        xScrollLayer = CAScrollLayer()
        xScrollLayer.scrollMode = .horizontally
        xScrollLayer.frame = CGRect.init(x: yframe.maxX, y: scrollLayer.frame.maxY - 5, width: scrollLayer.frame.width, height:30)
        //xScrollLayer.backgroundColor = UIColor.green.cgColor
        self.layer.addSublayer(xScrollLayer)

        //TODO: 添加x轴
        let xArr = adapter.xsections
        for (index,xdata) in xArr.enumerated() {
            let midX = (builder.xdistance ?? default_xdistance) * CGFloat(index + 1)
            let linelayer = CALayer()
            linelayer.frame = CGRect.init(x: midX, y: 0, width: 1, height: 5)
            linelayer.backgroundColor = builder.xbgColor ?? default_color.cgColor
            xScrollLayer.addSublayer(linelayer)

            let xTextLayer = CATextLayer()
            xTextLayer.string = "\(xdata)"
            xTextLayer.fontSize = 12
            xTextLayer.alignmentMode = .center
            xTextLayer.contentsScale = UIScreen.main.scale
            xTextLayer.bounds = CGRect.init(x: 0, y: 0, width: 15, height: 15)
            xTextLayer.position = CGPoint.init(x: midX , y: 15)
            xTextLayer.foregroundColor = builder.xUnitTextColor ?? (builder.xbgColor ?? UIColor.black.cgColor)
            xScrollLayer.addSublayer(xTextLayer)
        }


    }

     // TODO: 绘制Y轴数据
    private func drawYUnitData() {

        let point = builder.originPoint ?? CGPoint.init(x: 30, y: self.frame.height - 30)
        let size = CGSize.init(width:builder.yWidth ?? 1 , height: self.frame.height - (self.frame.height - point.y) * 2)
        let realpoint = CGPoint.init(x: point.x, y: point.y - size.height)

        let xframe =  CGRect.init(origin:point ,size: CGSize.init(width: self.frame.width - point.x * 2, height: builder.xWidth ?? 1))
        let yframe =  CGRect.init(origin:realpoint ,size: size)

        yScrollLayer = CAScrollLayer()
        yScrollLayer.scrollMode = .vertically
        yScrollLayer.frame = CGRect.init(x: 0, y: yframe.minY + 30, width: yframe.maxX + 5, height: yframe.size.height - 30)
        self.layer.addSublayer(yScrollLayer)

        //TODO: 添加x轴
        let yArr = adapter.ysections
        for (index,ydata) in yArr.enumerated() {
            let midY = (builder.ydistance ?? default_ydistance) * CGFloat(index + 1)
            let linelayer = CALayer()
            linelayer.frame = CGRect.init(x: xframe.minX, y: yScrollLayer.frame.height - midY, width: 5, height: 1)
            linelayer.backgroundColor = builder.xbgColor ?? default_color.cgColor
            yScrollLayer.addSublayer(linelayer)

            let yTextLayer = CATextLayer()
            yTextLayer.string = "\(ydata)"
            yTextLayer.fontSize = 12
            yTextLayer.bounds = CGRect.init(x: 0, y: 0, width: 20, height: 15)
            yTextLayer.position = CGPoint.init(x: 15, y: yScrollLayer.frame.height - midY)
            yTextLayer.foregroundColor = builder.xUnitTextColor ?? (builder.xbgColor ?? UIColor.black.cgColor)
            yTextLayer.alignmentMode = .center
            yTextLayer.contentsScale = UIScreen.main.scale
            yScrollLayer.addSublayer(yTextLayer)
        }
    }

    private func drawData() {

        let dataLayer = CAShapeLayer()

        let path = UIBezierPath()
        path.move(to: CGPoint.init(x: 0, y: scrollLayer.frame.height))
        for (index,data) in adapter.datas.enumerated() {
            let x = CGFloat(builder.xdistance ?? default_xdistance) * CGFloat(index + 1)
            let y = yScrollLayer.frame.height - (((builder.ydistance ?? default_ydistance) * CGFloat(adapter.ysections.count)) * (CGFloat(data.1.doubleValue/adapter.ysections[adapter.ysections.count - 1].doubleValue)))
            path.addLine(to: CGPoint.init(x: x, y: CGFloat(y)))
        }

        dataLayer.path = path.cgPath
        dataLayer.lineWidth = builder.lineWidth ?? 1
       // dataLayer.lineJoin = .round
        if let _ = builder.lineColor {

        }else {
            dataLayer.strokeColor = UIColor.black.cgColor
        }
        dataLayer.fillColor = UIColor.clear.cgColor
        path.fill()
        scrollLayer.addSublayer(dataLayer)
        self.dataLayer = dataLayer
    }

    private func drawAnimation() {
        let animation = CABasicAnimation.init(keyPath: "strokeEnd")
        animation.duration = 5.0
        animation.repeatCount = 1
        animation.isRemovedOnCompletion = false
        animation.fromValue = 0.0
        animation.toValue = 1
        self.dataLayer.add(animation, forKey: nil)
    }

    func drawBrokenline(_ animated: Bool) {
        if adapter == nil {
            fatalError("请设置适配器")
        }
        drawMainLayer()
        drawXUnitData()
        drawYUnitData()
        drawData()
        if animated {
            drawAnimation()
        }

    }

}

extension BrokenLineView {

    @objc private func panGesture(sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: self)
        var offset = scrollLayer.bounds.origin
        offset.x -= translation.x
        offset.y -= translation.y



        debugPrint(offset)
        if offset.x <= 0 {
            offset.x = 0
        }
        else if offset.x >= (builder.xdistance ?? default_xdistance) * CGFloat(adapter.xsections.count) - scrollLayer.frame.width + 10{
            offset.x = (builder.xdistance ?? default_xdistance) * CGFloat(adapter.xsections.count) - scrollLayer.frame.width + 10
        }

        if offset.y <= -((builder.ydistance ?? default_ydistance) * CGFloat(adapter.ysections.count) - yScrollLayer.frame.height) - 10 {
            offset.y = -((builder.ydistance ?? default_ydistance) * CGFloat(adapter.ysections.count) - yScrollLayer.frame.height) - 10
        }
        if offset.y >= 0  {
            offset.y = 0
        }
        //(builder.ydistance ?? default_xdistance) * CGFloat(adapter.ysections.count)
        //
        scrollLayer.scroll(to: offset)
        xScrollLayer.scroll(to: CGPoint.init(x: offset.x, y: xScrollLayer.visibleRect.origin.y))
        yScrollLayer.scroll(to: CGPoint.init(x: yScrollLayer.visibleRect.origin.x, y: offset.y))
        sender.setTranslation(CGPoint.zero, in: self)
    }




}
