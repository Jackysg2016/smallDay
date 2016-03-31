//
//  SMSettingController.swift
//  小日子
//
//  Created by mike on 16/3/29.
//  Copyright © 2016年 MK. All rights reserved.
//

import UIKit

class SMSettingController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = viewBackgroundColor
        setupSub()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        SVProgressHUD.dismiss()
    }
    
    func setupSub() {

        let tableView = UITableView(frame: self.view.bounds, style: .Plain)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .None
        tableView.backgroundColor = viewBackgroundColor
        view.addSubview(tableView)
    }
    
    var dataArray :[SMSettingModel] = SMSettingModel.loadSettingData()

}

extension SMSettingController: UITableViewDataSource, UITableViewDelegate {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = SMSettingCell.settingCellFromXib(tableView)
        let model = dataArray[indexPath.row]
        cell.model = model
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let model = dataArray[indexPath.row]
        if model.type == .remove {
            SVProgressHUD.showWithStatus("正在清除缓存")
            FileTool.clearCache({ () -> () in
                SVProgressHUD.showSuccessWithStatus("清除成功！")
                tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .None)
            })
        }
    }
}