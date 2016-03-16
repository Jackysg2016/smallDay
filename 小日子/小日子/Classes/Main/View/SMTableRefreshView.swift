//
//  SMTableRefreshView.swift
//  小日子
//
//  Created by mike on 16/3/14.
//  Copyright © 2016年 MK. All rights reserved.
//

import UIKit


class SMTabelViewRefreshView: MJRefreshGifHeader {
    override func prepare(){
        super.prepare()
        stateLabel?.hidden = true
        lastUpdatedTimeLabel?.hidden = true
        
        //普通状态图片
        setImages([UIImage(named: "wnx00")!], forState: MJRefreshState.Idle)
        //松开就可以进行刷新的状态
        setImages([UIImage(named: "wnx00")!], forState: MJRefreshState.Pulling)
        
        let refreshStateImageArray = NSMutableArray()
        for i in 0...90 {
            let image = UIImage(named: String(format: "wnx%02d", i))
            refreshStateImageArray.addObject(image!)
        }
        //正在刷新状态图片
        setImages(refreshStateImageArray as [AnyObject], forState: MJRefreshState.Refreshing)
    }
}