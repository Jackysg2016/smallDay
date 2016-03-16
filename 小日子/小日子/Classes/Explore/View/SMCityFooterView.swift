//
//  SMCityFooterView.swift
//  小日子
//
//  Created by mike on 16/3/12.
//  Copyright © 2016年 MK. All rights reserved.
//

import UIKit

class SMCityFooterView: UICollectionReusableView {
    
    
     override   init(frame: CGRect) {
        super.init(frame: frame)
        titleLabel = UILabel()
        titleLabel?.font = UIFont.systemFontOfSize(16)
        titleLabel?.textAlignment = .Center
        titleLabel?.textColor = UIColor.darkGrayColor()
        titleLabel?.text = "更多城市,敬请期待..."
        addSubview(titleLabel!)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        titleLabel?.frame = bounds
    }
    
    var titleLabel: UILabel?
    

    
}
