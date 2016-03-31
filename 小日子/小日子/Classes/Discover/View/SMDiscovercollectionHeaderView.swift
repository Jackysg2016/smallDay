//
//  SMDiscovercollectionHeaderView.swift
//  小日子
//
//  Created by mike on 16/3/30.
//  Copyright © 2016年 MK. All rights reserved.
//

import UIKit

class SMDiscovercollectionHeaderView: UICollectionReusableView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupTitleLabel()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        titleLabel!.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(self.snp_left).offset(10)
            make.right.equalTo(self.snp_right)
            make.height.equalTo(20)
            make.bottom.equalTo(self.snp_bottom)
        }
    }    
    func setupTitleLabel() {
        titleLabel = UILabel()
        titleLabel!.textAlignment = NSTextAlignment.Left
        titleLabel!.textColor = UIColor.blackColor()
        titleLabel!.font = UIFont.systemFontOfSize(16)
        addSubview(titleLabel!)
    }
    var titleLabel: UILabel?
    
}
