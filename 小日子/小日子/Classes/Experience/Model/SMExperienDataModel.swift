//
//  SMExperienDataModel.swift
//  小日子
//
//  Created by mike on 16/3/28.
//  Copyright © 2016年 MK. All rights reserved.
//

import UIKit

class SMExperienDataModel:NSObject, DictModelProtocol {

    var msg: String?
    var code: Int = -1
    var list: [SMExperienceModel]?
    var head: [SMExperienHeadModel]?
    
    class func loadExperienceData(competion :(data: SMExperienDataModel?, error : NSError?) ->()) {
        let path = NSBundle.mainBundle().pathForResource("experiences", ofType: nil)
        let data = NSData(contentsOfFile: path!)
        if data != nil {
            let dict: Dictionary = try! NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments)  as! [String: AnyObject]
            let modelTool = DictModelManager.sharedManager
            let data = modelTool.objectWithDictionary(dict, cls: SMExperienDataModel.self ) as! SMExperienDataModel
            competion(data: data, error: nil)
        }
    }
    
    static func customClassMapping() -> [String : String]? {
        return ["list" : "\(SMExperienceModel.self)", "head": "\(SMExperienHeadModel.self)"]
    }
}
