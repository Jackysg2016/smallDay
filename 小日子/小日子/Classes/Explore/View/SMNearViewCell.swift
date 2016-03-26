//
//  SMNearViewCell.swift
//  小日子
//
//  Created by mike on 16/3/24.
//  Copyright © 2016年 MK. All rights reserved.
//

import UIKit

class SMNearViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    //MARK:- xib加载cell
    class func  nearCell(tableView: UITableView) -> SMNearViewCell{
        let identifier = "nearCell"
        var cell = tableView.dequeueReusableCellWithIdentifier(identifier) as? SMNearViewCell
        if cell == nil {
            cell = NSBundle.mainBundle().loadNibNamed( String(self), owner: nil, options: nil).last as? SMNearViewCell
        }
        return cell!
    }
    
  
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var mainTitleLable: UILabel!
    @IBOutlet weak var cellImageView: UIImageView!
    
    //MARK: -设置cell数据
    var model: SMMeiTianModel? {
        didSet {
            distanceLabel.text = model?.distanceForUser
            mainTitleLable.text = model?.title
            addressLabel.text = model?.address
            if let imageURL = NSURL(string: (model?.img!)!) {
                cellImageView.sd_setImageWithURL(imageURL, placeholderImage: UIImage(named: "quesheng")!)
            }
            
        }
    }
}
