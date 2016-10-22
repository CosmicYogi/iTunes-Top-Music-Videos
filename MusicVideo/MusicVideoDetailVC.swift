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
class MusicVideoDetailVC: UIViewController {

    var videos : Videos!
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
        shareMedia();
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
