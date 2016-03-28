//
//  SMExperienceCell.swift
//  小日子
//
//  Created by mike on 16/3/28.
//  Copyright © 2016年 MK. All rights reserved.
//

import UIKit

class SMExperienceCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        selectionStyle = .None
    }
    
    class func experienceCellFromXib(tableView: UITableView) -> SMExperienceCell {
        let indentifier = "experienceCell"
        var cell = tableView.dequeueReusableCellWithIdentifier(indentifier) as? SMExperienceCell
        if cell == nil {
          cell =  NSBundle.mainBundle().loadNibNamed("SMExperienceCell", owner: nil, options: nil).last as? SMExperienceCell
        }
        return cell!
    }
 
    @IBOutlet weak var cellImageView: UIImageView!
    @IBOutlet weak var tagLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    var model: SMExperienceModel? {
        didSet {
            titleLabel.text = model?.title
          let tag =  model?.tag?.stringByReplacingOccurrencesOfString(",", withString: " · ")
            tagLabel.text = tag
            cellImageView.sd_setImageWithURL(NSURL(string: (model?.imgs?.first)!), placeholderImage: UIImage(named: "quesheng"))
        }
    }
}
