//
//  Button+Extension.swift
//  小日子
//
//  Created by mike on 16/3/29.
//  Copyright © 2016年 MK. All rights reserved.
//

import UIKit

extension UIButton {

    class  func roundButton(button: UIButton, radius: CGFloat, border: CGFloat, borderColor: UIColor) {
        button.layer.cornerRadius = radius
        button.layer.masksToBounds = true
        button.clipsToBounds = true
        button.layer.borderWidth = border
        button.layer.borderColor = borderColor.CGColor
    }
    

}
