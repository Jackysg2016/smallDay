//
//  SMDiscoverHotView.swift
//  小日子
//
//  Created by mike on 16/3/30.
//  Copyright © 2016年 MK. All rights reserved.
//

import UIKit

class SMDiscoverHotView: UIView {

   override init(frame: CGRect) {
        super.init(frame: frame)

    }
    convenience init(frame: CGRect, hotData: [String]) {
        self.init(frame: frame)
        hotDataArray = hotData
        setupHotView()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupHotView() {
        if hotDataArray?.count > 0 {

            let margin: CGFloat = 10
            let btnH: CGFloat = 30
            var btnY: CGFloat = 0
            var btnW: CGFloat = 0
            let textMargin: CGFloat = 30
            for i in 0..<hotDataArray!.count {
                let btn = UIButton()
                btn.setTitle(hotDataArray![i], forState: .Normal)
                btn.titleLabel?.font = UIFont.systemFontOfSize(15)
                btn.setTitleColor(UIColor.blackColor(), forState: .Normal)
                btn.titleLabel!.sizeToFit()
                btn.setBackgroundImage(UIImage(named: "button"), forState: .Normal)
                
                btnW = btn.titleLabel!.width + textMargin
                btn.addTarget(self, action: "hotBtnClick:", forControlEvents: .TouchUpInside)
                if hotBtns.count > 0 {
                    let lastBtn = hotBtns.lastObject as! UIButton
                    let freeW = screenW - CGRectGetMaxX(lastBtn.frame)
                    
                    if freeW > btnW + 2 * margin {
                        btnY = lastBtn.frame.origin.y
                        btn.frame = CGRectMake(CGRectGetMaxX(lastBtn.frame) + margin, btnY, btnW, btnH)
                    } else {
                        btnY = CGRectGetMaxY(lastBtn.frame) + margin
                        btn.frame = CGRectMake(margin, btnY, btnW, btnH)
                    }
                    hotBtns.addObject(btn)
                    addSubview(btn)
                } else {
                    btn.frame = CGRectMake(margin, 0, btnW, btnH)
                    hotBtns.addObject(btn)
                    addSubview(btn)
                }
            }

        }
        
    }
    
    func hotBtnClick(button: UIButton) {
        delegate?.hotViewButtonClick(self, button: button)
    }
    
    var hotDataArray : [String]?
    lazy var hotBtns: NSMutableArray = NSMutableArray()
    weak var delegate: SMDiscoverHotViewDelegate?
}

protocol SMDiscoverHotViewDelegate: NSObjectProtocol {
    func hotViewButtonClick(hotView: SMDiscoverHotView, button: UIButton)
}
