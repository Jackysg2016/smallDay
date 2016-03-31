//
//  SMNearShopModel.swift
//  小日子
//
//  Created by mike on 16/3/24.
//  Copyright © 2016年 MK. All rights reserved.
//

import UIKit

class SMNearShopModel: NSObject,DictModelProtocol {
    var msg: String?
    var code: Int = -1
    var list: [SMMeiTianModel]?
    
    class func loadExploreDataForNear(competion:(data: SMNearShopModel?, error: NSError?) ->()) {
        let path = NSBundle.mainBundle().pathForResource("Nears", ofType: nil)
        let data = NSData(contentsOfFile: path!)
        
        if data != nil {
            let dict: Dictionary = try! NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments) as! [String: AnyObject]
            let modelTool = DictModelManager.sharedManager
            let data = modelTool.objectWithDictionary(dict, cls: SMNearShopModel.self) as? SMNearShopModel
            for everyDayModel in data!.list! {
                if UserInfoManager.sharedUserInfoManager.userPosition == nil {
                    //23.1353080000,113.2707930000
                   let defaultPosition = CLLocationCoordinate2D(latitude: 23.1353080000, longitude: 113.2707930000)
                    UserInfoManager.sharedUserInfoManager.userPosition = defaultPosition
                }
                let userL = UserInfoManager.sharedUserInfoManager.userPosition!
                let shopL = everyDayModel.position!.stringToCLLocationCoordinate2D(",")!
                let dis = MAMetersBetweenMapPoints(MAMapPointForCoordinate(userL), MAMapPointForCoordinate(shopL))
                everyDayModel.distanceForUser = String(format: "%.1fkm", dis * 0.001)
            }
            competion(data: data, error: nil)
            
        }
    }
    
    static func customClassMapping() -> [String : String]? {
        return ["list" : "\(SMMeiTianModel.self)"]
    }

}
