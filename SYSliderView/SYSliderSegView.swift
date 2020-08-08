//
//  SYSliderView.swift
//  SYTexDemo
//
//  Created by bsoshy on 2020/7/7.
//  Copyright © 2020 bsy. All rights reserved.
//

import UIKit
import SnapKit

class SYSliderSegView: UISlider {
    
    var unit : String?
    
    lazy var sliderValueLabel: UILabel = {
        let lab = UILabel.init()
        lab.textAlignment = .center;
        lab.font = UIFont.systemFont(ofSize: 14)
        lab.textColor = .red
//        UIColor(hexString: "9A9CFC")
        return lab
    }()
    
    //slider高度
    var height: CGFloat = 0.0
    //是否允许滑动
    var isSlide = true
    //展示进度文字
    func setisShowTitle(unit:String=""){
        self.unit = unit
        self.isContinuous = true
        self.addTarget(self, action: #selector(sliderAction(slider:)), for: .valueChanged)
        self.sliderValueLabel.text = "\(String(format: "%.1f", self.value))\(unit)"
        self.addSubview(self.sliderValueLabel)
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            let slider : UIImageView = self.subviews.last as! UIImageView
            self.sliderValueLabel.snp.makeConstraints({ (make) in
                make.bottom.equalTo(slider.snp.top).offset(-2)
                make.centerX.equalTo(slider)
            })
        }
    }
    
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        return isSlide
    }

    // 控制slider的宽和高，这个方法才是真正的改变slider滑道的高的
    override func trackRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.trackRect(forBounds: bounds)
        return CGRect.init(x: rect.origin.x, y: (bounds.size.height-height)/2, width: bounds.size.width, height: height)
    }
//    override func thumbRect(forBounds bounds: CGRect, trackRect rect: CGRect, value: Float) -> CGRect {
//        let  ldresult = super.thumbRect(forBounds: bounds, trackRect: rect, value: value)
//        return ldresult
//    }
    @objc func sliderAction(slider : UISlider){
        self.sliderValueLabel.text = "\(String(format: "%.1f", self.value))\(unit ?? "")"
    }
    
}
