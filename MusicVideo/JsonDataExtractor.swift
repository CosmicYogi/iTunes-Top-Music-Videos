//
//  JsonDataExtractor.swift
//  MusicVideo
//
//  Created by mitesh soni on 11/11/16.
//  Copyright © 2016 Mitesh Soni. All rights reserved.
//

import Foundation

class JsonDataExtractor{
    static func extractVideoDataFromJson(videoDataObject: AnyObject) -> [Video]{
        guard let videoData = videoDataObject as? JSONDictionary else {return [Video]()}
        var videos = [Video]();
        
        if let feeds = videoData["feed"] as? JSONDictionary, let entries = feeds["entry"] as? JSONArray{
            for (index, data) in entries.enumerated(){
                var vName = "";
                var vRights = "";
                var vPrice = "";
                var vImageURL = "";
                var vArtist = "";
                var vVideoURL = "";
                var vImid = "";
                var vGenre = "";
                var vLinkToITunes = "";
                var vReleaseDate = "";
                
                //IMP NOTE - Please note that the variables involved in optional chaining via if let are completely local so don't get confused with the naming pattern used here in optional chaining like-
                //vName, vRights etc which are also alreaddy declared above.
                if let name = data["im:name"] as? JSONDictionary,let label = name["label"] as? String{
                    vName = label;
                }
                
                if let rights = data["rights"] as? JSONDictionary,let label = rights["label"] as? String{
                    vRights = label;
                }
                
                if let price = data["price"] as? JSONDictionary, let label = price["label"] as? String{
                    vPrice = label;
                }
                
                if let image = data["im:image"] as? [AnyObject], let imageDict = image[2] as? JSONDictionary, let label = imageDict["label"] as? String{
                    if UserDefaults.standard.bool(forKey: UserDefaultConstants.bestImageQuality) == true{
                        vImageURL = label.replacingOccurrences(of: "100x100", with: "600x600");
                    } else{
                        vImageURL = label.replacingOccurrences(of: "100x100", with: "120x120");
                    }
                }
                
                if let artist = data["im:artist"] as? JSONDictionary, let label = artist["label"] as? String{
                    vArtist = label;
                }
                
                if let videoURL = data["link"] as? JSONArray, let videoURLDict = videoURL[1] as? JSONDictionary, let attributes = videoURLDict["attributes"] as? JSONDictionary, let href = attributes["href"] as? String{
                    vVideoURL = href;
                }
                
                if let id = data["id"] as? JSONDictionary, let attributes = id["attributes"] as? JSONDictionary, let imId = attributes["im:id"] as? String{
                    vImid = imId
                }
                
                if let category = data["category"] as? JSONDictionary, let attribute = category["attribute"] as? JSONDictionary, let pop = attribute["pop"] as? String{
                    vGenre = pop;
                }
                
                if let iTunesLink = data["link"] as? JSONArray, let linkArray = iTunesLink[0] as? JSONDictionary, let attributes = linkArray["attributes"] as? JSONDictionary, let href = attributes["href"] as? String{
                    vLinkToITunes = href;
                }
                
                if let releaseDate = data["im:releaseDate"] as? JSONDictionary, let attributes = releaseDate["attributes"] as? JSONDictionary, let label = attributes["label"] as? String{
                    vReleaseDate = label;
                }
                let currentVideo = Video(vName: vName, vRights: vRights, vPrice: vPrice, vImageURL: vImageURL, vArtist: vArtist, vVideoURL: vVideoURL, vImid: vImid, vGenre: vGenre, vLinkToITunes: vLinkToITunes, vReleaseDate: vReleaseDate, vRank: index + 1)
                
                videos.append(currentVideo);
            }
        }
        return videos;
    }
    
}
