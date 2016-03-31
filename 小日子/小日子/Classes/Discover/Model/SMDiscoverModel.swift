//
//  SMDiscoverModel.swift
//  小日子
//
//  Created by mike on 16/3/30.
//  Copyright © 2016年 MK. All rights reserved.
//

import UIKit

class SMDiscoverModel: NSObject,DictModelProtocol {
   /*
    "id": 234,
    "classify_type": 0,
    "tags[]"
    title
    */
    var id: Int = -1
    var tags: [SMDiscoverTagsModel]?
    var title: String?
    
    
    static func customClassMapping() -> [String : String]? {
        return ["tags": "\(SMDiscoverTagsModel.self)"]
    }
}
