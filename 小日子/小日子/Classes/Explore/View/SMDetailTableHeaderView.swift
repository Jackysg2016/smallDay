//
//  SMDetailTableHeaderView.swift
//  小日子
//
//  Created by mike on 16/3/22.
//  Copyright © 2016年 MK. All rights reserved.
//

import UIKit

class SMDetailTableHeaderView: UIView {


    @IBOutlet weak var titleLabel: UILabel!
    
    class func detailTableHeaderViewFromXib() -> SMDetailTableHeaderView {
        let detailTableHeaderView = NSBundle.mainBundle().loadNibNamed("SMDetailTableHeaderView", owner: nil, options: nil).last as!SMDetailTableHeaderView        
        detailTableHeaderView.backgroundColor = UIColor.colorWithRGB(245, g: 245, b: 245, alpha: 1.0)
        return detailTableHeaderView
    }
}
