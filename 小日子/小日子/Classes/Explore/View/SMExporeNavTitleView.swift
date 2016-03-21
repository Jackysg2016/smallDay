//
//  SMExporeNavTitleView.swift
//  小日子
//
//  Created by mike on 16/3/12.
//  Copyright © 2016年 MK. All rights reserved.
//

import UIKit

class SMExporeNavTitleView: UIView {
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(leftBtnName: String, rightBtnName: String) {
        self.init()
        setupButton(letfBtn ,title: leftBtnName, tag: 0)
        setupButton(rightBtn, title: rightBtnName, tag:1)
        setupbottomView()
        setupSelectdBtn()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let btnW = width / 2
        letfBtn.frame = CGRectMake(0, 0, btnW, height)
        rightBtn.frame = CGRectMake(btnW, 0, btnW, height)
        bottomView.frame = CGRectMake(0, height - 2, btnW, 2)
    }
    
    private var letfBtn = UIButton()
    private var rightBtn = UIButton()
    var selectBtn : UIButton?
    var bottomView = UIView()
    weak var delegate: SMExporeNavTitleViewDelegate?
    
    //MARK:- 设置按钮
    func setupButton(button: UIButton, title: String, tag: Int) {
        button.tag = tag
        button.titleLabel?.font = navTitleFont
        button.setTitleColor(UIColor.colorWithRGB(100, g: 100, b: 100, alpha: 1), forState: .Normal)
        button.setTitleColor(UIColor.blackColor(), forState: .Selected)
        button.setTitle(title, forState: .Normal)
        button.addTarget(self, action: "titleBtnClick:", forControlEvents: .TouchUpInside)
        addSubview(button)
    }
    
    //MARK:- 设置滑动view
    func setupbottomView() {
        bottomView.backgroundColor = UIColor.colorWithRGB(60, g: 60, b: 60, alpha: 1.0)
        addSubview(bottomView)
    }
    
    func setupSelectdBtn() {
        letfBtn.selected = true
        selectBtn = letfBtn
    }
    //MARK:- 按钮点击
    func titleBtnClick(button: UIButton) {
        selectBtn?.selected = false
        button.selected = true
        selectBtn = button
        bottomViewScrollAtButton(button.tag)
        delegate?.exporeNavTitleViewDidButtonForIndex(self, button: button, index: button.tag)
    }
    //MARK:- 底部view的滑动
    func bottomViewScrollAtButton(index : Int) {
        weak var weakSelf = self
        UIView.animateWithDuration(0.1) { () -> Void in
            weakSelf!.bottomView.frame.origin.x = CGFloat(index) * self.bottomView.width
        }
    }
}

//MARK: - 代理
protocol SMExporeNavTitleViewDelegate:NSObjectProtocol {
    func exporeNavTitleViewDidButtonForIndex( exporeNavTitleView: SMExporeNavTitleView, button: UIButton, index : Int)
}
