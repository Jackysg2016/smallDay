
//
//  Color+Extension.swift
//
//  Created by mike on 16/2/22.
//  Copyright © 2016年 aipai. All rights reserved.
//

import UIKit
extension UIColor {
    class func colorWithRGB(r: CGFloat, g:CGFloat, b:CGFloat, alpha: CGFloat) -> UIColor{
        return UIColor(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: alpha)
    }
    
    class func randomColor () -> UIColor{
        let redFloat = CGFloat(arc4random_uniform(256))
        let greenFloat = CGFloat (arc4random_uniform(256))
        let blueFloat = CGFloat (arc4random_uniform(256))
        return colorWithRGB(redFloat, g: greenFloat , b: blueFloat, alpha: 1.0)
    }
}