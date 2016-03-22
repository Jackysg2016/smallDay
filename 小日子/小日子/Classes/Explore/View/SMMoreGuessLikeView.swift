//
//  SMMoreGuessLikeView.swift
//  小日子
//
//  Created by mike on 16/3/22.
//  Copyright © 2016年 MK. All rights reserved.
//

import UIKit

class SMMoreGuessLikeView: UIView {

    class func moreGuessLikeViewFromXib() -> SMMoreGuessLikeView {
        let moreGuessLikeView = NSBundle.mainBundle().loadNibNamed("SMMoreGuessLikeView", owner: nil, options: nil).last as! SMMoreGuessLikeView
        return moreGuessLikeView
    }

    @IBOutlet weak var subTitle: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var mainTitle: UILabel!
    
    var moreModel: SMGuessLikeModel? {
        didSet {
            imageView.sd_setImageWithURL(NSURL(string: (moreModel?.img)!), placeholderImage: UIImage(named: "quesheng"))
            mainTitle.text = moreModel?.title
            subTitle.text = moreModel?.address
        }
    }
    
}
