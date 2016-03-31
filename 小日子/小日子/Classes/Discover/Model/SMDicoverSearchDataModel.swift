//
//  SMDicoverSearchDataModel.swift
//  小日子
//
//  Created by mike on 16/3/31.
//  Copyright © 2016年 MK. All rights reserved.
//

import UIKit

class SMDicoverSearchDataModel: NSObject {
    var msg: String?
    var code: Int = -1
    var list: [SMMeiTianModel]?
    
    class func loadDiscoverSearchData(competion:(data: SMDicoverSearchDataModel?, error: NSError?) ->()) {
        let path = NSBundle.mainBundle().pathForResource("searchData", ofType: nil)
        let data = NSData(contentsOfFile: path!)
        
        if data != nil {
            let dict: Dictionary = try! NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments) as! [String: AnyObject]
            let modelTool = DictModelManager.sharedManager
            let data = modelTool.objectWithDictionary(dict, cls: SMDicoverSearchDataModel.self) as? SMDicoverSearchDataModel
            competion(data: data, error: nil)
            
        }
    }
    
    static func customClassMapping() -> [String : String]? {
        return ["list" : "\(SMMeiTianModel.self)"]
    }
}
