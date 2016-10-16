//
//  MusicVideoDetailVC.swift
//  MusicVideo
//
//  Created by mitesh soni on 15/10/16.
//  Copyright © 2016 Mitesh Soni. All rights reserved.
//

import UIKit

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


}
