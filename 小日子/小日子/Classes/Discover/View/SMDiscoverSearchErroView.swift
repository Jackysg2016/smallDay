//
//  SMDiscoverSearchErroView.swift
//  小日子
//
//  Created by mike on 16/3/31.
//  Copyright © 2016年 MK. All rights reserved.
//

import UIKit

class SMDiscoverSearchErroView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        errorImageView?.snp_makeConstraints(closure: { (make) -> Void in
            make.width.equalTo(60)
            make.height.equalTo(60)
            make.centerX.equalTo(self.snp_centerX)
            make.top.equalTo(self.snp_top).offset(200)
        })
        
        errorLable?.snp_makeConstraints(closure: { (make) -> Void in
            make.centerX.equalTo(self.snp_centerX)
            make.top.equalTo((self.errorImageView?.snp_bottom)!).offset(20)
        })
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        print("搜索错误view点击")
        delegate?.discoverSearchErroViewClick()
    }
    
    //MARK: -设置子控件
    func setupSubView() {
        errorLable = UILabel()
        errorLable?.font = UIFont.systemFontOfSize(16)
        errorLable?.textColor = UIColor.darkGrayColor()
        errorLable?.textAlignment = .Center
        errorLable?.text = "没有发现，换个词试试"
        addSubview(errorLable!)
        
        errorImageView =  UIImageView(image: UIImage(named:"defaultsearch" ))
        addSubview(errorImageView!)
        
    }
    
    var errorLable: UILabel?
    var errorImageView: UIImageView?
    weak var delegate: SMDiscoverSearchErroViewDelegate?
}

protocol SMDiscoverSearchErroViewDelegate:NSObjectProtocol {
    func discoverSearchErroViewClick()
}
