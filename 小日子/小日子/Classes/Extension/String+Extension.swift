//
//  String+Extension.swift
//
//  Created by mike on 16/3/3.
//  Copyright © 2016年 aipai. All rights reserved.
//

import UIKit

extension  String {

    /// 清除字符串小数点末尾的0
    func cleanDecimalPointZear() -> String {
        
        let newStr = self as NSString
        var s = NSString()
        
        var offset = newStr.length - 1
        while offset > 0 {
            s = newStr.substringWithRange(NSMakeRange(offset, 1))
            if s.isEqualToString("0") || s.isEqualToString(".") {
                offset--
            } else {
                break
            }
        }
        
        return newStr.substringToIndex(offset + 1)
    }
   
    func textSizeWithFont(font: UIFont, constrainedToSize size:CGSize) -> CGSize {
        
        var textSize:CGSize!
        
        if CGSizeEqualToSize(size, CGSizeZero) {
            
            let attributes = NSDictionary(object: font, forKey: NSFontAttributeName)
            
            textSize = self.sizeWithAttributes(attributes as! [String : AnyObject] as [String : AnyObject])
            
        } else {
            
            let option = NSStringDrawingOptions.UsesLineFragmentOrigin
            
            let attributes = NSDictionary(object: font, forKey: NSFontAttributeName)
            
            let stringRect = self.boundingRectWithSize(size, options: option, attributes: attributes as! [String : AnyObject] as [String : AnyObject], context: nil)
            
            textSize = stringRect.size
            
        }
        
        return textSize
        
    }
}
