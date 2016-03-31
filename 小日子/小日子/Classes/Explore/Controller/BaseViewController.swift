//
//  BaseViewController.swift
//  小日子
//
//  Created by mike on 16/3/11.
//  Copyright © 2016年 MK. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLeftItemBtn()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "changeCity", name: changeCityNotificationName, object: nil)
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    //MARK:- 设置导航栏左边的 城市选择按钮
    func setupLeftItemBtn() {
         leftItemBtn = SMNavItemButton()
        leftItemBtn!.titleLabel?.font = navItemFont
        var currentCity = NSUserDefaults.standardUserDefaults().objectForKey(cityKey) as? String
        if currentCity == nil {
            currentCity = "广州"
            NSUserDefaults.standardUserDefaults().setObject(currentCity, forKey: cityKey)
            NSUserDefaults.standardUserDefaults().synchronize()
        }
        leftItemBtn!.setTitle(currentCity, forState: .Normal)
        leftItemBtn!.setTitleColor(UIColor.blackColor(), forState: .Normal)
        leftItemBtn!.setImage(UIImage(named: "home_down"), forState: .Normal)
        leftItemBtn!.addTarget(self, action: "showCityView", forControlEvents: .TouchUpInside)
        let titleW = leftItemBtn!.currentTitle?.textSizeWithFont(navItemFont, constrainedToSize: CGSizeMake(100, 44)).width
        leftItemBtn!.frame = CGRectMake(0, 0, titleW! + (leftItemBtn!.currentImage?.size.width)! + 10, 44)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftItemBtn!)
    }
    
    //MARK:- 显示城市列表
    func showCityView() {
        let cityVc = SMCityViewController()
        let navVc = SMNavigationController(rootViewController: cityVc)
        presentViewController(navVc, animated: true, completion: nil)
    }
    
    func changeCity() {
        let currentCity = NSUserDefaults.standardUserDefaults().objectForKey(cityKey) as? String
        leftItemBtn!.setTitle(currentCity, forState: .Normal)
    }
    
    var leftItemBtn: SMNavItemButton?
}
