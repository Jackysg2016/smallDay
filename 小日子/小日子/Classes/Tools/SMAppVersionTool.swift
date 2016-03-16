//
//  SMAppVersionTool.swift
//  小日子
//
//  Created by mike on 16/3/11.
//  Copyright © 2016年 MK. All rights reserved.
//

import UIKit

class SMAppVersionTool: NSObject {

    //MARK: -判断是否为新版本，是返回true
    class func getVersion() -> Bool {
        let versionKey = "CFBundleShortVersionString"
        let currentVersion = NSBundle.mainBundle().infoDictionary![versionKey] as! String
        let oldVersion = NSUserDefaults.standardUserDefaults().objectForKey(versionKey) as? String
        if currentVersion != oldVersion {
            NSUserDefaults.standardUserDefaults().setObject(currentVersion, forKey: versionKey)
            NSUserDefaults.standardUserDefaults().synchronize()
            return true
        }else {
            return false
        }
    }
    
}
