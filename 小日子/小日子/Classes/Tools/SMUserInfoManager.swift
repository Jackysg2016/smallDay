//
//  SMUserInfoManager.swift
//  小日子
//
//  Created by mike on 16/3/24.
//  Copyright © 2016年 MK. All rights reserved.
//

import UIKit


class UserInfoManager: NSObject {
    
    private static let sharedInstance = UserInfoManager()
    var userPosition: CLLocationCoordinate2D?
    private lazy var locationManager:CLLocationManager = {
        let locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()//始终允许访问位置信息
        return locationManager
    }()
    
    
    class var sharedUserInfoManager: UserInfoManager {
        return sharedInstance
    }
    
    /// 获取用户位置授权,定位用户当前坐标
    func startUserlocation() {
        locationManager.autoContentAccessingProxy
        locationManager.startUpdatingLocation()
    }
    
}

extension UserInfoManager: CLLocationManagerDelegate {
    
    //MARK:- 代理获取当前用户的经纬度
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let userPos = locations[0] as CLLocation
        userPosition = userPos.coordinate
        print(userPosition)
        locationManager.stopUpdatingLocation()
        let geoCoder = CLGeocoder()
        geoCoder.reverseGeocodeLocation(userPos) { (placeMarkArray, error ) -> Void in
            let placeMark = placeMarkArray?.first
//            print(placeMark?.name)
            let city = (placeMark?.locality)?.stringByReplacingOccurrencesOfString("市", withString: "")
            print("当前城市：\(city)")
            NSUserDefaults.standardUserDefaults().setObject(city, forKey: cityKey)
            NSUserDefaults.standardUserDefaults().synchronize()
        }
    }
    
}