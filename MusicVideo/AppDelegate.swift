//
//  AppDelegate.swift
//  MusicVideo
//
//  Created by mitesh soni on 09/09/16.
//  Copyright © 2016 Mitesh Soni. All rights reserved.
//

import UIKit
var reachability : Reachability?
var reachabilityStatus = " ";

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var internetCheck : Reachability?;

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        print("in didFinishLaunchingWithOptions");
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "reachabilityChanged:", name: kReachabilityChangedNotification, object: nil);
        internetCheck = Reachability.reachabilityForInternetConnection();
        internetCheck?.startNotifier();
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        print("application will resign active");
    }

    func reachabilityChanged(notification : NSNotification){
        print("reachability changed");
        reachability = notification.object as? Reachability;
        statusChangedWithReachability(reachability!);
    }
    
    func statusChangedWithReachability(currentRachabilityStatus: Reachability){
        let networkStatus: NetworkStatus = currentRachabilityStatus.currentReachabilityStatus();
        
        switch networkStatus.rawValue {
        case NotReachable.rawValue:
            reachabilityStatus = NOACCESS;
        case ReachableViaWiFi.rawValue:
            reachabilityStatus = WIFI;
        case ReachableViaWWAN.rawValue:
            reachabilityStatus = WWAN;
        default:
            return;
        }
        NSNotificationCenter.defaultCenter().postNotificationName("ReachStatusChanged", object: nil);
    }
    func applicationDidEnterBackground(application: UIApplication) {
        print("application did enter background");
    }

    func applicationWillEnterForeground(application: UIApplication) {
        print("appplication will enter foreground");
    }

    func applicationDidBecomeActive(application: UIApplication) {
        print("application did become active");
    }

    func applicationWillTerminate(application: UIApplication) {
        print("application will terminate");
        NSNotificationCenter.defaultCenter().removeObserver(self, name: kReachabilityChangedNotification, object: nil);
    }


}

