//
//  AppDelegate.swift
//  小日子
//
//  Created by mike on 16/3/10.
//  Copyright © 2016年 MK. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        NSThread.sleepForTimeInterval(1.0)
        setupWindow()
        return true
    }
    
    //MARK: -设置window及window的根控制器
    private func setupWindow() {
        window = UIWindow()
        window?.frame = UIScreen.mainScreen().bounds
        var rootVc: UIViewController?
        if SMAppVersionTool.getVersion() {
            rootVc = SMGuideController()
        }else {
            rootVc = SMTabBarController()
        }
        window?.rootViewController = rootVc
        window?.makeKeyAndVisible()
        
        setupTabBarTitle()
        setupNavgationBarTitle()
    }

    //MARK: -全局设置TabBarItem的字体颜色，根据状态
    private func setupTabBarTitle() {
        let norDict: Dictionary<String,AnyObject> = [NSForegroundColorAttributeName: UIColor.grayColor(), NSFontAttributeName: tabBarItemTitleFont]
        UITabBarItem.appearance().setTitleTextAttributes(norDict, forState: .Normal)
        
        let seletedDict: Dictionary<String, AnyObject> = [NSForegroundColorAttributeName: UIColor.blackColor(), NSFontAttributeName: tabBarItemTitleFont]
        UITabBarItem.appearance().setTitleTextAttributes(seletedDict, forState: .Selected)
    }
    
     //MARK: -全局设置导航的字体颜色
    private func setupNavgationBarTitle(){
        let navTitleDict: Dictionary<String, AnyObject> = [NSFontAttributeName:navTitleFont, NSForegroundColorAttributeName: UIColor.blackColor()]
        UINavigationBar.appearance().titleTextAttributes = navTitleDict
        
        let navItemDict: Dictionary<String, AnyObject> = [NSFontAttributeName: navItemFont, NSForegroundColorAttributeName:UIColor.blackColor()]
        UIBarButtonItem.appearance().setTitleTextAttributes(navItemDict, forState: .Normal)
    }

}

