//
//  SMTabBar.swift
//  小日子
//
//  Created by mike on 16/3/10.
//  Copyright © 2016年 MK. All rights reserved.
//

import UIKit

class SMTabBar: UITabBar {

  override  init(frame: CGRect) {
       super.init(frame: frame)
       self.translucent = false
       self.backgroundImage = UIImage(named: "tabbar")
    }
    
  required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
  }
    

}
