//
//  GlobalConstant.swift
//  小日子
//
//  Created by mike on 16/3/10.
//  Copyright © 2016年 MK. All rights reserved.
//

import UIKit

//MARK:-tabBarItemTitle字体大小                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 
public let tabBarItemTitleFont = UIFont.systemFontOfSize(12)

//MARK:-navTitle字体大小
public let navTitleFont = UIFont.systemFontOfSize(18)

//MARK:-navItem字体大小
public let navItemFont = UIFont.systemFontOfSize(16)

//MARK:- UIScreen高宽
public let screenW = UIScreen.mainScreen().bounds.size.width
public let screenH = UIScreen.mainScreen().bounds.size.height

//MARK:- ViewController的背景颜色
public let viewBackgroundColor: UIColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1.0)

//MARK:- 保存城市的key
public let cityKey = "SMCity"

//MARK:- 城市改变通知key
public let changeCityNotificationName = "changeCityNotificationName"