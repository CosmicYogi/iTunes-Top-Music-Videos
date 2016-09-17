//
//  MusicVideo.swift
//  MusicVideo
//
//  Created by mitesh soni on 17/09/16.
//  Copyright © 2016 Mitesh Soni. All rights reserved.
//

import Foundation

class Videos {
    private var _vName: String
    private var _vRights: String
    private var _vPrice: String
    private var _vImageURL: String
    private var _vArtist: String
    private var _vVideoURL: String
    private var _vImid: String
    private var _vGenre: String
    private var _vLinkToITunes: String
    private var _vReleaseDate: String
    
    var vImageData: NSData?
    
    var vName : String{
        return _vName;
    }
    var vRights: String{
        return _vRights;
    }
    var vPrice : String{
        return _vPrice;
    }
    var vImageURL : String{
        return _vImageURL;
    }
    var vArtist: String{
        return _vArtist;
    }
    var vVideoURL: String{
        return _vVideoURL;
    }
    var vImid: String{
        return _vImid;
    }
    var vGenre: String{
        return _vGenre;
    }
    var vLinkToITunes: String{
        return _vLinkToITunes;
    }
    var vReleaseDate: String{
        return _vReleaseDate;
    }
    
    init(data: JSONDictionary) {
        
        //IMP NOTE - Please note that the variables involved in optional chaining via if let are completely local so don't get confused with the naming pattern used here in optional chaining like-
        //vName, vRights etc which are also alreaddy declared above.
        if let name = data["im:name"] as? JSONDictionary,vName = name["label"] as? String{
            self._vName = vName;
        } else{
            self._vName = "";
        }
        
        if let rights = data["rights"] as? JSONDictionary,vRights = rights["label"] as? String{
            self._vRights = vRights;
        } else{
            self._vRights = "";
        }
        
        if let price = data["price"] as? JSONDictionary, vPrice = price["label"] as? String{
            self._vPrice = vPrice;
        } else{
            self._vPrice = "";
        }
        
        if let imageURL = data["im:image"] as? [AnyObject], vImageURL = imageURL[2] as? JSONDictionary, label = vImageURL["label"] as? String{
                self._vImageURL = label.stringByReplacingOccurrencesOfString("100x100", withString: "600x600");
        } else{
            self._vImageURL = "";
        }
        
        if let artist = data["im:artist"] as? JSONDictionary, vArtist = artist["label"] as? String{
            self._vArtist = vArtist;
        } else{
            self._vArtist = "";
        }
        
        if let videoURL = data["link"] as? JSONArray, linkArray = videoURL[1] as? JSONDictionary, attributes = linkArray["attributes"] as? JSONDictionary, finalURL = attributes["href"] as? String{
            self._vVideoURL = finalURL;
        } else{
            self._vVideoURL = "";
        }
        
        if let imid = data["id"] as? JSONDictionary, vid = imid["attributes"] as? JSONDictionary, vImID = vid["im:id"] as? String{
            self._vImid = vImID
        } else{
            self._vImid = "";
        }
        
        if let gerne = data["category"] as? JSONDictionary, attribute = gerne["attribute"] as? JSONDictionary, term = attribute["pop"] as? String{
            self._vGenre = term;
        } else{
            self._vGenre = "";
        }
        
        if let iTunesLink = data["link"] as? JSONArray, linkArray = iTunesLink[0] as? JSONDictionary, attributes = linkArray["attributes"] as? JSONDictionary, finalLink = attributes["href"] as? String{
            self._vLinkToITunes = finalLink;
        } else{
            self._vLinkToITunes = "";
        }
        
        if let releaseDate = data["im:releaseDate"] as? JSONDictionary, attributes = releaseDate["attributes"] as? JSONDictionary, date = attributes["label"] as? String{
            self._vReleaseDate = date;
        } else{
            self._vReleaseDate = "";
        }
    }
}
