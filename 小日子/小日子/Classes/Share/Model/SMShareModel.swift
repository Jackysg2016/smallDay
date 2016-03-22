//
//  SMShareModel.swift
//  小日子
//
//  Created by mike on 16/3/22.
//  Copyright © 2016年 MK. All rights reserved.
//

import UIKit

class SMShareModel: NSObject {
    var shareTitle: String?
    var shareUrl: String?
    var shareImage: UIImage?
    var shareDetail: String?
    
    init(shareTitle: String?, shareUrl: String?, image: UIImage?, shareDetail: String?) {
        self.shareTitle  = shareTitle
        self.shareUrl = shareUrl
        self.shareImage = image
        self.shareDetail = shareDetail
    }
}
