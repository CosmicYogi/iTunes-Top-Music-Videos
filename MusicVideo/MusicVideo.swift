//
//  MusicVideo.swift
//  MusicVideo
//
//  Created by mitesh soni on 18/09/16.
//  Copyright © 2016 Mitesh Soni. All rights reserved.
//

import Foundation


class Video {
    private(set) var vName: String
    private(set) var vRights: String
    private(set) var vPrice: String
    private(set) var vImageURL: String
    private(set) var vArtist: String
    private(set) var vVideoURL: String
    private(set) var vImid: String
    private(set) var vGenre: String
    private(set) var vLinkToITunes: String
    private(set) var vReleaseDate: String
    private(set) var vRank : Int

    var vImageData: NSData?
    
    init(vName : String, vRights : String, vPrice: String, vImageURL: String, vArtist: String, vVideoURL: String, vImid: String, vGenre: String, vLinkToITunes : String, vReleaseDate:String,vRank: Int) {
        
        self.vName = vName;
        self.vRights = vRights;
        self.vPrice = vPrice;
        self.vImageURL = vImageURL;
        self.vArtist = vArtist;
        self.vVideoURL = vVideoURL;
        self.vImid = vImid;
        self.vGenre = vGenre;
        self.vLinkToITunes = vLinkToITunes;
        self.vReleaseDate = vReleaseDate;
        self.vRank = vRank;
    }
        

}
