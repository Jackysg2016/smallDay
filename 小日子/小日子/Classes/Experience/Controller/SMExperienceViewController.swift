//
//  SMExperienceViewController.swift
//  小日子
//
//  Created by mike on 16/3/28.
//  Copyright © 2016年 MK. All rights reserved.
//

import UIKit

class SMExperienceViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = viewBackgroundColor
        self.automaticallyAdjustsScrollViewInsets = false
        title = "体验"
        setupTableView()

    }
    
    //MARK:- tableview
    func setupTableView() {
        tableview = UITableView(frame: CGRectMake(0, 64, view.width, view.height), style: .Plain)
        tableview!.delegate = self
        tableview!.dataSource = self
        tableview!.contentInset = UIEdgeInsetsMake(0, 0, 100, 0)
        tableview!.separatorStyle = .None
        pageScrollView = PageScrollView(frame: CGRectMake(0, 0, view.width, 170), placeholder: UIImage(named:"quesheng")!) { (index) -> Void in
            let tempModel = self.data!.head![index]
            let model = SMMeiJiModel()
            model.title = tempModel.title
            model.theme_url = tempModel.mobileURL
            let vc = SMMeiJiDetailController()
            vc.meijiModel = model
            self.navigationController?.pushViewController(vc, animated: true)
        }
        tableview?.tableHeaderView = pageScrollView
        tableview?.mj_header = SMTabelViewRefreshView(refreshingTarget: self, refreshingAction: "LoadData")
        tableview?.mj_header.beginRefreshing()
        weak var weakSelf = self
        tableview?.mj_footer = MJRefreshAutoNormalFooter(refreshingBlock: { () -> Void in
            let time = dispatch_time(DISPATCH_TIME_NOW,(Int64)(2 * NSEC_PER_SEC))
            dispatch_after(time, dispatch_get_main_queue()) { () -> Void in
                weakSelf!.tableview?.mj_footer.state = MJRefreshState.NoMoreData
            }
        })
        tableview?.mj_footer.hidden = true
        view?.addSubview(tableview!)
        
    }
    
    //MARK:-  加载数据
    func LoadData() {
        weak var weakSelf = self
        let time = dispatch_time(DISPATCH_TIME_NOW,(Int64)(2 * NSEC_PER_SEC))
        dispatch_after(time, dispatch_get_main_queue()) { () -> Void in
            SMExperienDataModel.loadExperienceData({ (data, error) -> () in
                if error != nil {
                    SVProgressHUD.showErrorWithStatus("数据加载失败")
                    weakSelf!.tableview?.mj_header.endRefreshing()
                }
                weakSelf?.data = data
                weakSelf!.experienArray = (data?.list)!
                weakSelf!.pageScrollView?.headData = data
                weakSelf?.tableview?.reloadData()
                weakSelf?.tableview?.mj_header.endRefreshing()
            })
        }
        
    }

    var tableview: UITableView?
    var data : SMExperienDataModel?
    var pageScrollView: PageScrollView?
    var experienArray = [SMExperienceModel]()
}

extension SMExperienceViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return experienArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = SMExperienceCell.experienceCellFromXib(tableView)
        let model = experienArray[indexPath.row]
        cell.model = model
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 270
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let vc = SMExperienDetailController()
        let model = experienArray[indexPath.row]
        vc.experienceModel = model
        self.navigationController?.pushViewController(vc, animated: true)
    }
}