//
//  SMShareButtonModel.swift
//  小日子
//
//  Created by mike on 16/3/22.
//  Copyright © 2016年 MK. All rights reserved.
//

import UIKit

class SMShareButtonModel: NSObject {

    var image: String?
    var title: String?
    
    init(title: String, image: String) {
        self.title = title
        self.image = image
    }
}
