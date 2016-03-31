//
//  SMCityViewController.swift
//  小日子
//
//  Created by mike on 16/3/11.
//  Copyright © 2016年 MK. All rights reserved.
//

import UIKit

private let reuseIdentifier = "CityCell"
private let cityHeaderIdentifier = "cityHeader"
private let cityFooterIdentifier = "cityFooter"
private var selectedCell = UICollectionViewCell()

class SMCityViewController: UICollectionViewController {
    
    
    let chinaCityArray = ["北京", "上海", "广州", "深圳", "成都", "杭州", "西安","重庆", "南京", "厦门", "武汉","景德镇","乌鲁木齐", "海口", "香港", "台北","", ""]
    let foreignCityArray = ["伦敦", "巴黎", "纽约", "洛杉矶", "柏林", "马德里", "罗马","首尔", "新德里"]
    init () {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 1
        layout.minimumLineSpacing = 1
        let itemW :CGFloat = screenW / 3 - 1
        layout.itemSize = CGSizeMake(itemW, 50)
        super.init(collectionViewLayout: layout)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
    }
    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        
        return 2
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return chinaCityArray.count
        }
        else if section == 1 {
            return foreignCityArray.count
        }
        else {
            return 0
        }
    }
    
    //MARK:- cell设置
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! SMCityCell
        if indexPath.section == 0 {
            cell.cityName = chinaCityArray[indexPath.row]
        }else {
            cell.cityName = foreignCityArray[indexPath.row]
        }
        return cell
    }
    
    //MARK:- 设置每组的headerView和footerView
    override func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        
        if indexPath.section == 1 && kind == UICollectionElementKindSectionFooter{
            let footerView = collectionView.dequeueReusableSupplementaryViewOfKind(UICollectionElementKindSectionFooter, withReuseIdentifier: cityFooterIdentifier, forIndexPath: indexPath) as! SMCityFooterView
            return footerView
        }
        
        let headerView = collectionView.dequeueReusableSupplementaryViewOfKind(UICollectionElementKindSectionHeader, withReuseIdentifier: cityHeaderIdentifier, forIndexPath: indexPath) as! SMCitiHeaderView
        if indexPath.section == 0 {
            headerView.titleLabel.text = "国内"
        }
        else if indexPath.section == 1 {
            headerView.titleLabel.text = "国外"
        }
        return headerView
        
    }
    
    //MARK:- 设置默认选中的cell
    override func collectionView(collectionView: UICollectionView, willDisplayCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
        let selectedIndePath = getSelectedIndexPath()
        if selectedIndePath == indexPath {
            cell.selected = true
            selectedCell = cell
        }
    }

    
    //MARK:- 设置 CollectionView 的Header尺寸
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSizeMake(screenW, 50)
    }
    
    //MARK:- 设置 CollectionView 的Footer尺寸
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        if section == 0 {
            return CGSizeZero
        }
        return CGSizeMake(screenW, 50)
    }
    
     //MARK:- 点击选中城市并保存到本地，发出城市改变的通知
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let cell = collectionView.cellForItemAtIndexPath(indexPath) as! SMCityCell
        selectedCell.selected = false
        NSUserDefaults.standardUserDefaults().setObject(cell.cityName, forKey: cityKey)
        NSUserDefaults.standardUserDefaults().synchronize()
        NSNotificationCenter.defaultCenter().postNotificationName(changeCityNotificationName, object: cell.cityName)
        cancel()
    }
    
    //MARK:- 设置collectionView
    func setupCollectionView() {
        self.view?.backgroundColor = viewBackgroundColor
        collectionView!.backgroundColor = UIColor.colorWithRGB(247, g: 247, b: 247, alpha: 1.0)
        collectionView?.alwaysBounceVertical = true
        collectionView?.contentInset = UIEdgeInsetsMake(0, 0, 50, 0)
        collectionView?.selectItemAtIndexPath(NSIndexPath(forItem: 0, inSection: 0), animated: true, scrollPosition: UICollectionViewScrollPosition.None)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "取消", style: UIBarButtonItemStyle.Plain, target: self, action: "cancel")
        self.collectionView?.registerClass(SMCityCell.self , forCellWithReuseIdentifier: reuseIdentifier)
        self.collectionView?.registerClass(SMCitiHeaderView.self , forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: cityHeaderIdentifier)
        self.collectionView?.registerClass(SMCityFooterView.self , forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: cityFooterIdentifier)
    }
    
    //MARK:- 获取默认选择的城市
    func getSelectedIndexPath() -> NSIndexPath {
        let selectedCity = NSUserDefaults.standardUserDefaults().objectForKey(cityKey) as? String
        for var index = 0; index < chinaCityArray.count; index++ {
            if chinaCityArray[index] == selectedCity {
               let indexPath = NSIndexPath(forItem: index, inSection: 0)
                return indexPath
            }
        }
        for var index = 0; index < foreignCityArray.count; index++ {
            if foreignCityArray[index] == selectedCity {
                let indexPath = NSIndexPath(forItem: index, inSection: 1)
                return indexPath
            }
        }
         return NSIndexPath(forItem: 0, inSection: 2)
    }
    
    func cancel(){
        dismissViewControllerAnimated(true, completion: nil )
    }
}
