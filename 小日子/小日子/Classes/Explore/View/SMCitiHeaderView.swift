//
//  SMCitiHeaderView.swift
//  小日子
//
//  Created by mike on 16/3/12.
//  Copyright © 2016年 MK. All rights reserved.
//

import UIKit

class SMCitiHeaderView: UICollectionReusableView {
   

    
   override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(titleLabel)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        titleLabel.frame = bounds
    }
    lazy var titleLabel : UILabel = {
        let titleLabel = UILabel()
        titleLabel.textAlignment = .Center
        titleLabel.font = UIFont.systemFontOfSize(22)
        titleLabel.textColor = UIColor.blackColor()
        return titleLabel
    }()
    
    
}
