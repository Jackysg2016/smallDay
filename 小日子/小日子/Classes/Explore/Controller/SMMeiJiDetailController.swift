//
//  SMMeiJiDetailController.swift
//  小日子
//
//  Created by mike on 16/3/16.
//  Copyright © 2016年 MK. All rights reserved.
//

import UIKit

class SMMeiJiDetailController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNav()
        view.addSubview(webView)
        webView.delegate = self
        webView.frame = view.bounds
        progressView.frame =  CGRectMake(0, 42, screenW, 2)
        navigationController?.navigationBar.addSubview(progressView)
        webView.addSubview(errorViw)
        errorViw.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
    }
    
    func setupNav() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "share_1")?.imageWithRenderingMode(.AlwaysOriginal), style: .Plain, target: self, action: "shareClick")
    }
    
    var count : Int = 0 {
        didSet {
//            if (self.isMJRefresh) {
//                self.progressView.hidden = YES;
//                return;
//            }
            if count == 0 {
                self.progressView.hidden = false;
                UIView.animateWithDuration(0.8, animations: { () -> Void in
                    self.progressView.setProgress(0.8, animated: true)
                })
               
            }else if count == 1 {
                
                UIView.animateWithDuration(0.3, animations: { () -> Void in
                    self.progressView.setProgress(1, animated: true)
                    self.progressView.alpha = 0.9999
                    }, completion: { (finished) -> Void in
                       let time = dispatch_time(DISPATCH_TIME_NOW,(Int64) ( 0.5 * Double( NSEC_PER_SEC)))
                        dispatch_after(time, dispatch_get_main_queue(), { () -> Void in
                            self.progressView.alpha = 1;
                            self.progressView.hidden = true;
                            self.progressView.progress = 0;
                        })
                })
               
            }else if count == -1
            {
                self.progressView.hidden = true;
                self.progressView.setProgress(0, animated: true)
            }

        }
    }
    
    var request: NSURLRequest?
    
    var meijiModel: SMMeiJiModel? {
        didSet {
            
                let url_str = meijiModel!.theme_url
                if url_str != nil {
                    let url = NSURL(string: url_str!)
                    request = NSURLRequest(URL: url!)
                    webView.loadRequest(request!)
                }else {
                    
                }
            
        }
    }
    
    var webView: SMWebView = {
        let webView = SMWebView()
        
        webView.backgroundColor = viewBackgroundColor
        return webView
    }()
    
    var progressView: UIProgressView = {
        let progressView = UIProgressView()
        progressView.transform = CGAffineTransformMakeScale(1.0, 1.0)
        progressView.tintColor = UIColor.orangeColor()
        progressView.trackTintColor = UIColor.clearColor()
        return progressView
    }()
    
    var errorViw :SMErrorView = {
        let errorView = SMErrorView()
        errorView.frame = CGRectMake(0,screenH / 2 - 50, screenW, 50)
        errorView.hidden = true
        
        return errorView
    }()
    
    func shareClick() {
        let shareVc = SMShareViewController()
        self.definesPresentationContext = true; //self is presenting view controller
        shareVc.view.backgroundColor = UIColor.clearColor()
        shareVc.modalPresentationStyle = .OverCurrentContext;
        self.presentViewController(shareVc, animated: true, completion: nil )
    }
    
}

extension SMMeiJiDetailController: UIWebViewDelegate, SMErrorViewDelegate {
    
    func webViewDidStartLoad(webView: UIWebView) {
        count = 0
        errorViw.hidden = true
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        count = 1
    }
    
    func webView(webView: UIWebView, didFailLoadWithError error: NSError?) {
        print(error)
        errorViw.hidden = false
        SVProgressHUD.showErrorWithStatus("网络加载失败！")
        count = -1
    }
    
    func tryButtonClick(errorView: SMErrorView, buton: UIButton) {
        webView.loadRequest(request!)
        print("tryButtonClick")
    }
}
