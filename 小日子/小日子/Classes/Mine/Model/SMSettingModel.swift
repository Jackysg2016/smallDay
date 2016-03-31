//
//  SMSettingModel.swift
//  小日子
//
//  Created by mike on 16/3/29.
//  Copyright © 2016年 MK. All rights reserved.
//

import UIKit

enum SMSettingModelType {
    case score
    case recommendfriend
    case about
    case remove
}


class SMSettingModel: NSObject {

    var title: String?
    var subTitle: String?
    var imageName: String?
    var type: SMSettingModelType?
    
    init(title: String, subTitle: String, imageName: String, type: SMSettingModelType) {
        super.init()
        self.title = title
        self.subTitle = subTitle
        self.imageName = imageName
        self.type = type
    }
    
    class func loadSettingData() -> [SMSettingModel] {
        var dataArray = [SMSettingModel]()
        dataArray.append(SMSettingModel(title: "去App Store评价", subTitle: "", imageName: "score-1", type: .score))
        dataArray.append(SMSettingModel(title: "推荐给朋友", subTitle: "", imageName: "recommendfriend-1", type: .recommendfriend))
        dataArray.append(SMSettingModel(title: "关于我们", subTitle: "", imageName: "about-1", type: .about))
        dataArray.append(SMSettingModel(title: "清理缓存", subTitle: "", imageName: "remove-1", type: .remove))
        return dataArray
    }
}
