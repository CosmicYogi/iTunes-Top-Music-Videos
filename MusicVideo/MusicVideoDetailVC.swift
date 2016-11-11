//
//  MusicVideoDetailVC.swift
//  MusicVideo
//
//  Created by mitesh soni on 15/10/16.
//  Copyright © 2016 Mitesh Soni. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation
import LocalAuthentication

class MusicVideoDetailVC: UIViewController {

    var videos : Video!
    var securitySwitch : Bool = false;
    @IBOutlet weak var vName: UILabel!
    @IBOutlet weak var videoImage: UIImageView!
    @IBOutlet weak var vGenre: UILabel!
    @IBOutlet weak var vRights: UILabel!
    @IBOutlet weak var vPrice: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        vName.text = videos.vName;
        vPrice.text = videos.vPrice;
        vGenre.text = videos.vGenre;
        vRights.text = videos.vRights;
        title = videos.vArtist;
        if videos.vImageData != nil{
            videoImage.image = UIImage(data: videos.vImageData as! Data);
        } else{
            videoImage.image = UIImage(named: "imageNotAvailable")
        }
    }

    
    @IBAction func socialMedia(_ sender: UIBarButtonItem) {
        securitySwitch = UserDefaults.standard.bool(forKey: "SecSetting");
        
        switch securitySwitch {
        case true:
            touchIDCheck();
        default:
            shareMedia();
        }
    }
    
    func touchIDCheck(){
        let alert = UIAlertController(title: "", message: "", preferredStyle: .alert);
        alert.addAction(UIAlertAction(title: "Continue", style: .cancel, handler: nil));
        
        //CREATING A LOCAL AUTHENTICATION CONTEXT
        let context = LAContext();
        var touchIDError : NSError?
        let reasonString = "Touch ID authentication is needed to share info on social media";
        
        //CHECKING IF WE CAN ACCESS LOCAL DEVICE AUTHENTICATION
        if (context.canEvaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, error: &touchIDError)){
           //CHECKING WHAT WAS AUTHENTICATION RESPONSE
            context.evaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, localizedReason: reasonString, reply: { (success, policyError) in
                if success{
                    //SUCCESSFUL AUTHENTICATION OF USER VIA BIOMETRICS
                    let priority = DispatchQueue.global(qos: .userInitiated);
                    priority.async {
                        DispatchQueue.main.async {
                            [unowned self] in self.shareMedia();
                        }
                    }
                } else{
                    alert.title = "UnSuccessful";
                    
                    switch policyError{
                    case LAError.appCancel?:
                       alert.message = "Authentication was cancelled by the application";
                    case LAError.authenticationFailed?:
                        alert.message = "The user failed to provide valid credentials";
                    case LAError.passcodeNotSet?:
                        alert.message = "Passcode is not set on the device";
                    case LAError.systemCancel?:
                        alert.message = "Authentication was cancelled by the system";
                    case LAError.touchIDLockout?:
                        alert.message = "Too many failed attempts";
                    case LAError.userCancel?:
                        alert.message = "You cancelled the request";
                    case LAError.userFallback?:
                        alert.message = "Password not accepted, Must use Touch-ID";
                    default:
                        alert.message = "Unable to authenticate";
                    }
                    DispatchQueue.global(qos: .userInitiated).async {
                        DispatchQueue.main.async {
                            self.present(alert, animated: true, completion: nil);
                        }
                    }
                }
            })
        } else{
            //UNABLE TO ACCESS DEVICE LOCAL AUTHENTICATION
            alert.title = "Error";
            
            switch touchIDError {
            case LAError.touchIDNotEnrolled?:
                alert.message = "Touch-ID is not enrolled";
            case LAError.touchIDNotAvailable?:
                alert.message = "Touch-ID is not availabe on device";
            case LAError.passcodeNotSet?:
                alert.message = "Passcode had not been set";
            case LAError.invalidContext?:
                alert.message = "The context is invalid";
            default:
                alert.message = "Local authentication is not available";
            }
            DispatchQueue.global(qos: .userInitiated).async {
                [unowned self] in
                self.present(alert, animated: true, completion: nil);
            }
        }
        
    }
    
    func shareMedia(){
        let activity1 = "Have you had the opportunity to see this Music Video?"
        let activity2 = "\(videos.vName) by \(videos.vArtist)";
        let activity3 = "Watch it and tell me what do you think?";
        let activity4 = videos.vLinkToITunes;
        let activity5 = "(Shared with the Music Video App - Step It UP!)";
        
        let activityViewController : UIActivityViewController = UIActivityViewController(activityItems: [activity1,activity2,activity3,activity4,activity5], applicationActivities: nil);
        
        activityViewController.excludedActivityTypes = [UIActivityType.postToTwitter, UIActivityType.postToFacebook];
        activityViewController.completionWithItemsHandler = {
            (activity, success, items, error) in
            if (activity == UIActivityType.mail){
                print("eMail selected");
            }
        }
        
        
        self.present(activityViewController, animated: true, completion: nil);
    }
    
    @IBAction func playVideo(_ sender: UIBarButtonItem) {
        let url = URL(string: videos.vVideoURL);
        let player = AVPlayer(url: url!);
        let playerViewController = AVPlayerViewController();
        playerViewController.player = player;
        self.present(playerViewController, animated: true) { 
            playerViewController.player?.play();
        }
    }

}
