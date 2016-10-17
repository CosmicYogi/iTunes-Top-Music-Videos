//
//  SettingsTVC.swift
//  MusicVideo
//
//  Created by mitesh soni on 17/10/16.
//  Copyright © 2016 Mitesh Soni. All rights reserved.
//

import UIKit

class SettingsTVC: UITableViewController {

    @IBOutlet weak var aboutDisplay: UILabel!
    @IBOutlet weak var feedbackDisplay: UILabel!
    @IBOutlet weak var securityDisplay: UILabel!
    @IBOutlet weak var touchID: UISwitch!
    @IBOutlet weak var bestImageDisplay: UILabel!
    @IBOutlet weak var APICount: UILabel!
    @IBOutlet weak var sliderCount: UISlider!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Settings";
        //THIS IS TO MAKE THE TABLE VIEW FEEL SOLID SO IT DON'T BOUNCE WHEN USER SWIPE UP & DOWN.
        tableView.alwaysBounceVertical = false;
        
        NotificationCenter.default.addObserver(self, selector: #selector(SettingsTVC.preferredFontChanged), name: NSNotification.Name.UIContentSizeCategoryDidChange, object: nil);
        touchID.isOn = UserDefaults.standard.bool(forKey: "SecSetting");
        
        if UserDefaults.standard.value(forKey: "APICnt") != nil{
            if let theValue = UserDefaults.standard.value(forKey: "APICnt") as? Float{
                APICount.text = "\(Int(theValue))";
                sliderCount.value = theValue;
            }
            
            
        }
        
    }
    @IBAction func touchIDSec(_ sender: UISwitch) {
        let defaults = UserDefaults.standard;
        if touchID.isOn{
            defaults.set(true, forKey: "SecSetting");
        } else{
            defaults.set(false, forKey: "SecSetting");
        }
    }

    @IBAction func valueChanged(_ sender: UISlider) {
        let defaults = UserDefaults.standard;
        defaults.set(Int(sliderCount.value), forKey: "APICnt");
        APICount.text = "\(sliderCount.value)";
    }
    func preferredFontChanged(){
        aboutDisplay.font = UIFont.preferredFont(forTextStyle: .subheadline);
        feedbackDisplay.font = UIFont.preferredFont(forTextStyle: .subheadline);
        securityDisplay.font = UIFont.preferredFont(forTextStyle: .subheadline);
        bestImageDisplay.font = UIFont.preferredFont(forTextStyle: .subheadline);
        APICount.font = UIFont.preferredFont(forTextStyle: .subheadline);
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIContentSizeCategoryDidChange, object: nil);
    }
}
