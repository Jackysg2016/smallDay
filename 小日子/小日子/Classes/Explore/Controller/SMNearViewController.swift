//
//  SMNearViewController.swift
//  小日子
//
//  Created by mike on 16/3/24.
//  Copyright © 2016年 MK. All rights reserved.
//

import UIKit

class SMNearViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = viewBackgroundColor
        setupNav()
        setupSubView()
    }

    //MARK:-  设置导航view
    func setupNav() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(imageName: "map_2-1", highImageName: "map_2", selectedImageName: "list_1", targer: self, action: "rightItemClick:")
        title = "附近"
    }
    
    //MARK:-  设置列表View和地图view
    func setupSubView() {
        tableView = UITableView(frame: view.bounds, style: .Plain)
        tableView?.delegate = self
        tableView?.dataSource = self
        tableView?.contentInset = UIEdgeInsetsMake(65, 0, 50, 0)
        tableView?.separatorStyle = .None
        tableView?.mj_header = SMTabelViewRefreshView(refreshingTarget: self, refreshingAction: "loadData")
        tableView?.mj_header.beginRefreshing()
        weak var weakSelf = self
        tableView?.mj_footer = MJRefreshAutoNormalFooter(refreshingBlock: { () -> Void in
            let time = dispatch_time(DISPATCH_TIME_NOW,(Int64)(2 * NSEC_PER_SEC))
            dispatch_after(time, dispatch_get_main_queue()) { () -> Void in
                weakSelf!.tableView?.mj_footer.state = MJRefreshState.NoMoreData
            }
        })
        tableView?.mj_footer.hidden = true
        view.addSubview(tableView!)
        
        mapView = SMMapView(frame: self.view.bounds)
        mapView?.delegateMap = self 
        view.insertSubview(mapView!, belowSubview: tableView!)
    }
    
    //MARK:-  附近 tableview  下拉下载数据
    func loadData() {
        weak var weakSelf = self
        let time = dispatch_time(DISPATCH_TIME_NOW,(Int64)(1 * NSEC_PER_SEC))
        dispatch_after(time, dispatch_get_main_queue()) { () -> Void in
            SMNearShopModel.loadExploreDataForNear({ (data, error) -> () in
                if error != nil {
                    SVProgressHUD.showErrorWithStatus("数据加载失败")
                    weakSelf!.tableView?.mj_header.endRefreshing()
                }
                weakSelf!.nearDataArray = (data?.list)!
                weakSelf!.tableView?.reloadData()
                weakSelf!.tableView?.mj_header.endRefreshing()
                weakSelf!.tableView?.mj_footer.hidden = false
                weakSelf?.mapView?.nearsModel = data
            })
        }
        
    }

    //MARK:-  点击翻转切换view
    func rightItemClick(button: UIButton) {
        button.selected = !button.selected
        if button.selected {
            UIView.transitionFromView(tableView!, toView: mapView!, duration: 1.0, options: .TransitionFlipFromRight, completion: nil)
        }
        else {
            UIView.transitionFromView(mapView!, toView: tableView!, duration: 1.0, options: .TransitionFlipFromRight, completion: nil)
        }
    }
    
    var tableView: UITableView?
    var nearDataArray = [SMMeiTianModel]()
    var mapView: SMMapView?
}

extension SMNearViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nearDataArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = SMNearViewCell.nearCell(tableView)
        cell.model = nearDataArray[indexPath.row]
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 240
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let model = nearDataArray[indexPath.row] as SMMeiTianModel
        let detailVc = SMMeiTianDetailController()
        detailVc.meiTianModel = model
        self.navigationController?.pushViewController(detailVc, animated: true)
    }
}

//MARK:-  点击地图cell中的详情到 详细页面
extension SMNearViewController: SMMapViewDelegate {
    func didMapViewColletionCellDetailButton(mapview: SMMapView, index: Int) {
        let meiTianDetailVc = SMMeiTianDetailController()
        let model = nearDataArray[index] as SMMeiTianModel
        meiTianDetailVc.meiTianModel = model
        self.navigationController?.pushViewController(meiTianDetailVc, animated: true)
    }
}
