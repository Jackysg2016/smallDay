//
//  SMSearchButton.swift
//  小日子
//
//  Created by mike on 16/3/29.
//  Copyright © 2016年 MK. All rights reserved.
//

import UIKit

class SMSearchButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
   convenience init(target: AnyObject, action : Selector) {
        self.init()
        setTitle("搜索", forState: .Normal)
        setTitle("取消", forState: .Selected)
        titleLabel?.font = UIFont.systemFontOfSize(16)
        setTitleColor(UIColor.blackColor(), forState: .Normal)
        addTarget(target, action: action, forControlEvents: .TouchUpInside)
        titleLabel?.textAlignment = .Center
        setBackgroundImage(UIImage(named: "biaoqian"), forState: .Normal)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
