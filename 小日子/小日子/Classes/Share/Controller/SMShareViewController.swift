//
//  SMShareViewController.swift
//  小日子
//
//  Created by mike on 16/3/22.
//  Copyright © 2016年 MK. All rights reserved.
//

import UIKit

class SMShareViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
       
        setupSubView()
    }

    func setupSubView() {
        let shareView = SMShareScrollView()
        shareView.frame = self.shareView.bounds
        self.shareView.addSubview(shareView)
    }
    
    @IBOutlet weak var parentView: UIView!
    @IBOutlet weak var shareView: UIView!

    @IBAction func dismissVc(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
  
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let touches:NSSet = (event?.allTouches())!
        let touch = touches.anyObject()
        let point = touch?.locationInView(self.view)
        if point?.y < CGRectGetMinY(self.parentView.frame) {
            dismissViewControllerAnimated(true, completion: nil)
        }
        
    }
}
