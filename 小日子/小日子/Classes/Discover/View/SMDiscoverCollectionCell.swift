//
//  SMDiscoverCollectionCell.swift
//  小日子
//
//  Created by mike on 16/3/30.
//  Copyright © 2016年 MK. All rights reserved.
//

import UIKit

class SMDiscoverCollectionCell: UICollectionViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
         let tapGesture = UITapGestureRecognizer(target: self, action: "cellClick:")
        self.addGestureRecognizer(tapGesture)
    }
   
    func cellClick(sender: UITapGestureRecognizer) {
        self.delegate?.discoverCellClick(self, tagModel: self.model!)
    }
    
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var cellImageView: UIImageView!
    weak var delegate: SMDiscoverCollectionCellDelegate?
    
    var model: SMDiscoverTagsModel? {
        didSet {
            titleLabel.text = model?.name
            cellImageView.sd_setImageWithURL(NSURL(string: (model?.img)!), placeholderImage:UIImage(named: "quesheng"))
        }
    }
}

protocol SMDiscoverCollectionCellDelegate: NSObjectProtocol {
    func discoverCellClick(discoverCell: SMDiscoverCollectionCell, tagModel:SMDiscoverTagsModel)
}
