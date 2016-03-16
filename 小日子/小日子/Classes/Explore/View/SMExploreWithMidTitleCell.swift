//
//  SMExploreWithMidTitleCell.swift
//  小日子
//
//  Created by mike on 16/3/14.
//  Copyright © 2016年 MK. All rights reserved.
//

import UIKit

class SMExploreWithMidTitleCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .None
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //MARK: -设置cell数据
    var model: SMMeiJiModel?{
        didSet {
            mainTitleLabel.text = model?.title
            subTitleLabel.text = model!.keywords
            cellImageView.sd_setImageWithURL(NSURL(string: model!.img!)!, placeholderImage: UIImage(named: "quesheng")!)
        }
    }
    
    //副标题
    @IBOutlet weak var subTitleLabel: UILabel!
    //主标题
    @IBOutlet weak var mainTitleLabel: UILabel!
    //图片
    @IBOutlet weak var cellImageView: UIImageView!
    
    //MARK:- xib加载cell
    class  func exploreWithMidTitleCell(tableView: UITableView) -> SMExploreWithMidTitleCell {
        let identifier = "SMExploreWithMidTitleCell"
        var cell = tableView.dequeueReusableCellWithIdentifier(identifier) as? SMExploreWithMidTitleCell
        if cell == nil {
            cell = NSBundle.mainBundle().loadNibNamed(String(self), owner: nil, options: nil).last as? SMExploreWithMidTitleCell
        }
        return cell!
    }
}
