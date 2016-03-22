//
//  SMGuessLikeView.swift
//  小日子
//
//  Created by mike on 16/3/22.
//  Copyright © 2016年 MK. All rights reserved.
//

import UIKit

class SMGuessLikeView: UIView {

    class func guessLikeViewFromXib() -> SMGuessLikeView {
        let guessLikeView = NSBundle.mainBundle().loadNibNamed("SMGuessLikeView" , owner: nil, options: nil).last as! SMGuessLikeView
        
        return guessLikeView
    }

}
