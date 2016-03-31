//
//  SMMeiTianDetailController.swift
//  小日子
//
//  Created by mike on 16/3/17.
//  Copyright © 2016年 MK. All rights reserved.
//

import UIKit

public let topImageHeight: CGFloat = 225//顶部图片高度
public let detailBarViewHeight: CGFloat = 45//中间tabBar高度

class SMMeiTianDetailController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.clipsToBounds = true
        self.automaticallyAdjustsScrollViewInsets = false
        view.backgroundColor = viewBackgroundColor
        setupSubView()
        setupNavView()
        SVProgressHUD.showWithStatus("正在加载中")
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.hidden = true
        navigationItem.leftBarButtonItem = nil
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.hidden = false
        SVProgressHUD.dismiss()
    }
    
    //MARK: - 设置子控件
    func setupSubView() {

       view.addSubview(webView)
       view.addSubview(tableView)
       view.addSubview(topImageView)
       view.addSubview(tabScrollView)
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
    
    private lazy var isLoadFinsih = false
    private var moreGuessLikeViewArray = [SMMoreGuessLikeView]()
    private var lastOffset: CGPoint?
    
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
    
    
    //MARK:- TABBAR选项view
    lazy var tabScrollView: SMMeiTianDetailBarView = {
        let tabScrollView = SMMeiTianDetailBarView(frame: CGRectMake(0, topImageHeight, self.view.width, detailBarViewHeight), leftTitle: "店 · 发现", rightTile: "店 · 详情")
        tabScrollView.backgroundColor = viewBackgroundColor
        tabScrollView.delegate = self
        self.view.addSubview(tabScrollView)
        return tabScrollView
    }()
    
    //MARK:- 左边webView
    lazy var webView: UIWebView = {
     let webView = UIWebView()
        webView.frame = self.view.bounds
        webView.scrollView.contentInset = UIEdgeInsets(top: topImageHeight + detailBarViewHeight, left: 0, bottom: 0, right: 0)
        webView.scrollView.showsHorizontalScrollIndicator = false
        webView.backgroundColor = viewBackgroundColor
        webView.paginationBreakingMode = UIWebPaginationBreakingMode.Column//设置此属性，webView按行显示，默认为按页显示
        webView.delegate = self
                webView.scrollView.setContentOffset(CGPoint(x: 0, y: -(topImageHeight + detailBarViewHeight)), animated: false)
        webView.scrollView.delegate = self
        return webView
    }()
    
    //MARK:- 底部scrollView
    lazy var detailScrollView: UIScrollView = {
        let detailScrollView = UIScrollView(frame: self.view.bounds)
        detailScrollView.contentSize = CGSizeMake(screenW * 2, 0)
        detailScrollView.showsHorizontalScrollIndicator = false
        detailScrollView.backgroundColor = viewBackgroundColor
        detailScrollView.alwaysBounceVertical = true
        detailScrollView.delegate = self
        detailScrollView.pagingEnabled = true
        return detailScrollView
        
    }()
    //MARK: - 右边的tableview
    lazy var tableView: UITableView = {
       let tableView = UITableView(frame: self.view.bounds, style: .Plain)
        tableView.contentInset = UIEdgeInsets(top: topImageHeight  + detailBarViewHeight, left: 0, bottom: 0, right: 0)
        tableView.backgroundColor = UIColor.colorWithRGB(245, g: 245, b: 245, alpha: 1.0)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .None
        tableView.hidden = true
        let view = SMDetailTableHeaderView.detailTableHeaderViewFromXib()
        view.frame = CGRectMake(0, 0, screenW, 80)
        tableView.tableHeaderView = view
        return tableView
    }()
    
    //MARK:- 顶部图片
    lazy var topImageView: UIImageView = {
       let topImageView = UIImageView(frame: CGRectMake(0, 0, screenW, topImageHeight))
        topImageView.image = UIImage(named: "quesheng")
        topImageView.contentMode = .ScaleToFill
        topImageView.clipsToBounds = true
        return topImageView
    }()
    
    lazy var guessLikeView: SMGuessLikeView = SMGuessLikeView.guessLikeViewFromXib()
    
    var meiTianModel: SMMeiTianModel? {
        didSet {

            detailScrollView.hidden = true
            if let imgStr = (meiTianModel?.img)  {
                topImageView.sd_setImageWithURL(NSURL(string: imgStr), placeholderImage: UIImage(named: "quesheng"))
            }
            var htmlSrt = meiTianModel?.content
            
            if htmlSrt != nil {
                var titleStr: String?
                
                if meiTianModel?.title != nil {
                    titleStr = String(format: "<p style='font-size:20px;'> %@</p>", meiTianModel!.title!)
                }
                
                if meiTianModel?.tag != nil {
                    titleStr = titleStr?.stringByAppendingFormat("<p style='font-size:13px; color: gray';>%@</p>", meiTianModel!.tag!)
                }
                
                if titleStr != nil {
                    let newStr: NSMutableString = NSMutableString(string: htmlSrt!)
                    newStr.insertString(titleStr!, atIndex: 0)
                    htmlSrt = newStr as String
                }

            }
            let newStr = NSMutableString.changeHeigthAndWidthWithSrting(NSMutableString(string: htmlSrt!))
            webView.loadHTMLString(newStr as String, baseURL: nil)
            webView.hidden = false
            
            if meiTianModel?.more?.count > 0 {
                webView.scrollView.addSubview(guessLikeView)
                guessLikeView.hidden = false
                for  moreModel  in (meiTianModel?.more)! {
                    let moreGuessView = SMMoreGuessLikeView.moreGuessLikeViewFromXib()
                    moreGuessView.moreModel = moreModel
                    webView.scrollView.addSubview(moreGuessView)
                    moreGuessLikeViewArray.append(moreGuessView)
                    
                }
            }else {
                guessLikeView.hidden = true
            }
            
        }
    }

}

extension SMMeiTianDetailController: UIWebViewDelegate, UIScrollViewDelegate, SMMeiTianDetailBarViewDelegate,UITableViewDataSource,UITableViewDelegate {
    
    //MARK: - 点击切换 选项卡按钮
    func meiTainDetailBarViewDidButton(meiTainDetailBarView: SMMeiTianDetailBarView, button: UIButton, type: SMMeiTianDetailBarViewType) {
        if type == SMMeiTianDetailBarViewType.Left {
            webView.hidden = false
            tableView.hidden = true
            tableView.setContentOffset(CGPoint(x: 0, y: -(topImageHeight + detailBarViewHeight)), animated: false)

            print("左边")
        }else {
            webView.hidden = true
            tableView.hidden = false
            webView.scrollView.setContentOffset(CGPoint(x: 0, y: -(topImageHeight + detailBarViewHeight)), animated: false)

            print("右边")
        }
    }
    
    func webViewDidStartLoad(webView: UIWebView) {
        coverView.hidden = false
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        webView.stringByEvaluatingJavaScriptFromString("document.getElementsByTagName('body')[0].style.background='#F5F5F5';")
        coverView.hidden = true
        SVProgressHUD.dismiss()
        
        guessLikeView.frame = CGRect(x: 0, y: webView.scrollView.contentSize.height, width: screenW, height: 50)
        if !guessLikeView.hidden {
            webView.scrollView.contentSize.height += 50
        }
        for var i = 0; i < moreGuessLikeViewArray.count; i++ {
            let moreGuessLikeView = moreGuessLikeViewArray [i]
            if i == 0 {
                moreGuessLikeView.frame = CGRect(x: 0, y: webView.scrollView.contentSize.height, width: screenW, height: 240)
                webView.scrollView.contentSize.height += 240
            }else {
            moreGuessLikeView.frame = CGRect(x: 0, y: webView.scrollView.contentSize.height + 5, width: screenW, height: 240)
            webView.scrollView.contentSize.height += 240 + 5
            }
        }
        
    }
    
    //MARK: - 下拉上啦，顶部图片和tabbar选项，导航条变化设置
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        //往上偏移距离刚好等于顶部图片的高度和导航条的高度，则导航条透明度为1
        customNav.alpha = 1 + (offsetY + NavigationH + detailBarViewHeight) / (topImageHeight - NavigationH)//往上移动的距离
        print("offsetY:\(offsetY)")
        if offsetY  >= -(NavigationH + detailBarViewHeight)  {//偏移距离小于或者等于导航条的高度，则，改变下面按钮 图片
            backBtn.setImage(UIImage(named: "back_1"), forState: .Normal)
            likeBtn.setImage(UIImage(named: "collect_1"), forState: .Normal)
            shareBtn.setImage(UIImage(named: "share_1"), forState: .Normal)
        } else if offsetY < -(NavigationH + detailBarViewHeight)  {
            backBtn.setImage(UIImage(named: "back_0"), forState: .Normal)
            likeBtn.setImage(UIImage(named: "collect_0"), forState: .Normal)
            shareBtn.setImage(UIImage(named: "share_0"), forState: .Normal)
        }
        // 顶部imageView的跟随动画
        if offsetY <= -(topImageHeight + detailBarViewHeight) {// 恢复或者下拉是放大
//            let sca: CGFloat = 1 + (-offsetY - topImageHeight)/topImageHeight
//            print("sca: \(sca)")
//            topImageView.transform = CGAffineTransformMakeScale(sca, sca)
            topImageView.frame.origin.y = 0
            topImageView.frame.size.height = -offsetY - detailBarViewHeight
            topImageView.frame.size.width = screenW - offsetY - topImageHeight
            topImageView.frame.origin.x = (0 + topImageHeight + offsetY) * 0.5
//            print(topImageView.frame)
        } else {//向上移动
            topImageView.frame.origin.y = -offsetY - (topImageHeight + detailBarViewHeight)
            
        }
        
        // 处理tabScrollView
        if offsetY >= -(detailBarViewHeight + NavigationH) {//当偏移位置的y小于tabScrollView的高度加导航view高度，则y 就是导航条的高度
            tabScrollView.frame = CGRect(x: 0, y: NavigationH, width: screenW, height: detailBarViewHeight)
        } else {//tabScrollView的y 等于顶部imageView的的最大y值
            tabScrollView.frame = CGRect(x: 0, y: CGRectGetMaxY(topImageView.frame), width: screenW, height: detailBarViewHeight)
        }

    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .Default, reuseIdentifier: "ID")
        cell.backgroundColor = UIColor.colorWithRGB(245, g: 245, b: 245, alpha: 1.0)
        if indexPath.row == 0 {
        cell.textLabel?.text = "店铺电话：15889935512"
        }else {
        cell.textLabel?.text = "店铺地址：广州市天河区科韵路"
        }
        return cell
    }
    

}
