# SYSliderView

![image](https://github.com/bsytt/SYSliderView/blob/master/img.png)

一：1.支持分段的sliderView：

    class SYSegment: NSObject {
      //起始位置
      var percentIn : CGFloat = 0.2
      //结束
      var percentOut : CGFloat = 0.5
      //分段颜色
      var segmentColor : UIColor = .purple
      //分段显示标题
      var lowNumText : String?
      var heightNumText : String?
      var centerText : String?
    }
   SYSegment是对分段的设置；
 2.对slider的设置：
 
    //当前值（0～1）
    var value : CGFloat!
    //每一段在整个timeline上的trimIn和trimOut所占的百分比
    var timeSegments : [SYSegment]!
    //是否允许滑动
    var isSlide = true
    private var isInRect : Bool!
    var backColor : UIColor = .lightGray
    var backCornerRadius : CGFloat = 4
    var backHeight : CGFloat = 8
    
    //滑块风格
    var sliderPoint : CGPoint = CGPoint(x: 30, y: 30)
    var sliderCornerRadius : CGFloat = 15
    var sliderColor : UIColor = .white
    var sliderImage : UIImage?{
        didSet {
           self.imageView.image = sliderImage
        }
    }
二：简单的slider定制，及滑块顶部展示当前值
 
    //slider高度
    var height: CGFloat = 0.0
    //是否允许滑动
    var isSlide = true
   
