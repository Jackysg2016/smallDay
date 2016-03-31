//
//  SMDiscoverDataModel.swift
//  小日子
//
//  Created by mike on 16/3/30.
//  Copyright © 2016年 MK. All rights reserved.
//

import UIKit

class SMDiscoverDataModel: NSObject,DictModelProtocol {

    /*
    "hot": "小洲村,天河路,体育西路,江南西路,烟墩路",
    "msg": "request success.",
    list[]
    "code": 1
    */
    
    var msg: String?
    var code: Int = -1
    var list: [SMDiscoverModel]?
    var hot: String?
    var hotArray: [String]?
    
    class func loadDiscoverData(completion:(data: SMDiscoverDataModel?, error :NSError?) -> ()) {
        let path = NSBundle.mainBundle().pathForResource("discover", ofType: nil)
        let data = NSData(contentsOfFile: path!)
        if data != nil {
            let dict: Dictionary = try! NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments) as! [String: AnyObject]
            let modelTool = DictModelManager.sharedManager
            let data = modelTool.objectWithDictionary(dict , cls: SMDiscoverDataModel.self ) as! SMDiscoverDataModel
            if (data.hot != nil) {
                data.hotArray = data.hot?.componentsSeparatedByString(",")
            }
            completion(data: data, error: nil)
        }
    }
    
    static func customClassMapping() -> [String : String]? {
        return ["list": "\(SMDiscoverModel.self)"]
    }
}
