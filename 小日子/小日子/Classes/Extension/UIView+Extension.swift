//
//  UIView+Extension.swift
//
//  Created by mike on 16/2/26.
//  Copyright © 2016年 aipai. All rights reserved.
//

import UIKit

extension UIView {
    /// X值
    var x: CGFloat {
        set {
            var frame :CGRect = self.frame
            frame.origin.x = x;
            self.frame = frame;
         }
        get {
           return self.frame.origin.x
        }
    }
    /// Y值
    var y: CGFloat {
        set {
            var frame :CGRect = self.frame
            frame.origin.y = y;
            self.frame = frame;
        }
        get {
        return self.frame.origin.y
        }
    }
    /// 宽度
    var width: CGFloat {
        set {
            var frame :CGRect = self.frame
            frame.size.width = width;
            self.frame = frame;
        }
        get {
        return self.frame.size.width
        }
    }
    ///高度
    var height: CGFloat {
        set {
            var frame :CGRect = self.frame
            frame.size.height = height;
            self.frame = frame;

        }
        get {
        return self.frame.size.height
        }
    }
    
    var size: CGSize {
        set {
            var frame :CGRect = self.frame
            frame.size = size;
            self.frame = frame;
        }
        get {
        return self.frame.size
        }
    }
    var point: CGPoint {
        set {
            var frame :CGRect = self.frame
            frame.origin = point;
            self.frame = frame;
        }
        get {
        return self.frame.origin
        }
    }
}
