//
//  SettingsTVC.swift
//  MusicVideo
//
//  Created by mitesh soni on 17/10/16.
//  Copyright © 2016 Mitesh Soni. All rights reserved.
//

import UIKit
import MessageUI

class SettingsTVC: UITableViewController, MFMailComposeViewControllerDelegate {

    @IBOutlet weak var aboutDisplay: UILabel!
    @IBOutlet weak var feedbackDisplay: UILabel!
    @IBOutlet weak var securityDisplay: UILabel!
    @IBOutlet weak var touchID: UISwitch!
    @IBOutlet weak var bestImageDisplay: UILabel!
    @IBOutlet weak var APICount: UILabel!
    @IBOutlet weak var sliderCount: UISlider!
    @IBOutlet weak var numberOfMusicVideosDisplay: UILabel!
    @IBOutlet weak var dragTheSliderDisplay: UILabel!
    @IBOutlet weak var bestImageQuality: UISwitch!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Settings";
        //THIS IS TO MAKE THE TABLE VIEW FEEL SOLID SO IT DON'T BOUNCE WHEN USER SWIPE UP & DOWN.
        tableView.alwaysBounceVertical = false;
        
        NotificationCenter.default.addObserver(self, selector: #selector(SettingsTVC.preferredFontChanged), name: NSNotification.Name.UIContentSizeCategoryDidChange, object: nil);
        touchID.isOn = UserDefaults.standard.bool(forKey: "SecSetting");
        bestImageQuality.isOn = UserDefaults.standard.bool(forKey: UserDefaultConstants.bestImageQuality);
        if UserDefaults.standard.value(forKey: "APICnt") != nil{
            if let theValue = UserDefaults.standard.value(forKey: "APICnt") as? Float{
                APICount.text = "\(Int(theValue))";
                sliderCount.value = theValue;
            } else{
                sliderCount.value = 10.0;
                APICount.text = "\(Int(sliderCount.value))";
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

    @IBAction func bestImageQualityAction(_ sender: UISwitch) {
        let defaults = UserDefaults.standard;
        if bestImageQuality.isOn{
            defaults.set(true, forKey: UserDefaultConstants.bestImageQuality);
        } else{
            defaults.set(false, forKey: UserDefaultConstants.bestImageQuality);
        }
    }
    
    
    @IBAction func valueChanged(_ sender: UISlider) {
        let defaults = UserDefaults.standard;
        defaults.set(Int(Int(sliderCount.value)), forKey: "APICnt");
        APICount.text = "\(Int(sliderCount.value))";
    }
    func preferredFontChanged(){
        aboutDisplay.font = UIFont.preferredFont(forTextStyle: .subheadline);
        feedbackDisplay.font = UIFont.preferredFont(forTextStyle: .subheadline);
        securityDisplay.font = UIFont.preferredFont(forTextStyle: .subheadline);
        bestImageDisplay.font = UIFont.preferredFont(forTextStyle: .subheadline);
        APICount.font = UIFont.preferredFont(forTextStyle: .subheadline);
        
        numberOfMusicVideosDisplay.font = UIFont.preferredFont(forTextStyle: .subheadline);
        dragTheSliderDisplay.font = UIFont.preferredFont(forTextStyle: .footnote);
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (indexPath.section == 0 && indexPath.row == 1) {
            let mailViewController = configureMail();
            //CHECKING THAT IF THERE IS AN eMAIL ACCOUNT SETUP ON THE DEVICE, THIS IS VERY IMPORTANT BECAUSE APP WILL CRASH IF eMAIL ACCOUNT IS NOT SETUP AND APPLE WILL REJECT THE APP.
            if MFMailComposeViewController.canSendMail(){
                self.present(mailViewController, animated: true, completion: nil);
            } else{
                mailAlert();
            }
            tableView.deselectRow(at: indexPath, animated: true);
        }
    }
    
    func configureMail() -> MFMailComposeViewController {
        let mailComposerVC = MFMailComposeViewController();
        mailComposerVC.mailComposeDelegate = self;
        mailComposerVC.setToRecipients(["mitesh_soni@rocketmail.com"]);
        mailComposerVC.setSubject("Music Video App Feedback");
        mailComposerVC.setMessageBody("Hi Mitesh,\n\nI would like to share the following feedback with you.\n", isHTML: false);
        return mailComposerVC;
    }
    
    func mailAlert(){
        let alertController : UIAlertController = UIAlertController(title: "Alert", message: "No eMail account setup on iPhone", preferredStyle: .alert);
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil);
        alertController.addAction(okAction);
        self.present(alertController, animated: true, completion: nil);
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        switch result.rawValue {
        case MFMailComposeResult.cancelled.rawValue:
            print("cancelled");
        case MFMailComposeResult.failed.rawValue:
            print("Failed");
        case MFMailComposeResult.saved.rawValue:
            print("Saved");
        case MFMailComposeResult.sent.rawValue:
            print("Sent");
        default:
            print("Unknown error");
        }
        self.dismiss(animated: true, completion: nil);
    }
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIContentSizeCategoryDidChange, object: nil);
    }
}
