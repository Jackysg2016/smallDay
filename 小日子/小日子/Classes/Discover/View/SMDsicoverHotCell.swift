//
//  SMDsicoverHotCell.swift
//  小日子
//
//  Created by mike on 16/3/31.
//  Copyright © 2016年 MK. All rights reserved.
//

import UIKit

class SMDsicoverHotCell: UICollectionViewCell {

   override init(frame: CGRect) {
        super.init(frame: frame)
    }

   required init?(coder aDecoder: NSCoder) {
       fatalError("init(coder:) has not been implemented")
   }
   
    var hotView: SMDiscoverHotView?
    weak var delegate: SMDsicoverHotCellDelegate?
    var model: SMDiscoverDataModel? {
        didSet {
            if oldValue == model {
                return
            }
             hotView = SMDiscoverHotView(frame: self.bounds, hotData: (model?.hotArray)!)
            hotView?.delegate = self
            addSubview(hotView!)
        }
    }
}

protocol SMDsicoverHotCellDelegate: NSObjectProtocol {
     func hotCellButtonClikc(hotCell:SMDsicoverHotCell, button: UIButton)
}

extension SMDsicoverHotCell: SMDiscoverHotViewDelegate {
    func hotViewButtonClick(hotView: SMDiscoverHotView, button: UIButton) {
        self.delegate?.hotCellButtonClikc(self, button: button)
    }
}
