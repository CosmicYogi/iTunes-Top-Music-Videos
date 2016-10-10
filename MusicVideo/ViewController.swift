//
//  ViewController.swift
//  MusicVideo
//
//  Created by mitesh soni on 09/09/16.
//  Copyright © 2016 Mitesh Soni. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        print(reachabilityStatus);
        
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.reachabilityStatusChanged), name: NSNotification.Name(rawValue: "ReachStatusChanged"), object: nil);
        reachabilityStatusChanged();
        let apiManager = APIManager()
        apiManager.loadData(urlString: "https://itunes.apple.com/us/rss/topmusicvideos/limit=10/json", completion: loadData);
    }

    func loadData(videos: [Videos]) -> Void {
        for video in videos{
            print("name = \(video.vName)");
        }
    }
    
    func reachabilityStatusChanged(){
        switch reachabilityStatus {
        case NOACCESS:
            print("no access")
        case WIFI:
            print("wifi");
        case WWAN:
            print("cellular");
        default:
            return
        }
    }

}

