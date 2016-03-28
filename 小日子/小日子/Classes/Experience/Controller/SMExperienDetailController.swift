//
//  SMExperienDetailController.swift
//  小日子
//
//  Created by mike on 16/3/17.
//  Copyright © 2016年 MK. All rights reserved.
//

import UIKit


class SMExperienDetailController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.clipsToBounds = true
        view.backgroundColor = viewBackgroundColor
        setupSubView()
        setupNavView()
        SVProgressHUD.showWithStatus("正在加载中")
        webViewLoadData()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.hidden = true
        navigationItem.leftBarButtonItem = nil
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.hidden = false
    }
    
    //MARK: - 设置子控件
    func setupSubView() {
        view.addSubview(webView)
        view.addSubview(topImageView)
        view.addSubview(coverView)
        
    }
    //MARK: - 设置导航条
    func setupNavView() {
        view.addSubview(customNav)
        view.addSubview(backBtn)
        view.addSubview(likeBtn)
        view.addSubview(shareBtn)
        
    }
    
    //MARK:- 点击返回
    func backBtnClick() {
        navigationController?.popViewControllerAnimated(true)
    }
    //MARK:- 点击分享
    func shareBtnClick() {
        let shareVc = SMShareViewController()
        self.definesPresentationContext = true; //self is presenting view controller
        shareVc.view.backgroundColor = UIColor.clearColor()
        shareVc.modalPresentationStyle = .OverCurrentContext;
        self.presentViewController(shareVc, animated: true, completion: nil )
    }
    
    //MARK:- 点击收藏
    func likeBtnClick() {
        likeBtn.selected = !likeBtn.selected
    }
    
    func webViewLoadData() {
        var htmlSrt = experienceModel?.mobileURL
        if htmlSrt != nil {
            var titleStr: String?
            
            if experienceModel?.title != nil {
                titleStr = String(format: "<p style='font-size:20px;'> %@</p>", experienceModel!.title!)
            }
            
            if experienceModel?.tag != nil {
                titleStr = titleStr?.stringByAppendingFormat("<p style='font-size:13px; color: gray';>%@</p>", experienceModel!.tag!)
            }
            
            if titleStr != nil {
                let newStr: NSMutableString = NSMutableString(string: htmlSrt!)
                newStr.insertString(titleStr!, atIndex: 0)
                htmlSrt = newStr as String
            }
            
        }
        let newStr = NSMutableString.changeHeigthAndWidthWithSrting(NSMutableString(string: htmlSrt!))
        webView.loadHTMLString(newStr as String, baseURL: nil)
    }
    
    //MARK:- 自定义导航view
    lazy var customNav: UIView = {
        let customNav = UIView(frame: CGRectMake(0, 0, screenW, NavigationH))
        customNav.backgroundColor = UIColor.whiteColor()
        customNav.alpha = 0.0
        return customNav
    }()
    
    //MARK:- 返回按钮
    lazy var backBtn: UIButton = {
        let backBtn = UIButton()
        backBtn.frame = CGRectMake(-7, 20, 44, 44)
        backBtn.setImage(UIImage(named: "back_0"), forState: .Normal)
        backBtn.setImage(UIImage(named: "back_2"), forState: .Normal)
        backBtn.addTarget(self , action: "backBtnClick", forControlEvents: .TouchUpInside)
        
        return backBtn
    }()
    //MARK:- 分享按钮
    lazy var shareBtn: UIButton = {
        let shareBtn = UIButton()
        shareBtn.frame = CGRectMake(screenW - 54, 20, 44, 44)
        shareBtn.setImage(UIImage(named: "share_0"), forState: .Normal)
        shareBtn.setImage(UIImage(named: "share_2"), forState: .Normal)
        shareBtn.addTarget(self , action: "shareBtnClick", forControlEvents: .TouchUpInside)
        
        return shareBtn
    }()
    //MARK:- 收藏按钮
    lazy var likeBtn: UIButton = {
        let likeBtn = UIButton()
        likeBtn.frame = CGRectMake(screenW - 105, 20, 44, 44)
        likeBtn.setImage(UIImage(named: "collect_0"), forState: .Normal)
        likeBtn.setImage(UIImage(named: "collect_2"), forState: .Selected)
        likeBtn.addTarget(self , action: "likeBtnClick", forControlEvents: .TouchUpInside)
        
        return likeBtn
    }()
    
    lazy var coverView: UIView = {
        let coverView = UIView()
        coverView.frame = CGRectMake(0, topImageHeight, screenW, screenH)
        coverView.backgroundColor = UIColor.whiteColor()
        return coverView
    }()
    
    
    //MARK:- webView
    lazy var webView: UIWebView = {
        let webView = UIWebView()
        webView.frame = self.view.bounds
        webView.scrollView.contentInset = UIEdgeInsets(top: topImageHeight  , left: 0, bottom: 0, right: 0)
        webView.scrollView.showsHorizontalScrollIndicator = false
        webView.backgroundColor = viewBackgroundColor
        webView.paginationBreakingMode = UIWebPaginationBreakingMode.Column//设置此属性，webView按行显示，默认为按页显示
        webView.delegate = self
        webView.scrollView.setContentOffset(CGPoint(x: 0, y: -(topImageHeight)), animated: false)
        webView.scrollView.delegate = self
        return webView
    }()
    
    
    
    
    //MARK:- 顶部图片
    var topImageView: UIImageView = {
        let topImageView = UIImageView(frame: CGRectMake(0, 0, screenW, 225))
        topImageView.image = UIImage(named: "quesheng")
        topImageView.contentMode = .ScaleToFill
        topImageView.clipsToBounds = true
        return topImageView
    }()
    
    var experienceModel: SMExperienceModel? {
        didSet {
            if let imgStr = (experienceModel?.imgs?.first)  {
                topImageView.sd_setImageWithURL(NSURL(string: imgStr), placeholderImage: UIImage(named: "quesheng"))
            }
            
        }
    }
    
}

extension SMExperienDetailController: UIWebViewDelegate, UIScrollViewDelegate {
    
    func webViewDidStartLoad(webView: UIWebView) {
        coverView.hidden = false
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        webView.stringByEvaluatingJavaScriptFromString("document.getElementsByTagName('body')[0].style.background='#F5F5F5';")
        coverView.hidden = true
        SVProgressHUD.dismiss()
        
    }
    
    func webView(webView: UIWebView, didFailLoadWithError error: NSError?) {
        print(error)
    }
    
    //MARK: - 下拉上啦，顶部图片和tabbar选项，导航条变化设置
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        //往上偏移距离刚好等于顶部图片的高度和导航条的高度，则导航条透明度为1
        customNav.alpha = 1 + (offsetY + NavigationH ) / (topImageHeight - NavigationH)//往上移动的距离
        print("offsetY:\(offsetY)")
        if offsetY  >= -(NavigationH )  {//偏移距离小于或者等于导航条的高度，则，改变下面按钮 图片
            backBtn.setImage(UIImage(named: "back_1"), forState: .Normal)
            likeBtn.setImage(UIImage(named: "collect_1"), forState: .Normal)
            shareBtn.setImage(UIImage(named: "share_1"), forState: .Normal)
        } else if offsetY < -(NavigationH )  {
            backBtn.setImage(UIImage(named: "back_0"), forState: .Normal)
            likeBtn.setImage(UIImage(named: "collect_0"), forState: .Normal)
            shareBtn.setImage(UIImage(named: "share_0"), forState: .Normal)
        }
        // 顶部imageView的跟随动画
        if offsetY <= -(225) {// 恢复或者下拉是放大
            topImageView.frame.origin.y = 0
            topImageView.frame.size.height = -offsetY
            topImageView.frame.size.width = screenW - offsetY - topImageHeight
            topImageView.frame.origin.x = (0 + topImageHeight + offsetY) * 0.5
        } else {//向上移动
            topImageView.frame.origin.y = -offsetY - (topImageHeight )
            
        }
    }
}
