//
//  SMErrorView.swift
//  小日子
//
//  Created by mike on 16/3/17.
//  Copyright © 2016年 MK. All rights reserved.
//

import UIKit

class SMErrorView: UIView {

  override  init(frame: CGRect) {
        super.init(frame: frame)
       addSubview(errorLabel)
       addSubview(tryButton)
       tryButton.addTarget(self , action: "tryBtnClick:", forControlEvents: .TouchUpInside)
    }

  required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
  }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        errorLabel.snp_makeConstraints { (make) -> Void in
            make.centerX.equalTo(self.snp_centerX)
            make.top.equalTo(self.snp_top)
            
        }
        
        tryButton.snp_makeConstraints { (make) -> Void in
            make.centerX.equalTo(self.snp_centerX)
            make.top.equalTo(errorLabel.snp_bottom).offset(5)
        }
        
        
    }
    
  lazy  var errorLabel: UILabel = {
       let label = UILabel()
        label.text = "网络加载失败，请点击重试按钮重新加载"
        label.textColor = UIColor.grayColor()
        label.textAlignment = .Center
        label.font = UIFont.systemFontOfSize(15)
        label.sizeToFit()
        return label
    }()
    
  lazy  var tryButton : UIButton = {
       let tryBtn = UIButton()
        tryBtn.setTitle("重试", forState: .Normal)
        tryBtn.setTitleColor(UIColor.darkGrayColor(), forState: .Normal)
        tryBtn.titleLabel?.font = UIFont.systemFontOfSize(17)
        tryBtn.setBackgroundImage(UIImage(named: "anniu_2"), forState: .Normal)
        tryBtn.sizeToFit()
        return tryBtn
    }()
    
    weak var delegate: SMErrorViewDelegate?
    
    func tryBtnClick(button: UIButton) {
        self.delegate?.tryButtonClick(self, buton: button)
    }

}

protocol SMErrorViewDelegate: NSObjectProtocol {
    
    func tryButtonClick(errorView: SMErrorView, buton: UIButton)
}
