//
//  MusicVideoTableViewCell.swift
//  MusicVideo
//
//  Created by mitesh soni on 15/10/16.
//  Copyright © 2016 Mitesh Soni. All rights reserved.
//

import UIKit

class MusicVideoTableViewCell: UITableViewCell {

    var video : Videos?{
        didSet {
            updateCell();
        }
    }
    @IBOutlet weak var musicImage: UIImageView!
    
    @IBOutlet weak var rank: UILabel!
    
    @IBOutlet weak var musicTitle: UILabel!
    
    func updateCell(){
        musicTitle.text = video?.vName;
        rank.text = "\(video!.vRank)"
        //musicImage.image = UIImage(named: "imageNotAvailable")
        
        if video?.vImageData != nil{
            print("get data from array ");
            musicImage.image = UIImage(data: video?.vImageData as! Data);
        } else{
            getVideoImage(video: video!, imageView: musicImage);
            print("Get images in background thread" + "\(arc4random())");
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func getVideoImage(video: Videos, imageView: UIImageView){
        let priority = DispatchQueue.global(qos: .userInitiated);
        priority.async {
            let data = NSData(contentsOf: URL(string: video.vImageURL)!);
            var image: UIImage?
            if data != nil{
                video.vImageData = data;
                image = UIImage(data: data! as Data);
            }
            DispatchQueue.main.async {
                imageView.image = image
            }
        }
    }

}
