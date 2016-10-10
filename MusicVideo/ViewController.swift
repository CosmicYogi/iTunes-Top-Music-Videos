//
//  ViewController.swift
//  MusicVideo
//
//  Created by mitesh soni on 09/09/16.
//  Copyright © 2016 Mitesh Soni. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var displayLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "reachabilityStatusChanged", name: "ReachStatusChanged", object: nil);
        reachabilityStatusChanged();
        let apiManager = APIManager();
        apiManager.loadData("https://itunes.apple.com/us/rss/topmusicvideos/limit=10/json", completion: loadData);
        
    }

    func loadData(videos: [Videos]) -> Void {
        for video in videos{
            print("name = \(video.vName)");
        }
    }

    func reachabilityStatusChanged(){
        print("reached reachabilityStatusChanged");
        switch reachabilityStatus {
        case WIFI:
            view.backgroundColor = UIColor.greenColor();
            displayLabel.text = "WIFI available";
            print("Wifi");
        case WWAN:
            view.backgroundColor = UIColor.blueColor();
            displayLabel.text = "Cellular internet available";
            print("Cellular");
        case NOACCESS:
            view.backgroundColor = UIColor.redColor();
            displayLabel.text = "No internet access";
            print("No access");
        default:
            return;
        }
    }
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "ReachStatusChanged", object: nil);
    }

}
