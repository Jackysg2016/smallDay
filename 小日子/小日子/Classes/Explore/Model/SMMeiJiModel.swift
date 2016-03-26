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
    var theme_url: String?
    /// 图片url
    var img: String?
    /// 主标题
    var title: String?
    /// cell的副标题
    var tag: String?
    /// 美辑的编号
    var theme_id: Int = -1
    
    var content: String?
    
    var theme_type: Int = -1
    
    var start_date: String?
    
    
/*
    "title": "花漫羊城寻孤店（下）",
    
    "end_date": "",
    
    "theme_url": "http://api.xiaorizi.me/api/themedetail/?themeid=593",
    
    "theme_id": 593,
    
    "tag": "羊城 杂货 孤店",
    
    "classify_type": 2,
    
    "start_date": "2016-03-14",
    
    "theme_type": 5,
    
    "img": "http://pic.huodongjia.com/event/2016-03-12/event176052.jpg",
    
    "content": "<p>在羊城的街道上，慢慢彳亍行着，走过的那些美好的店，实在无法让我们归类。如果统称杂货铺，那么我们只能说自己是爱在杂货中寻找美好的人。</p>\r\n"
    */
    

}

class SMMeiJiData: NSObject ,DictModelProtocol{
    
    var msg: String?
    var code: Int = -1
    var list: [SMMeiJiModel]?
    
    class func loadExploreDataForMeiJi(competion:(data: SMMeiJiData?, error: NSError?) ->()) {
        let path = NSBundle.mainBundle().pathForResource("meiJis", ofType: nil)
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
