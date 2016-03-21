//
//  SMMeiTianDetailBarView.swift
//  小日子
//
//  Created by mike on 16/3/18.
//  Copyright © 2016年 MK. All rights reserved.
//



import UIKit

enum SMMeiTianDetailBarViewType: Int {
    case Left = 0
    case Right = 1
}

class SMMeiTianDetailBarView: UIView {

   override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    convenience init(frame: CGRect,leftTitle: String, rightTile: String) {
        self.init(frame: frame)
        leftBtn = createButton(leftTitle, type: .Left)
        rightBtn = createButton(rightTile, type: .Right)
        setupView()
        
    }
   required init?(coder aDecoder: NSCoder) {
       fatalError("init(coder:) has not been implemented")
   }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let margin: CGFloat = 10.0
        let btnW = (self.width - margin * 4 + 1) / 2
        let btnH = self.height
        leftBtn!.frame = CGRectMake(margin, 0, btnW, btnH)
        let middViewX = CGRectGetMaxX((leftBtn?.frame)!) + margin
        middleView!.frame = CGRectMake(middViewX, (btnH - btnH * 0.5) * 0.5, 1,  btnH * 0.5)
        let rigBtnX = CGRectGetMaxX((middleView?.frame)!) + margin
        rightBtn!.frame = CGRectMake(rigBtnX, 0, btnW, btnH)
        bottomBlackView?.frame = CGRectMake(margin, btnH, btnW, 1)

    }
    
    
    private func createButton(title: String, type: SMMeiTianDetailBarViewType) ->  UIButton {
       let  button = UIButton(type: .Custom)
        button.setTitle(title, forState: .Normal)
        button.titleLabel?.font = UIFont.systemFontOfSize(20)
        button.titleLabel?.textAlignment = .Center
        button.setTitleColor(UIColor.blackColor(), forState: .Normal)
        button.addTarget(self, action: "btnClick:", forControlEvents: .TouchUpInside)
        button.tag = type.rawValue
        button.sizeToFit()
        addSubview(button)
        return button
    }
    
    private func setupView() {
        middleView = UIView()
        middleView?.backgroundColor = UIColor.colorWithRGB(50, g: 50, b: 50, alpha: 0.1)
        addSubview(middleView!)
        bottomBlackView = UIView()
        bottomBlackView?.backgroundColor = UIColor.colorWithRGB(50, g: 50, b: 50, alpha: 1)
        addSubview(bottomBlackView!)
        
    }
    
    
    func btnClick(button: UIButton) {
        print(button.tag)
        let type = SMMeiTianDetailBarViewType(rawValue: button.tag)
        bottomBlackViewScroll(type!)
        delegate?.meiTainDetailBarViewDidButton(self, button: button, type: type!)
        
    }
    
    func bottomBlackViewScroll(type : SMMeiTianDetailBarViewType) {
        weak var weakSelf = self
        if type == .Left {
            let bottomX = CGRectGetMinX((leftBtn?.frame)!)
            UIView.animateWithDuration(0.2, animations: { () -> Void in
                weakSelf!.bottomBlackView?.frame.origin.x = bottomX
            })
        }else {
            let bottomX = CGRectGetMinX((rightBtn?.frame)!)
            UIView.animateWithDuration(0.2, animations: { () -> Void in
                weakSelf!.bottomBlackView?.frame.origin.x = bottomX
            })
        }
    }
    
    private var leftBtn: UIButton?
    private var rightBtn: UIButton?
    private var middleView: UIView?
    private var bottomBlackView: UIView?
    var delegate: SMMeiTianDetailBarViewDelegate?
    
}

protocol SMMeiTianDetailBarViewDelegate:NSObjectProtocol {
    func meiTainDetailBarViewDidButton(meiTainDetailBarView: SMMeiTianDetailBarView, button: UIButton, type: SMMeiTianDetailBarViewType)
}
