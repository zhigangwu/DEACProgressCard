//
//  DEACProgressCardImageView.swift
//  DEACProgressCard
//
//  Created by Ryan on 2023/11/2.
//

import UIKit

public class DEACProgressCardImageView: UIView {
    
    /* 背景图 */
    public var cardImage : String = "" {
        didSet {
            if cardImage != "" {
                cardButton.setBackgroundImage(UIImage(named: cardImage), for: .normal)
            }
        }
    }
    
    /* 总计时 */
    public var totaldurationSecond : Int? = 10
    
    /* 四周闪烁颜色 */
    public var movingBlockColor : UIColor?
    
    let bgView = UIView()
    let spinProgressView = SpinProgressView(frame: .zero)
    let cardButton = UIButton()
    
    var currentFrame : CGRect?

    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.currentFrame = frame

        bgView.backgroundColor = .clear
        bgView.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
        self.addSubview(bgView)
        
        cardButton.frame = CGRect(x: 2, y: 2, width: frame.width - 4, height: frame.height - 4)
        cardButton.layer.cornerRadius = 8
        cardButton.layer.masksToBounds = true
        cardButton.isUserInteractionEnabled = true
        self.addSubview(cardButton)
        
        spinProgressView.draw(frame)
        spinProgressView.isHidden = true
        spinProgressView.backgroundColor = .clear
        spinProgressView.frame = CGRect(x: 0, y: 0, width: frame.width - 4, height: frame.height - 4)
        cardButton.addSubview(spinProgressView)
        
        cardButton.addTarget(self, action: #selector(clcikCardButton), for: .touchUpInside)
        
        layoutFrameAnimationImageView(frame)
    }
    
    let upAnimation = UIImageView()
    let rightAnimation = UIImageView()
    let downAnimation = UIImageView()
    let leftAnimation = UIImageView()
    
    func layoutFrameAnimationImageView(_ frame: CGRect) {
        upAnimation.frame = CGRect(x: -10, y: 0, width: 10, height: 2)
        upAnimation.backgroundColor = .clear
        bgView.addSubview(upAnimation)
        
        rightAnimation.frame = CGRect(x: frame.width - 2, y: -10, width: 2, height: 10)
        rightAnimation.backgroundColor = .clear
        bgView.addSubview(rightAnimation)

        downAnimation.frame = CGRect(x: frame.width , y: frame.height - 2 , width: 10, height: 2)
        downAnimation.backgroundColor = .clear
        bgView.addSubview(downAnimation)

        leftAnimation.frame = CGRect(x: 0, y: frame.height, width: 2, height: 10)
        leftAnimation.backgroundColor = .clear
        bgView.addSubview(leftAnimation)
    }
    
    func startFrameAnimationImageView() {

        UIView.animate(withDuration: 1) {
            self.upAnimation.backgroundColor = self.movingBlockColor
            self.rightAnimation.backgroundColor = self.movingBlockColor
            self.downAnimation.backgroundColor = self.movingBlockColor
            self.leftAnimation.backgroundColor = self.movingBlockColor
            self.upAnimation.frame = CGRect(x: self.currentFrame!.width - 10, y: 0, width: 10, height: 2)
            self.rightAnimation.frame = CGRect(x: self.currentFrame!.height - 2, y: self.currentFrame!.height - 10, width: 2, height: 10)
            self.downAnimation.frame = CGRect(x: 0, y: self.currentFrame!.height - 2, width: 10, height: 2)
            self.leftAnimation.frame = CGRect(x: 0, y: 0, width: 2, height: 10)
        } completion: { (Bool) in
            self.upAnimation.backgroundColor = .clear
            self.rightAnimation.backgroundColor = .clear
            self.downAnimation.backgroundColor = .clear
            self.leftAnimation.backgroundColor = .clear
            self.upAnimation.frame = CGRect(x: -10, y: 0, width: 10, height: 2)
            self.rightAnimation.frame = CGRect(x: self.currentFrame!.width - 2, y: -10, width: 2, height: 10)
            self.downAnimation.frame = CGRect(x: self.currentFrame!.width , y: self.currentFrame!.height - 2 , width: 10, height: 2)
            self.leftAnimation.frame = CGRect(x: 0, y: self.currentFrame!.height, width: 2, height: 10)
        }
    }
    
    var timer : Timer? = nil
    var alreadydurationSecond = 1
    
    @objc func clcikCardButton() {
        if totaldurationSecond ?? 0 > 0 {
            if self.timer == nil {
                self.spinProgressView.setNeedsDisplay()
                self.spinProgressView.isHidden = false
                self.cardButton.isUserInteractionEnabled = false
                
                let averageAngle : CGFloat = CGFloat.pi * 2 / CGFloat(totaldurationSecond!)
                if alreadydurationSecond != 0 {
                    self.spinProgressView.finishAngle = CGFloat.pi * 3 / 2 + averageAngle * CGFloat(alreadydurationSecond)
                }
                totaldurationSecond = totaldurationSecond! - alreadydurationSecond
                
                self.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { [weak self] (Timer) in
                    DispatchQueue.main.async {
                        if self!.totaldurationSecond! <= 0 {
                            self?.stop()
                        } else {
                            self?.startFrameAnimationImageView()
                            self!.spinProgressView.finishAngle = self!.spinProgressView.finishAngle + averageAngle
                            DispatchQueue.main.async {
                                self?.spinProgressView.setNeedsDisplay()
                            }
                            self!.totaldurationSecond! -= 1
                        }
                    }
                })
            }
        }
    }
    
    func stop() {
        self.timer?.invalidate()
        self.timer = nil
        self.spinProgressView.isHidden = true
        self.spinProgressView.finishAngle = CGFloat.pi * 3 / 2
        self.cardButton.isUserInteractionEnabled = true
        self.totaldurationSecond = 30
        self.upAnimation.backgroundColor = .clear
        self.rightAnimation.backgroundColor = .clear
        self.downAnimation.backgroundColor = .clear
        self.leftAnimation.backgroundColor = .clear
    }
    
    
    deinit {
        print("释放",self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class SpinProgressView : UIView {
    
    var beginAngle = CGFloat.pi * 3 / 2 // 起点
    var finishAngle = CGFloat.pi * 3 / 2
    
    var durationSecond : Double? = 0
    var _second : Double? {
        willSet {
            durationSecond = _second
            setNeedsDisplay()
        }
    }
    
    override func draw(_ rect: CGRect) {
        let size = rect.size
        let arcCenter = CGPoint(x: size.width * 0.5, y: size.height * 0.5)
        
        let radius_value = size.width * sin(90.0)
        
        let aPath = UIBezierPath(arcCenter: arcCenter, radius: radius_value, startAngle: beginAngle, endAngle: finishAngle, clockwise: false)
        aPath.lineWidth = 1.0 // 线条宽度
        let color = UIColor(red: 0, green: 0, blue: 0, alpha: 0.6)
        color.set() // 设置线条颜色
        aPath.addLine(to: arcCenter)
        aPath.fill() // Draws line 根据坐标点连线，填充
    }
}
