//
//  SMShareScrollView.swift
//  小日子
//
//  Created by mike on 16/3/22.
//  Copyright © 2016年 MK. All rights reserved.
//

import UIKit

class SMShareScrollView: UIScrollView {

    lazy var buttonModels: [SMShareButtonModel] = [SMShareButtonModel(title: "朋友圈", image: "cfriends"),SMShareButtonModel(title: "微信", image: "chat"),SMShareButtonModel(title: "微博", image: "weibo")]
    var buttonArray = [SMShareButton]()
   
   override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubView()
//        contentSize = CGSizeMake(<#T##width: CGFloat##CGFloat#>, <#T##height: CGFloat##CGFloat#>)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupSubView() {
        for model in buttonModels {
            let button = SMShareButton()
            button.model = model
            addSubview(button)
            buttonArray.append(button)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let btnW: CGFloat = screenW / CGFloat(buttonModels.count)
        for var i = 0; i < buttonArray.count; i++ {
            let button = buttonArray[i]
            button.frame = CGRectMake(CGFloat(i) * btnW, 0, btnW, self.height)
        }
        
    }
}
