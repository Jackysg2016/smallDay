//
//  SMDiscoverViewController.swift
//  小日子
//
//  Created by mike on 16/3/29.
//  Copyright © 2016年 MK. All rights reserved.
//

import UIKit

class SMDiscoverViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = viewBackgroundColor
        setupNav()
        setCollectionView()
        setsearErrorView()
        setsearchTableView()
        setSearchView()
    }
    
    //MARK: -设置导航
    func setupNav() {
        navigationItem.title = "分类"
        self.automaticallyAdjustsScrollViewInsets = false
    }
    
    //MARK: -设置搜索view
    func setSearchView() {
        searchView = SMSearchView(frame: CGRectMake(0, 64, screenW, 40))
        searchView.backgroundColor = UIColor.colorWithRGB(239, g: 239, b: 239, alpha: 1.0)
        searchView.delegate = self
        view.addSubview(searchView)
    }
    
    //MARK: -设置分类collectionView
    func setCollectionView() {
        let layout = UICollectionViewFlowLayout()
        let margin: CGFloat = 10
        layout.minimumInteritemSpacing = 5
        layout.minimumLineSpacing = 5
        layout.sectionInset = UIEdgeInsetsMake(margin, margin, margin, margin)
        layout.headerReferenceSize = CGSizeMake(screenW, 25)

        collectionView = UICollectionView(frame: CGRectMake(0, 104, screenW, screenH), collectionViewLayout: layout)
        collectionView!.backgroundColor = viewBackgroundColor
        collectionView!.delegate = self
        collectionView!.dataSource = self
        collectionView!.alwaysBounceVertical = true
        collectionView!.registerClass(SMDiscovercollectionHeaderView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerIdentifiter)
        
        collectionView!.registerNib(UINib(nibName: "SMDiscoverCollectionCell", bundle: nil), forCellWithReuseIdentifier: identifiter)
        collectionView?.registerClass(SMDsicoverHotCell.self, forCellWithReuseIdentifier: hotidentifiter)
        collectionView!.showsHorizontalScrollIndicator = false
        collectionView!.showsVerticalScrollIndicator = false
        collectionView!.contentInset = UIEdgeInsetsMake(0, 0, 150, 0)
        collectionView?.mj_header = SMTabelViewRefreshView(refreshingTarget: self, refreshingAction: "loadData")
        collectionView?.mj_header.beginRefreshing()
        view.addSubview(collectionView!)
    }
    
    //MARK: -设置搜索结果tableview
    func setsearchTableView() {
        searchTableView = UITableView(frame: CGRectMake(0, 104, screenW, screenH), style: .Plain)
        searchTableView?.delegate = self
        searchTableView?.dataSource = self
        searchTableView?.backgroundColor = viewBackgroundColor
        searchTableView?.mj_header = SMTabelViewRefreshView(refreshingTarget: self, refreshingAction: "loadSearData")
        searchTableView?.separatorStyle = .None
        searchTableView?.hidden = true
        view.addSubview(searchTableView!)

    }
    
    //MARK: -设置搜索没有结果view
    func setsearErrorView() {
        searErrorView = SMDiscoverSearchErroView(frame: CGRectMake(0, 104, screenW, screenH))
        searErrorView?.backgroundColor = viewBackgroundColor
        searErrorView?.hidden = true
        searErrorView!.delegate = self
        view.addSubview(searErrorView!)
    }
    
    //MARK: -分类数据加载
    func loadData() {
        searchTableView?.hidden = true
        collectionView?.hidden = false
        searErrorView?.hidden = true
        weak var weakSelf = self
        let time = dispatch_time(DISPATCH_TIME_NOW,(Int64)(1 * NSEC_PER_SEC))
        dispatch_after(time, dispatch_get_main_queue()) { () -> Void in
            SMDiscoverDataModel.loadDiscoverData { (data, error) -> () in
                if error != nil {
                    SVProgressHUD.showErrorWithStatus("数据加载失败")
                    self.collectionView?.mj_header.endRefreshing()
                    return
                }
                weakSelf!.dataModel = data!
                weakSelf!.collectionView?.reloadData()
                weakSelf!.collectionView?.mj_header.endRefreshing()

            }
        }
    }
    
    //MARK: -搜索数据加载
    func loadSearData() {
         self.searchTableView?.mj_header.beginRefreshing()
        searchTableView?.hidden = false
        collectionView?.hidden = true
        weak var weakSelf = self
        let time = dispatch_time(DISPATCH_TIME_NOW,(Int64)(1 * NSEC_PER_SEC))
        dispatch_after(time, dispatch_get_main_queue()) { () -> Void in
            SMDicoverSearchDataModel.loadDiscoverSearchData { (data, error) -> () in
                if error != nil {
                    SVProgressHUD.showErrorWithStatus("数据加载失败")
                    self.searchTableView?.mj_header.endRefreshing()
                    return
                }
                weakSelf!.searchDataArray = data!
                weakSelf!.searchTableView?.reloadData()
                weakSelf!.searchTableView?.mj_header.endRefreshing()
            }
        }
    }

    
    
    var searchView: SMSearchView!
    var hotView: SMDiscoverHotView?
    var collectionView: UICollectionView?
    var scrollView: UIScrollView?
    var dataModel: SMDiscoverDataModel?
    let identifiter = "discoverCollectionCell"
    let hotidentifiter = "discoverHotCell"
    let headerIdentifiter = "discoverHeadView"
    var searchTableView: UITableView?
    var searchDataArray: SMDicoverSearchDataModel?
    var searErrorView: SMDiscoverSearchErroView?

}

extension SMDiscoverViewController: SMSearchViewDelegate, SMDsicoverHotCellDelegate, SMDiscoverCollectionCellDelegate,SMDiscoverSearchErroViewDelegate {
    
    //MARK: -搜索按钮点击
    func searchViewButtonClick(searchView: SMSearchView, keyText: String, button: UIButton) {
        if (keyText == "") {
            SVProgressHUD.showErrorWithStatus("关键字不能为空")
            return
        }
        //模拟搜索
        if keyText == "天河路" {
            loadSearData()
        }else {
            searErrorView?.hidden = false
            searchTableView?.hidden = true
            self.collectionView?.hidden = true
        }
    }
    
    //MARK: -取消按钮点击
    func searechviewCancel(searchView: SMSearchView, button: UIButton) {
        print("取消搜索")
        self.collectionView?.hidden = false
        self.searchTableView?.hidden = true
        searErrorView?.hidden = true
    }
    
    //MARK: -热门 按钮 被点击
    func hotCellButtonClikc(hotCell:SMDsicoverHotCell, button: UIButton) {
        print(button.currentTitle)
        self.searchView.chanegeSearViewState(button.currentTitle!)
        //模拟搜索
        if button.currentTitle == "天河路" {
            loadSearData()
        }else {
            searErrorView?.hidden = false
            searchTableView?.hidden = true
            self.collectionView?.hidden = true
        }
    }
    
    //MARK: -collectionView 中的Item 被点击
    func discoverCellClick(discoverCell: SMDiscoverCollectionCell, tagModel: SMDiscoverTagsModel) {
        print(tagModel.name)//此处点击跳转到分类
    }
    
    //MARK: -无搜索结果View被点击
    func discoverSearchErroViewClick() {
        self.collectionView?.hidden = false
        self.searchTableView?.hidden = true
        searErrorView?.hidden = true
    }
    
}

extension SMDiscoverViewController: UICollectionViewDataSource,UICollectionViewDelegate {
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
       var count = (dataModel?.list?.count) ?? 0
        if count > 0 {
            count += 1
        }
        return count
    }
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        if section == 0 {
            return 1
        }
        return dataModel?.list?[section - 1].tags?.count ?? 0
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {

        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier(hotidentifiter, forIndexPath: indexPath) as! SMDsicoverHotCell
            cell.delegate = self
            cell.model = dataModel
            return cell
        }else {
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier(identifiter, forIndexPath: indexPath) as! SMDiscoverCollectionCell
            cell.model = (dataModel?.list?[indexPath.section - 1].tags?[indexPath.row])! as SMDiscoverTagsModel
            cell.delegate = self
            return cell
        }
        
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        if  indexPath.section == 0{
            return CGSize(width:screenW - 2 * 10, height: 74)
        }
        else{
            let itemH:CGFloat = 80
            let itemW = (screenW - 4 * 10) / 3

            return CGSizeMake(itemW, itemH)
        }  
    }
    
//    func collectionView(collectionView:UICollectionView, layout collectionViewLayout:UICollectionViewLayout, insetForSectionAtIndex section:Int) ->UIEdgeInsets{
//    
//    return UIEdgeInsetsMake(10,10,0,10)
//    
//    }
    
    
    
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryViewOfKind(UICollectionElementKindSectionHeader, withReuseIdentifier: headerIdentifiter, forIndexPath: indexPath) as! SMDiscovercollectionHeaderView
        if indexPath.section == 0 {
            headerView.titleLabel?.text = "大家都在搜"
        }else {
            headerView.titleLabel?.text = dataModel?.list?[indexPath.section - 1].title
        }
        return headerView
    }
}

extension SMDiscoverViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(scrollView: UIScrollView) {
        view.endEditing(true)
    }
}

extension SMDiscoverViewController: UITableViewDataSource,UITableViewDelegate {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (searchDataArray?.list?.count) ?? 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = SMDiscoverSearchCell.discoverSearchCell(tableView)
        cell.model = searchDataArray?.list?[indexPath.row]
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 240
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let model = searchDataArray?.list?[indexPath.row]
        let detailVc = SMMeiTianDetailController()
        detailVc.meiTianModel = model
        self.navigationController?.pushViewController(detailVc, animated: true)
    }
}
