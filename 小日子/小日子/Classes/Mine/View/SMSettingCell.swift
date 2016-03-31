//
//  SMSettingCell.swift
//  小日子
//
//  Created by mike on 16/3/29.
//  Copyright © 2016年 MK. All rights reserved.
//

import UIKit

class SMSettingCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .None
    }

    class func settingCellFromXib(tableView: UITableView) -> SMSettingCell {
        let identifiter = "settingCell"
        var cell = tableView.dequeueReusableCellWithIdentifier(identifiter) as? SMSettingCell
        if cell == nil {
            cell = NSBundle.mainBundle().loadNibNamed("SMSettingCell", owner: nil, options: nil).last as? SMSettingCell
        }
        return cell!

    }
    
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var cellImageView: UIImageView!
    
    var model: SMSettingModel? {
        didSet {
            titleLabel.text = model?.title
            if model?.type == .remove {
                let size = FileTool.cacheSize
                subTitleLabel.text = size
            }else {
                subTitleLabel.text = model?.subTitle
            }
            cellImageView.image = UIImage(named: (model?.imageName)!)
        }
    }
}
