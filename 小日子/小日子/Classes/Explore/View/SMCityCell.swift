//
//  SMCityCell.swift
//  小日子
//
//  Created by mike on 16/3/11.
//  Copyright © 2016年 MK. All rights reserved.
//

import UIKit

class SMCityCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        textlabel.textColor = UIColor.blackColor()
        textlabel.highlightedTextColor = UIColor.redColor()
        textlabel.textAlignment = .Center
        textlabel.backgroundColor = UIColor.whiteColor()
        contentView.addSubview(textlabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        textlabel.frame = self.bounds
    }
    
    private var textlabel = UILabel()
    var cityName: String? {
        didSet {
            textlabel.text = cityName
        }
    }
    
}
