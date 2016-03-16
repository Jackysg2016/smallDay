//
//  SMMeiJiModel.swift
//  小日子
//
//  Created by mike on 16/3/14.
//  Copyright © 2016年 MK. All rights reserved.
//

import UIKit

class SMMeiJiModel: NSObject {
    /// 美辑的url网址
    var meiJiurl: String?
    /// 图片url
    var img: String?
    /// cell主标题
    var title: String?
    /// 是否有web地址 1是有, 0没有
    var hasweb: Int = -1
    /// cell的副标题
    var keywords: String?
    /// 美辑的编号
    var id: Int = -1
    var text: String?
    
    
//    //MARK:- 根据字典转成模型
//    init(dict :[String: AnyObject]) {
//        super.init()
//        setValuesForKeysWithDictionary(dict)
//    }
//    
//     //MARK:- 重写处理不存在的key
//    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
//        
//    }
//    
//    
//    let properties = ["meiJiurl","img","title","hasweb","keywords","id","text"]
//    override var description: String {
//        let dict = self.dictionaryWithValuesForKeys(properties)
//        return "\(dict)"
//    }
    

}

class SMMeiJiData: NSObject ,DictModelProtocol{
    
    var msg: String?
    var code: Int = -1
    var list: [SMMeiJiModel]?
    
    class func loadExploreDataForMeiJi(competion:(data: SMMeiJiData?, error: NSError?) ->()) {
        let path = NSBundle.mainBundle().pathForResource("themes", ofType: nil)
        let data = NSData(contentsOfFile: path!)
        
        if data != nil {
            let dict: Dictionary = try! NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments) as! [String: AnyObject]
            let modelTool = DictModelManager.sharedManager
            let data = modelTool.objectWithDictionary(dict, cls: SMMeiJiData.self) as? SMMeiJiData
            competion(data: data, error: nil)
            
        }
    }
    
    static func customClassMapping() -> [String : String]? {
        return ["list":"\(SMMeiJiModel.self)"]
    }

}
