//
//  SMEveryDayModel.swift
//  小日子
//
//  Created by mike on 16/3/15.
//  Copyright © 2016年 MK. All rights reserved.
//

import UIKit

class SMEveryDayModel: NSObject,DictModelProtocol {

    var day_word: String?
    var date : NSString? {
        willSet {
            if let tmpDate = newValue {
                if tmpDate.length == 10 {
                    if let tmpM = Int(tmpDate.substringWithRange(NSRange(location: 5, length: 2))) {
                        switch tmpM {
                        case 1:
                            self.month = "Jan."
                        case 2:
                            self.month = "Feb."
                        case 3:
                            self.month = "Mar."
                        case 4:
                            self.month = "Apr."
                        case 5:
                            self.month = "May."
                        case 6:
                            self.month = "Jun."
                        case 7:
                            self.month = "Jul."
                        case 8:
                            self.month = "Aug."
                        case 9:
                            self.month = "Sep."
                        case 10:
                            self.month = "Oct."
                        case 11:
                            self.month = "Nov."
                        case 12:
                            self.month = "Dec."
                        default:
                            self.month = "\(tmpM)."
                        }
                    } else {
                        self.month = "NoN."
                    }
                    
                    self.day = tmpDate.substringWithRange(NSRange(location: 8, length: 2))
                } else {
                    self.date = newValue
                    return
                }
            }
            
            self.date = newValue
        }
    }
    var themes: [SMMeiJiModel ]?
    var shops: [SMMeiTianModel]?
    
    // 辅助属性 为了优化 每个模型只计算一次
    var month: String?
    var day: String?
    
    static func customClassMapping() -> [String : String]? {
        return ["themes" : "\(SMMeiJiModel.self)", "shops" : "\(SMMeiTianModel.self)"]
    }
    
//    init(dict : [String:AnyObject]) {
//        super.init()
//        setValuesForKeysWithDictionary(dict)
//    }
    
//    override func setValue(value: AnyObject?, forKey key: String) {
//        if key == "meiJiArray" {
//            var meiJis = [SMMeiJiModel]()
//            for dict in (value as? [[String:AnyObject]])! {
//                let meijiModel = SMMeiJiModel(dict:dict)
//                meiJis.append(meijiModel)
//            }
//            meiJiArray = meiJis
//            return
//        }
//        if key == "meiTianArray" {
//            var meiTians = [SMMeiTianModel]()
//            for dict in (value as? [[String:AnyObject]])! {
//                let meijiModel = SMMeiTianModel(dict:dict)
//                meiTians.append(meijiModel)
//            }
//            meiTianArray = meiTians
//            return
//        }
//        // 3,调用父类方法, 按照系统默认处理
//        super.setValue(value, forKeyPath: key)
//    }
    
//    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
//        
//    }
//    
//    let properties = ["month","day","meiJiArray","meiTianArray"]
//    
//    override var description: String {
//        
//        let dict = self.dictionaryWithValuesForKeys(properties)
//        return "\(dict)"
//    }
}

class SMEveryDayData: NSObject,DictModelProtocol {
    var msg: String?
    var code: Int = -1
    var list: [SMEveryDayModel]?
    
    class func loadExploreDataForMeiTian(competion:(data: SMEveryDayData?, error: NSError?) ->()) {
        let path = NSBundle.mainBundle().pathForResource("meiTians", ofType: nil)
        let data = NSData(contentsOfFile: path!)
        
        if data != nil {
            let dict: Dictionary = try! NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments) as! [String: AnyObject]
            let modelTool = DictModelManager.sharedManager
            let data = modelTool.objectWithDictionary(dict, cls: SMEveryDayData.self) as? SMEveryDayData
            competion(data: data, error: nil)
            
        }
    }
    
    
    static func customClassMapping() -> [String : String]? {
        return ["list" : "\(SMEveryDayModel.self)"]
    }

}
