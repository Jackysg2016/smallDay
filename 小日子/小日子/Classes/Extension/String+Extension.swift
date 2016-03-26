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
   
    /// 根据字符返回字字符串的size
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
    
    /// 判断是否是邮箱
    func validateEmail() -> Bool {
        let emailRegex: String = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let emailTest: NSPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailTest.evaluateWithObject(self)
    }
    
    /// 判断是否是手机号
    func validateMobile() -> Bool {
        let phoneRegex: String = "^((13[0-9])|(15[^4,\\D])|(18[0,0-9])|(17[0,0-9]))\\d{8}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        return phoneTest.evaluateWithObject(self)
    }
    
    /// 将字符串转换成经纬度
    func stringToCLLocationCoordinate2D(separator: String) -> CLLocationCoordinate2D? {
        let arr = self.componentsSeparatedByString(separator)
        if arr.count != 2 {
            return nil
        }
        
        let latitude: Double = NSString(string: arr[1]).doubleValue
        let longitude: Double = NSString(string: arr[0]).doubleValue
        
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    

}

extension NSMutableString {
    
    class func changeHeigthAndWidthWithSrting(searchStr: NSMutableString) -> NSMutableString {
        var mut = [CGFloat]()
        var mutH = [CGFloat]()
        let imageW = screenW - 16
        let rxHeight = NSRegularExpression(pattern: "(?<= height=\")\\d*")
        let rxWidth = NSRegularExpression(pattern: "(?<=width=\")\\d*")
        let widthArray = rxWidth.matches(searchStr as String) as! [String]
        
        for width  in widthArray {
            Int(width)!
            mut.append(imageW/CGFloat(Int(width)!))
        }
        
        var widthMatches = rxWidth.matchesInString(searchStr as String, options: NSMatchingOptions(rawValue: 0), range: NSMakeRange(0, searchStr.length))
        
        for var i = widthMatches.count - 1; i >= 0; i-- {
            let widthMatch = widthMatches[i] as NSTextCheckingResult
            searchStr.replaceCharactersInRange(widthMatch.range, withString: "\(imageW)")
        }
        
        let newString = searchStr.mutableCopy() as! NSMutableString
        
        let heightArray = rxHeight.matches(newString as String) as! [String]
        for i in 0..<mut.count {
            mutH.append(mut[i] * CGFloat(Int(heightArray[i])!))
        }
        
        var matches = rxHeight.matchesInString(newString as String, options: NSMatchingOptions(rawValue: 0), range: NSMakeRange(0, newString.length))
        
        for var i = matches.count - 1; i >= 0; i--
        {
            let match = matches[i] as NSTextCheckingResult
            newString.replaceCharactersInRange(match.range, withString: "\(mutH[i])")
        }
        
        return newString
    }
}