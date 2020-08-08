//
//  SYSliderView.swift
//  SYTexDemo
//
//  Created by bsoshy on 2020/7/7.
//  Copyright © 2020 bsy. All rights reserved.
//

import UIKit
import SnapKit

class SYSegment: NSObject {
    var percentIn : CGFloat = 0
    var percentOut : CGFloat = 0
    var segmentColor : UIColor = .purple
    var lowNumText : String?
    var heightNumText : String?
    var centerText : String?
}

class SYSliderView: UIView {
    //当前值（0～1）
    var value : CGFloat!
    //每一段起始位置在总长度的百分比
//    var segments : [CGFloat]!
    //每一段在整个timeline上的trimIn和trimOut所占的百分比
    var timeSegments : [SYSegment]!
    //是否允许滑动
    var isSlide = true
    private var isInRect : Bool!
    var backColor : UIColor = .grayCColor
    var backCornerRadius : CGFloat = 4
    var backHeight : CGFloat = 8
    
    var lowText : String?{
        didSet {
            lowLab.text = lowText
        }
    }
    var heightText : String?{
        didSet {
            heightLab.text = heightText
        }
    }

    //滑块风格
    var sliderPoint : CGPoint = CGPoint(x: 30, y: 30)
    var sliderCornerRadius : CGFloat = 15
    var sliderColor : UIColor = .white
    var sliderImage : UIImage?{
        didSet {
           self.imageView.image = sliderImage
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .yellow
        addSubview(line)
        addSubview(imageView)
        addSubview(lowLab)
        addSubview(heightLab)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        backgroundColor = .white
        addSubview(line)
        addSubview(imageView)
        addSubview(lowLab)
        addSubview(heightLab)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.line.frame = CGRect(x: 0, y: (self.frame.size.height-backHeight)/2, width: self.frame.size.width, height: backHeight)
        self.line.layer.cornerRadius = backCornerRadius
        line.backgroundColor = backColor
        lowLab.frame = CGRect(x: 0, y: (self.frame.size.height-backHeight)/2+20, width: 0, height: 12)
        lowLab.sizeToFit()
        let size = heightLab.sizeThatFits(.zero)
        heightLab.frame = CGRect(x: self.frame.size.width-size.width, y: lowLab.frame.origin.y, width: size.width, height: 12)

//        for number in self.segments {
//            let x = number*(self.frame.size.width-2*padding)
//            let view = UIView()
//            view.backgroundColor = self.backgroundColor
//            view.frame = CGRect(x: x, y: 0, width: 0, height: 8)
//            self.line.addSubview(view)
//        }

        for timeSegment in self.timeSegments {
            let x1 = timeSegment.percentIn*self.frame.size.width
            let x2 = timeSegment.percentOut*self.frame.size.width
            let view = UIView()
            view.backgroundColor = timeSegment.segmentColor
            view.frame = CGRect(x: x1, y: self.line.frame.origin.y, width: x2-x1, height: backHeight)
            let centerLab = UILabel(frame: CGRect(x: 0, y: (self.frame.size.height-backHeight)/2+15, width: 0, height: 12))
            centerLab.textColor = .gray6Color
            centerLab.font = .systemFont(ofSize: 12)
            if let centerText = timeSegment.centerText {
                centerLab.text = centerText
            }
            centerLab.sizeToFit()
            centerLab.textAlignment = .center
            centerLab.center = CGPoint(x: view.center.x, y: (self.frame.size.height-backHeight)/2+28)
            addSubview(centerLab)
            let lowNumLab = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 12))
            lowNumLab.textColor = .gray6Color
            lowNumLab.font = .systemFont(ofSize: 12)
            lowNumLab.textAlignment = .center
            addSubview(lowNumLab)
            if let lowNumText = timeSegment.lowNumText {
                lowNumLab.text = lowNumText
            }
            
            let heightNumLab = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 12))
            heightNumLab.textColor = .gray6Color
            heightNumLab.font = .systemFont(ofSize: 12)
            heightNumLab.textAlignment = .center
            addSubview(heightNumLab)
            if let heightNumText = timeSegment.heightNumText {
                heightNumLab.text = heightNumText
            }
            lowNumLab.sizeToFit()
            heightNumLab.sizeToFit()
            lowNumLab.center = CGPoint(x: x1, y: (self.frame.size.height-backHeight)/2-12)
            heightNumLab.center = CGPoint(x: x2, y: (self.frame.size.height-backHeight)/2-12)

            self.addSubview(view)
        }
        self.imageView.frame = CGRect(x: 0, y: 0, width: sliderPoint.x, height: sliderPoint.y)
        self.imageView.backgroundColor = sliderColor
        self.imageView.layer.cornerRadius = sliderCornerRadius
        self.imageView.center = CGPoint(x: self.value*self.frame.size.width, y: self.frame.size.height/2);
        self.bringSubviewToFront(imageView)
    }
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        return isSlide
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        let touch = touches.first
        let point = touch?.location(in: self)
        if self.imageView.frame.contains(point!) {
            isInRect = true
        }else {
            isInRect = false
        }
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        let touch = touches.first
        var point = touch!.location(in: self)
        point.y = self.frame.height/2
        if point.x < 0 {
            point.x = 0
        }
        if (point.x>self.frame.width) {
            point.x = self.frame.width;
        }
        if (isInRect) {
            self.imageView.center = point;
            self.value = 1.0*point.x/self.frame.size.width
        }
    }
    lazy var line: UIView = {
        let line = UIView()
        return line
    }()
    lazy var imageView: UIImageView = {
        let img = UIImageView()
//        img.contentMode = .scaleAspectFit
        return img
    }()
    lazy var lowLab: UILabel = {
        let lab = UILabel()
        lab.textColor = .gray6Color
        lab.font = .systemFont(ofSize: 12)
        return lab
    }()

    lazy var heightLab: UILabel = {
        let lab = UILabel()
        lab.textColor = .gray6Color
        lab.font = .systemFont(ofSize: 12)
        lab.textAlignment = .right
        return lab
    }()

}
