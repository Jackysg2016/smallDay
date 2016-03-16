//
//  SMExploreWithTopTitleCell.swift
//  小日子
//
//  Created by mike on 16/3/14.
//  Copyright © 2016年 MK. All rights reserved.
//

import UIKit

class SMExploreWithTopTitleCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .None
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //MARK: -设置cell数据
    var model: SMEveryDayModel? {
        didSet {
            cellTitleLabel.text = model?.meiTianArray?.last?.feeltitle
            mainTitleLabel.text = model?.meiTianArray?.last?.title
            subTitleLabel.text = model?.meiTianArray?.last?.address
            dayLabel.text = model?.day
            monthLabel.text = model?.month
            if let imageURL = NSURL(string: (model?.meiTianArray?.last?.imgs!.last!)!) {
                cellImageView.sd_setImageWithURL(imageURL, placeholderImage: UIImage(named: "quesheng")!)
            }

        }
    }
    
    //副标题
    @IBOutlet weak var subTitleLabel: UILabel!
    //主标题
    @IBOutlet weak var mainTitleLabel: UILabel!
    //图片
    @IBOutlet weak var cellImageView: UIImageView!
    //日期
    @IBOutlet weak var dayLabel: UILabel!
    //月份
    @IBOutlet weak var monthLabel: UILabel!
    //组标题
    @IBOutlet weak var cellTitleLabel: UILabel!
    
    //MARK:- xib加载cell
    class func  exploreWithTopTitleCell(tableView: UITableView) -> SMExploreWithTopTitleCell{
        let identifier = "exploreWithTopTitleCell"
        var cell = tableView.dequeueReusableCellWithIdentifier(identifier) as? SMExploreWithTopTitleCell
        if cell == nil {
            cell = NSBundle.mainBundle().loadNibNamed( String(self), owner: nil, options: nil).last as? SMExploreWithTopTitleCell
        }
        return cell!
    }
}
