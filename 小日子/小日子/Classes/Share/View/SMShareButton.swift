//
//  SMShareButton.swift
//  小日子
//
//  Created by mike on 16/3/22.
//  Copyright © 2016年 MK. All rights reserved.
//

import UIKit

class SMShareButton: UIButton {

   override init(frame: CGRect) {
        super.init(frame: frame)
        titleLabel?.font = UIFont.systemFontOfSize(15)
        setTitleColor(UIColor.darkGrayColor(), forState: .Normal)
        titleLabel?.textAlignment = .Center
        imageView?.contentMode = .Center
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView?.frame = CGRectMake(0, 0, self.width, 55)
        titleLabel?.frame = CGRectMake(0, (self.imageView?.height)!, self.width, self.height -  (imageView?.height)!)
    }
    
    var  model: SMShareButtonModel? {
        didSet {
            self.setImage(UIImage(named: (model?.image)!), forState: .Normal)
            self.setTitle(model?.title, forState: .Normal)
            
        }
    }
}
