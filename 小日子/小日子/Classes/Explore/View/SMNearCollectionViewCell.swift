//
//  SMNearCollectionViewCell.swift
//  小日子
//
//  Created by mike on 16/3/25.
//  Copyright © 2016年 MK. All rights reserved.
//

import UIKit




class SMNearCollectionViewCell: UICollectionViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = UIColor.whiteColor()
    }
    

    @IBAction func detailBtnClick(sender: AnyObject) {
        delegate?.nearCollectionViewCellDetailButtonClick(sender as! UIButton)
    }
    

    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!

    @IBOutlet weak var mainTitleLabel: UILabel!

    @IBOutlet weak var cellImageView: UIImageView!
    
    weak var delegate: SMNearCollectionViewCellDelegate?
    
    //MARK: -设置cell数据
    func setModel(model: SMMeiTianModel, indexPath: NSIndexPath) {
        distanceLabel.text = model.distanceForUser
        let row: String = String(indexPath.row + 1)
        mainTitleLabel.text = row + "." + model.title!
        addressLabel.text = model.address
        if let imageURL = NSURL(string: (model.img!)) {
            cellImageView.sd_setImageWithURL(imageURL, placeholderImage: UIImage(named: "quesheng")!)
        }
    }
}

//MARK: -代理，详请按钮被点击
protocol SMNearCollectionViewCellDelegate: NSObjectProtocol {
    func nearCollectionViewCellDetailButtonClick(button: UIButton)
}
