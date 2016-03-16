//
//  SMNavItemButton.swift
//  小日子
//
//  Created by mike on 16/3/11.
//  Copyright © 2016年 MK. All rights reserved.
//

import UIKit

class SMNavItemButton: UIButton {

   override init(frame: CGRect) {
        super.init(frame: frame)
       titleLabel?.contentMode = .Left
       imageView?.contentMode = .Left
    
    }
    

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        titleLabel?.sizeToFit()
        titleLabel?.frame = CGRectMake(-8, 0, titleLabel!.width, height)
        imageView?.frame = CGRectMake(titleLabel!.width, 0, width - titleLabel!.width, height)
    }

}
