//
//  SMMeiTianModel.swift
//  小日子
//
//  Created by mike on 16/3/14.
//  Copyright © 2016年 MK. All rights reserved.
//

import UIKit

class SMMeiTianModel: NSObject,DictModelProtocol {
    /// 位置坐标
    var position: String?
    /// 标签
    var tag: String?
    /// 数据id
    var id: Int = -1
    /// 图片url
    var img: String?
    /// 主标题
    var title: String?
    /// 说明
    var detail: String?
    /// 详细页名称
    var name: String?
    /// 详细页内容
    var content: String?
    /// 分享url
    var shareURL: String?
    /// 猜你喜欢内容
    var more: [SMGuessLikeModel]?
    /// 地址
    var address: String?
    /// 店id
    var shop_id: Int = -1
    /// 城市名
    var city: String?

    
    
    // 辅助模型
    /// 标记是否需要显示距离
    var isShowDis = false
    /// 计算出用户当前位置距离店铺我距离,单位km
    var distanceForUser: String?
    
    
    static func customClassMapping() -> [String : String]? {
        return ["more" : "\(SMGuessLikeModel.self)"]
    }
    
//    //MARK:- 根据字典转成模型
//    init(dict : [String: AnyObject]) {
//        super.init()
//        setValuesForKeysWithDictionary(dict)
//        
//    }
//    
//    //MARK:- setValuesForKeysWithDictionary内部会调用以下方法
//    override func setValue(value: AnyObject?, forKey key: String) {
//        if key == "more" {
//            var array = [SMGuessLikeModel]()
//            for dict in (value as? [[String : AnyObject]])! {
//               let guessLikeModel = SMGuessLikeModel(dict: dict)
//                array.append(guessLikeModel)
//            }
//            more = array
//            return
//        }
//        
//        // 3,调用父类方法, 按照系统默认处理
//        super.setValue(value, forKeyPath: key)
//    }
//    
//    //MARK:- 重写处理不存在的key
//    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
//        
//    }
//    
//    let properties = ["shareURL","feel","telephone","tag","id","title","detail","feeltitle","city","address","remark","imgs","more","mobileURL","position","isShowDis","distanceForUser"]
//    override var description: String {
//        let dict = self.dictionaryWithValuesForKeys(properties)
//        return "\(dict)"
//    }
    
    
}
