//
//  SMSearchTextField.swift
//  小日子
//
//  Created by mike on 16/3/29.
//  Copyright © 2016年 MK. All rights reserved.
//

import UIKit

class SMSearchTextField: UITextField {
    
    override   init(frame: CGRect) {
        super.init(frame: frame)
        
        
        let view = UIView(frame: CGRectMake(0, 0, 35, 27))
        imageView = UIImageView(image: UIImage(named: "search"))
        imageView.frame = CGRectMake(0, (view.frame.size.height - (imageView.image?.size.height)!) / 2, (imageView.image?.size.width)!, (imageView.image?.size.height)!)
        view.addSubview(imageView)
        leftView = view
        leftViewMode = UITextFieldViewMode.Always
        background = UIImage(named: "searchbox")
        placeholder = "店名，地址"
        self.autocorrectionType = .No
        clearButtonMode = UITextFieldViewMode.Always
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        leftView?.frame.origin.x = 10
    }
    var imageView: UIImageView!
}
