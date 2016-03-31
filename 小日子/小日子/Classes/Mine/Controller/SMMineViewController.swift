//
//  SMMineViewController.swift
//  小日子
//
//  Created by mike on 16/3/29.
//  Copyright © 2016年 MK. All rights reserved.
//

import UIKit

class SMMineViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = viewBackgroundColor
        setupNav()
        setupSubView()
        self.automaticallyAdjustsScrollViewInsets = false
    }
    
    
    

    func setupNav() {

        navigationItem.rightBarButtonItem = UIBarButtonItem(imageName: "setting_mine", highImageName: "setting_mine", targer: self, action: "settingClick")
    }
    
    func settingClick() {
        let settingVc = SMSettingController()
        navigationController?.pushViewController(settingVc, animated: true)
    }
    
    func setupSubView() {
        
        UIButton.roundButton(gosButton, radius: gosButton.width / 2, border: 1.0, borderColor: UIColor.blackColor())
        
        let tableView = UITableView(frame: self.actionView.bounds, style: .Plain)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.scrollEnabled = false
        self.actionView.addSubview(tableView)
    }
    
    @IBOutlet weak var gosButton: UIButton!
    @IBOutlet weak var actionView: UIView!
    lazy var tableViewData = ["我的订单", "意见反馈", "摇一摇"]
}


extension SMMineViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewData.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
       let  identifiter = "mineCell"
         var cell =  tableView.dequeueReusableCellWithIdentifier(identifiter)
        if cell == nil {
            cell = UITableViewCell(style: .Default, reuseIdentifier: identifiter)
            cell?.selectionStyle = .None
            cell?.textLabel?.text = tableViewData[indexPath.row]
            cell?.textLabel?.font = UIFont.systemFontOfSize(16)
        }
        
        return cell!
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 30
    }
}
 