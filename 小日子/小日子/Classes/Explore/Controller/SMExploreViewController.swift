//
//  SMExploreViewController.swift
//  小日子
//
//  Created by mike on 16/3/11.
//  Copyright © 2016年 MK. All rights reserved.
//

import UIKit


private let leftTabelViewCellID = "leftTabelViewCellID"
private let rightTabelViewCellID = "rightTabelViewCellID"

class SMExploreViewController: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        view.backgroundColor = viewBackgroundColor
        self.automaticallyAdjustsScrollViewInsets = false//设置不需要自动调整
        
        setupNavTitleView()
        setupParentScrollView()
        setupLeftTableView()
        setupRightTableView()
    }
    
    //MARK:- 设置导航中间view
    func setupNavTitleView() {
        navTitleView = SMExporeNavTitleView(leftBtnName: "美天", rightBtnName: "美辑")
        navTitleView!.delegate = self
        navTitleView!.frame = CGRectMake(0, 0, 120, 44)
        navigationItem.titleView = navTitleView
    }
    
    //MARK:- 添加底部ScrollView
    func setupParentScrollView(){
        parentScrollView = UIScrollView()
        parentScrollView?.bounces = false
        parentScrollView?.pagingEnabled = true
        parentScrollView?.showsHorizontalScrollIndicator = false
        parentScrollView?.showsVerticalScrollIndicator = false
        parentScrollView?.contentSize = CGSizeMake(screenW * 2, 0)
        parentScrollView?.frame = CGRectMake(0, 0, screenW, screenH)
        parentScrollView?.delegate = self
        parentScrollView?.backgroundColor = viewBackgroundColor
        view.addSubview(parentScrollView!)
        
    }
    
    //MARK:- 添加左边 美天 tableview
    func setupLeftTableView() {
        leftTableView = UITableView(frame: CGRectMake(0, 64, screenW, screenH), style: .Grouped)
        leftTableView?.delegate = self
        leftTableView?.dataSource = self
        leftTableView?.backgroundColor = viewBackgroundColor
        leftTableView?.contentInset = UIEdgeInsetsMake(0, 0, 100, 0)
        leftTableView?.separatorStyle = .None
        leftTableView?.mj_header = SMTabelViewRefreshView(refreshingTarget: self, refreshingAction: "leftTableViewLoadData")
        leftTableView?.mj_header.beginRefreshing()
        weak var weakSelf = self
        leftTableView?.mj_footer = MJRefreshAutoNormalFooter(refreshingBlock: { () -> Void in
            let time = dispatch_time(DISPATCH_TIME_NOW,(Int64)(2 * NSEC_PER_SEC))
            dispatch_after(time, dispatch_get_main_queue()) { () -> Void in
                weakSelf!.leftTableView?.mj_footer.state = MJRefreshState.NoMoreData
            }
        })
        leftTableView?.mj_footer.hidden = true
        parentScrollView?.addSubview(leftTableView!)
    }
    
     //MARK:- 添加右边 美辑 tableview
    func setupRightTableView() {
        rightTableView = UITableView(frame: CGRectMake(screenW, 64, screenW, screenH), style: .Plain)
        rightTableView?.delegate = self
        rightTableView?.dataSource = self
        rightTableView?.contentInset = UIEdgeInsetsMake(0, 0, 100, 0)
        rightTableView?.separatorStyle = .None
        rightTableView?.mj_header = SMTabelViewRefreshView(refreshingTarget: self, refreshingAction: "rightTableViewLoadData")
        rightTableView?.mj_header.beginRefreshing()
        weak var weakSelf = self
        rightTableView?.mj_footer = MJRefreshAutoNormalFooter(refreshingBlock: { () -> Void in
            let time = dispatch_time(DISPATCH_TIME_NOW,(Int64)(2 * NSEC_PER_SEC))
            dispatch_after(time, dispatch_get_main_queue()) { () -> Void in
                weakSelf!.rightTableView?.mj_footer.state = MJRefreshState.NoMoreData
            }
        })
        rightTableView?.mj_footer.hidden = true
        parentScrollView?.addSubview(rightTableView!)
        
    }
    
     //MARK:-  美天 tableview  下拉下载数据
    func leftTableViewLoadData() {
        
       weak var weakSelf = self
        let time = dispatch_time(DISPATCH_TIME_NOW,(Int64)(2 * NSEC_PER_SEC))
        dispatch_after(time, dispatch_get_main_queue()) { () -> Void in
            SMEveryDayData.loadExploreDataForMeiTian { (data, error) -> () in
                if error != nil {
                    SVProgressHUD.showErrorWithStatus("数据加载失败")
                    self.leftTableView?.mj_header.endRefreshing()
                    return
                }
                weakSelf!.everyDayArray = (data?.list)!
                weakSelf!.leftTableView?.reloadData()
                weakSelf!.leftTableView?.mj_header.endRefreshing()
                weakSelf!.leftTableView?.mj_footer.hidden = false
            }
        }
    }
    
     //MARK:-  美辑 tableview  下拉下载数据
    func rightTableViewLoadData() {
        weak var weakSelf = self
        let time = dispatch_time(DISPATCH_TIME_NOW,(Int64)(2 * NSEC_PER_SEC))
        dispatch_after(time, dispatch_get_main_queue()) { () -> Void in
            SMMeiJiData.loadExploreDataForMeiJi({ (data, error) -> () in
                if error != nil {
                    SVProgressHUD.showErrorWithStatus("数据加载失败")
                    weakSelf!.rightTableView?.mj_header.endRefreshing()
                }
                weakSelf!.meijiDataArray = (data?.list)!
                weakSelf!.rightTableView?.reloadData()
                weakSelf!.rightTableView?.mj_header.endRefreshing()
                 weakSelf!.rightTableView?.mj_footer.hidden = false
            })
        }
        
    }
    
    //导航中间view
    var navTitleView: SMExporeNavTitleView? //导航中间view
    //左边 美天 tableview
    var leftTableView: UITableView?
    //右边 美辑 tableview
    var rightTableView: UITableView?
    //底部ScrollView
    var parentScrollView: UIScrollView?
    //美天 数据
    var everyDayArray = [SMEveryDayModel]()
    //美辑 数据
    var meijiDataArray = [SMMeiJiModel]()
    
    
    
}

extension SMExploreViewController: SMExporeNavTitleViewDelegate,UIScrollViewDelegate , UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if tableView == leftTableView {
            return everyDayArray.count
        }else {
            return 1
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == leftTableView {
            if everyDayArray[section].meiJiArray?.count > 0 {
                return 2
            }
            
            return 1
        }else {
            return meijiDataArray.count
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if tableView == leftTableView {
          
            if indexPath.row == 1 {
                let cell = SMExploreWithMidTitleCell.exploreWithMidTitleCell(tableView)
                 cell.model = everyDayArray[indexPath.section].meiJiArray!.first
                return cell
            }else {
                  let cell = SMExploreWithTopTitleCell.exploreWithTopTitleCell(tableView)
                 cell.model = everyDayArray[indexPath.section]
                return cell
            }
            
        }else {
            let cell = SMExploreWithMidTitleCell.exploreWithMidTitleCell(tableView)
            cell.model = meijiDataArray[indexPath.row]
            return cell
        }

    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if tableView === rightTableView {
            return 240
        } else {
            if indexPath.row == 1 {
                return 220
            } else {
                return 253
            }
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if tableView == rightTableView {
            if indexPath.row < meijiDataArray.count {
            let meijiDetailVc = SMMeiJiDetailController()
            let model = meijiDataArray[indexPath.row]
            meijiDetailVc.meijiModel = model
            self.navigationController?.pushViewController(meijiDetailVc, animated: true)
            }
        }
    }
    
    
    //MARK: -   根据滑动的位置，切换导航中间view中的  美天 和 美辑 按钮
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        
        if scrollView == parentScrollView {
            let OffsetX = scrollView.contentOffset.x
            
            let index: Int = Int( OffsetX / screenW)
            if index == 0 {
                leftTableView?.reloadData()
                navTitleView?.bottomViewScrollAtButton(index)
                
            }
            else if index == 1 {
                rightTableView?.reloadData()
                navTitleView?.bottomViewScrollAtButton(index)
            }
        }
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
 
        return 0.01
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    
    //MARK: -   导航中间view的代理方法，点击切换左右tableview
    func exporeNavTitleViewDidButtonForIndex(exporeNavTitleView: SMExporeNavTitleView, button: UIButton, index: Int) {
        let index = button.tag
        parentScrollView?.contentOffset.x = CGFloat(index) * screenW
    }
}