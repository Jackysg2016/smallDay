//
//  UIBarButtonItem+Extension.swift
//  小日子
//
//  Created by mike on 16/3/25.
//  Copyright © 2016年 MK. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    
    /**
     导航条右边自定义item
     
     - parameter imageName:     <#imageName description#>
     - parameter highImageName: <#highImageName description#>
     - parameter targer:        <#targer description#>
     - parameter action:        <#action description#>
     
     - returns: <#return value description#>
     */
    convenience init(imageName: String, highImageName: String, targer: AnyObject, action: Selector) {
        let buttonItem = UIButton(type: .Custom)
        buttonItem.setImage(UIImage(named: imageName), forState: .Normal)
        buttonItem.setImage(UIImage(named: highImageName), forState: .Highlighted)
        buttonItem.addTarget(targer, action: action, forControlEvents: .TouchUpInside)
        buttonItem.contentHorizontalAlignment = .Right
        buttonItem.frame = CGRectMake(0, 0, 50, 44)
        buttonItem.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -10)
        self.init(customView: buttonItem)
    }
    
    /**
     导航条右边自定义item
     
     - parameter imageName:         <#imageName description#>
     - parameter highImageName:     <#highImageName description#>
     - parameter selectedImageName: <#selectedImageName description#>
     - parameter targer:            <#targer description#>
     - parameter action:            <#action description#>
     
     - returns: <#return value description#>
     */
    convenience init(imageName: String, highImageName: String, selectedImageName: String, targer: AnyObject, action: Selector) {
        let buttonItem =  UIButton(type: .Custom)
        buttonItem.setImage(UIImage(named: imageName), forState: .Normal)
        buttonItem.setImage(UIImage(named:highImageName ), forState: .Highlighted)
        buttonItem.setImage(UIImage(named:selectedImageName ), forState: .Selected)
        buttonItem.addTarget(targer, action: action, forControlEvents: .TouchUpInside)
        buttonItem.frame = CGRectMake(0, 0, 50, 44)
        buttonItem.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -10)
        buttonItem.contentHorizontalAlignment = .Right
        self.init(customView: buttonItem)
    }
    
    /**
     导航条右边自定义item
     
     - parameter title:      <#title description#>
     - parameter titleClocr: <#titleClocr description#>
     - parameter targer:     <#targer description#>
     - parameter action:     <#action description#>
     - parameter titleFont:  <#titleFont description#>
     
     - returns: <#return value description#>
     */
    convenience init(title: String, titleClocr: UIColor, targer: AnyObject ,action: Selector, titleFont: UIFont) {
        
        let buttonItem = UIButton(type: .Custom)
        buttonItem.setTitle(title, forState: .Normal)
        buttonItem.setTitleColor(titleClocr, forState: .Normal)
        buttonItem.titleLabel?.font = titleFont
        buttonItem.setTitleColor(UIColor.grayColor(), forState: .Highlighted)
        buttonItem.frame = CGRectMake(0, 0, 80, 44)
        buttonItem.titleLabel?.textAlignment = NSTextAlignment.Right
        buttonItem.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Right
        buttonItem.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -5)
        buttonItem.addTarget(targer, action: action, forControlEvents: .TouchUpInside)
        
        self.init(customView: buttonItem)
    }

}
