//
//  SMGuideController.swift
//  小日子
//
//  Created by mike on 16/3/11.
//  Copyright © 2016年 MK. All rights reserved.
//

import UIKit

private let reuseIdentifier = "GuideCell"

class SMGuideController: UICollectionViewController {
    
    let imageNameArray = ["onepage", "twopage", "threepage", "fourpage"]
    
    //MARK:- 纯代码需要初始化init方法，指定collectionView的UICollectionViewFlowLayout
    init() {
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSizeMake(screenW, screenH)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.scrollDirection = UICollectionViewScrollDirection.Horizontal
        super.init(collectionViewLayout: layout)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
    }
    
    //MARK:- 设置collectionView
    func setupCollectionView() {
        
        collectionView?.pagingEnabled = true
        collectionView?.bounces = false
        collectionView?.showsHorizontalScrollIndicator = false
//        collectionView?.backgroundColor = UIColor.yellowColor()
        //注册cell
        self.collectionView?.registerClass(SMGuideCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageNameArray.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! SMGuideCell
        cell.imageName = imageNameArray[indexPath.row]
        if indexPath.row == imageNameArray.count - 1 {
            cell.enterBtn.hidden = false
        }else {
            cell.enterBtn.hidden = true
        }
        return cell
    }
    
}
