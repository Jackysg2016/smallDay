//
//  SMMapView.swift
//  小日子
//
//  Created by mike on 16/3/25.
//  Copyright © 2016年 MK. All rights reserved.
//

import UIKit

private let identifiter = "nearCollectionCell"

class SMMapView:  MAMapView{

    //点标注数据
    var pointAnnotationArray = [MAPointAnnotation]()
    weak var delegateMap: SMMapViewDelegate?
    var currentIndexForCell: Int = 0
    
    //附近店数据
    var nearsModel: SMNearShopModel? {
        didSet {
            pointAnnotationArray.removeAll()
            collectionView.reloadData()
            for var i = 0; i < nearsModel?.list?.count; i++ {
                let model = nearsModel?.list![i]
                if let position = model?.position?.stringToCLLocationCoordinate2D(",") {
                    let pointAnnotion = MAPointAnnotation()
                    pointAnnotion.coordinate = position
                    addAnnotation(pointAnnotion)
                    pointAnnotationArray.append(pointAnnotion)
                    if i == 0 {
                        selectAnnotation(pointAnnotion, animated: true)
                    }
                }
                
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        delegate = self
        showsCompass = false //是否显示罗盘
        showsUserLocation = true //是否显示用户位置
        showsScale = false //是否显示比例饿
        logoCenter.x = screenW - logoSize.width + 20  //设置中心点
        zoomLevel = 15 //缩放级别
        mapType = MAMapType.Standard
        //23.1353080000,113.2707930000 广州
        setCenterCoordinate(CLLocationCoordinate2D(latitude: 23.1353080000, longitude: 113.2707930000), animated: true)
        addSubview(userLocationBtn)
        addSubview(collectionView)
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        clearDisk()
        showsUserLocation = false
        
    }
    
    //MARK: - 返回用户位置
    func backUseLocation () {
        setCenterCoordinate(userLocation.coordinate, animated: true)
    }
    
    //MARK: - 用户当前位置按钮
    lazy var userLocationBtn: UIButton = {
        let btnWH :CGFloat = 57
        let btn = UIButton(frame: CGRectMake(20, screenH - 180 - btnWH, btnWH, btnWH))
        btn.setBackgroundImage(UIImage(named: "dingwei_1"), forState: .Normal)
        btn.setBackgroundImage(UIImage(named: "dingwei_2"), forState: .Highlighted)
        btn.addTarget(self, action: "backUseLocation", forControlEvents: .TouchUpInside)
        return btn
    }()
    
    //MARK: -collectionView
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let itemMargin: CGFloat = 10
        let itemH: CGFloat = 105
        let itemW = screenW - 20
        layout.itemSize = CGSizeMake(itemW, itemH)
        layout.scrollDirection = .Horizontal
        let collectionView = UICollectionView(frame: CGRectMake(10, screenH - 10 - itemH, screenW - 10 , itemH), collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.clipsToBounds = false
        collectionView.registerNib( UINib(nibName: "SMNearCollectionViewCell", bundle: nil ) ,forCellWithReuseIdentifier:identifiter)
        collectionView.pagingEnabled = true
        collectionView.backgroundColor = UIColor.clearColor()
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
    }()
    //记录点击大头针是，上一次选中的大头针
    var lastMAAnnotationView: MAAnnotationView?
}

 let annotationViewIdentifier = "AnnotationViewIdentifier"

extension SMMapView: MAMapViewDelegate {

     //根据annotation，生成大头针
    func mapView(mapView: MAMapView!, viewForAnnotation annotation: MAAnnotation!) -> MAAnnotationView! {
        if annotation.isKindOfClass(MAPointAnnotation.self ) {
            var annotationView = mapView.dequeueReusableAnnotationViewWithIdentifier(annotationViewIdentifier) as? MAPinAnnotationView
            if annotationView == nil {
                annotationView = MAPinAnnotationView(annotation: annotation, reuseIdentifier: annotationViewIdentifier)
            }
            annotationView?.image = UIImage(named: "zuobiao1")
            annotationView?.center = CGPointMake(0, ((annotationView?.image.size.height)! * 0.5))
            return annotationView
        }
        return nil
    }
    
    //选中一个AnnotationView 时调用
    func mapView(mapView: MAMapView!, didSelectAnnotationView view: MAAnnotationView!) {
        lastMAAnnotationView?.image = UIImage(named: "zuobiao1")
        view.image = UIImage(named: "zuobiao3")
        lastMAAnnotationView = view
        setCenterCoordinate(view.annotation.coordinate, animated: true)
        for var i = 0; i < pointAnnotationArray.count; i++ {
            if view === viewForAnnotation(pointAnnotationArray[i]) {
                print(i)
                collectionView.setContentOffset(CGPoint(x: CGFloat (i) * collectionView.width, y: 0), animated: true)
                break
            }
        }
    }
}

extension SMMapView: UICollectionViewDataSource,UICollectionViewDelegate {
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (nearsModel?.list?.count) ?? 0
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(identifiter, forIndexPath: indexPath) as! SMNearCollectionViewCell
        let model = nearsModel?.list![indexPath.row]
        cell.setModel(model!, indexPath: indexPath)
        cell.delegate = self
        return cell
    }
    
    //collectionView滑动是，设置并选中地图上面的相对应的大头针
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        let currentIndex = Int(collectionView.contentOffset.x / collectionView.width + 0.5)
        print(currentIndex)
        currentIndexForCell = currentIndex
        let pointAnnotation = pointAnnotationArray[currentIndex]
        selectAnnotation(pointAnnotation, animated: true)
    }
    
}

//MARK: -详请按钮被点击
extension SMMapView: SMNearCollectionViewCellDelegate {
    func nearCollectionViewCellDetailButtonClick(button: UIButton) {
        delegateMap?.didMapViewColletionCellDetailButton(self, index: currentIndexForCell)
    }
}

//MARK: -代理，详请按钮被点击
protocol SMMapViewDelegate: NSObjectProtocol {

    func didMapViewColletionCellDetailButton(mapview: SMMapView, index: Int)
}
