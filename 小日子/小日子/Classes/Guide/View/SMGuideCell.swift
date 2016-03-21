//
//  SMGuideCell.swift
//  小日子
//
//  Created by mike on 16/3/11.
//  Copyright © 2016年 MK. All rights reserved.
//

import UIKit

class SMGuideCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
        contentView.addSubview(enterBtn)
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
         super.layoutSubviews()
        enterBtn.frame.size = (enterBtn.currentBackgroundImage?.size)!
        enterBtn.snp_makeConstraints(closure: { (make) -> Void in
            make.width.equalTo((enterBtn.currentBackgroundImage?.size.width)!)
            make.height.equalTo((enterBtn.currentBackgroundImage?.size.height)!)
            make.centerX.equalTo(self.snp_centerX)
            make.bottom.equalTo(self.snp_bottom).offset(-35)
        })
    }
    
    func enterBtnClick() {
        UIApplication.sharedApplication().keyWindow?.rootViewController = SMTabBarController()
    }
    
    var imageName: String? {
        didSet {
            imageView.image = UIImage(named: imageName!)
        }
    }
    lazy  var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.frame = self.bounds
        return imageView
    }()
    
    lazy var enterBtn: UIButton = {
        let enterBtn = UIButton(type: UIButtonType.Custom)
        enterBtn.setBackgroundImage(UIImage(named: "opening_1"), forState: .Normal)
        enterBtn.setBackgroundImage(UIImage(named: "opening_2"), forState: .Highlighted)
        enterBtn.addTarget(self , action: "enterBtnClick", forControlEvents: .TouchUpInside)
        enterBtn.hidden = true
        enterBtn.setTitle("开启小幸福", forState: .Normal)
        enterBtn.titleLabel?.font = UIFont.systemFontOfSize(14)
        enterBtn.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        return enterBtn
        
    }()
}
