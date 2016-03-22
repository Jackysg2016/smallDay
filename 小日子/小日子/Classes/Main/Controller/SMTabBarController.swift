//
//  SMTabBarController.swift
//  小日子
//
//  Created by mike on 16/3/10.
//  Copyright © 2016年 MK. All rights reserved.
//

import UIKit

class SMTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        initTabBarController()
        self.setValue(SMTabBar(), forKey: "tabBar")
    }
    
    //MARK: - 初始化tabbar控制器
    func initTabBarController() {
        createChildrenVc(SMExploreViewController() , title: "探店", imageName: "recommendation_1", selectedImageName: "recommendation_2")
        createChildrenVc(ViewController(), title: "体验", imageName: "broadwood_1", selectedImageName: "broadwood_2")
        createChildrenVc(ViewController(), title: "分类", imageName: "classification_1", selectedImageName: "classification_2")
        createChildrenVc(SMMineViewController(), title: "我的", imageName: "my_1", selectedImageName: "my_2")
    }
    
    //MARK:- 设置控制器的tabBarItem属性
    private func createChildrenVc(viewController: UIViewController, title: String, imageName: String, selectedImageName: String) {
        
        viewController.tabBarItem.title = title
        viewController.title = title
        viewController.tabBarItem.image = UIImage(named: imageName)
        viewController.tabBarItem.selectedImage = UIImage(named: selectedImageName)
//        viewController.tabBarItem.badgeValue = "10"
        let navVc = SMNavigationController(rootViewController: viewController)
        addChildViewController(navVc)
    }
}
