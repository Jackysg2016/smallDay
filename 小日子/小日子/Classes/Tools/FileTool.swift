//
//  FileTool.swift
//  小日子
//
//  Created by mike on 16/3/29.
//  Copyright © 2016年 MK. All rights reserved.
//

import UIKit

class FileTool: NSObject {
    
    static let fileManager = NSFileManager.defaultManager()
    
    // 计算缓存大小
    static var cacheSize: String{
        get{
            let basePath = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.CachesDirectory, NSSearchPathDomainMask.UserDomainMask, true).first
            func caculateCache() -> Float{
                var total: Float = 0
                if fileManager.fileExistsAtPath(basePath!){
                    let childrenPath = fileManager.subpathsAtPath(basePath!)
                    if childrenPath != nil{
                        for path in childrenPath!{
                            let childPath = basePath!.stringByAppendingString("/").stringByAppendingString(path)
                            do{
                                let attr = try fileManager.attributesOfItemAtPath(childPath)
                                let fileSize = attr["NSFileSize"] as! Float
                                total += fileSize
                                
                            }catch _{
                                
                            }
                        }
                    }
                }
                
                return total
            }
            
            
            let totalCache = caculateCache()
            return NSString(format: "%.2f MB", totalCache / 1024.0 / 1024.0 ) as String
        }
    }
    
    // 清除缓存
    class func clearCache(complete:() ->()){
        
        let basePath = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.CachesDirectory, NSSearchPathDomainMask.UserDomainMask, true).first
        let queue = dispatch_get_main_queue()
        
        dispatch_async(queue) { () -> Void in

            let chilerFiles = self.fileManager.subpathsAtPath(basePath!)
            for fileName in chilerFiles! {
                let tmpPath = basePath! as NSString
                let fileFullPathName = tmpPath.stringByAppendingPathComponent(fileName)
                if self.fileManager.fileExistsAtPath(fileFullPathName) {
                    do {
                        try self.fileManager.removeItemAtPath(fileFullPathName)
                    } catch _ {

                    }
                }
            }
            
            SDImageCache.sharedImageCache().cleanDisk()
            complete()
          
        }
    }
}


