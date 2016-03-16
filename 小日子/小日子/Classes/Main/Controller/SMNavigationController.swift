//
//  SMNavigationController.swift
//  小日子
//
//  Created by mike on 16/3/10.
//  Copyright © 2016年 MK. All rights reserved.
//

import UIKit

class SMNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    //MARK: -重写导航控制器的push方法，如果是第一个子控制器，则隐藏返回箭头，并设置返回按钮的标题
    override func pushViewController(viewController: UIViewController, animated: Bool) {
        if childViewControllers.count > 0 {
            let vc = childViewControllers[0]
            if childViewControllers.count == 1 {
                print(vc.title)
                backBtn.setTitle(vc.title, forState: .Normal)
            }else {
                backBtn.setTitle("返回", forState: .Normal)
            }
            viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backBtn)
            //push到第二个子控制器，隐藏tabbar
            viewController.hidesBottomBarWhenPushed = true
            
        }
        super.pushViewController(viewController, animated: animated)
    }
    
    func back(){
        popViewControllerAnimated(true)
    }
    
    //MARK: -返回按钮
    lazy var backBtn :UIButton = {
        let backBtn = UIButton(type: UIButtonType.Custom)
        backBtn.titleLabel?.font = UIFont.systemFontOfSize(17)
        backBtn.setTitleColor(UIColor.blackColor(), forState: .Normal)
        backBtn.setTitleColor(UIColor.grayColor(), forState: .Highlighted)
        backBtn.setImage(UIImage(named:"back_1"), forState: .Normal)
        backBtn.setImage(UIImage(named:"back_2"), forState: .Highlighted)
        backBtn.contentEdgeInsets = UIEdgeInsetsMake(0, -25, 0, 0)
        backBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0)
        let  btnW: CGFloat = screenW > 375.0 ? 50:44
        backBtn.frame = CGRectMake(0, 0, btnW, 40)
        backBtn.addTarget(self, action: "back", forControlEvents: .TouchUpInside)
        return backBtn
        
    }()
}
