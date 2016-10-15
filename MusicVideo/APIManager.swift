//
//  APIManager.swift
//  MusicVideo
//
//  Created by mitesh soni on 10/09/16.
//  Copyright © 2016 Mitesh Soni. All rights reserved.
//

import Foundation

class APIManager{
    func loadData(urlString:String, completion: @escaping ([Videos]) -> Void) -> Void {

        let config = URLSessionConfiguration.ephemeral;
        let session = URLSession(configuration: config);
        let url = NSURL(string: urlString);
        let task = session.dataTask(with: url! as URL) { (data, response, error) in
            //If I am not wrong here we had used dispatch_adync(dispatch_get_main_queue()) because the session is running in background and when we are using stuff of this closure then we are putting this back to main thread and then doing it.
                if error != nil{
                    DispatchQueue.main.async {
                        print("error occured in JSON Serialization");
                        print(error!.localizedDescription);
                    }
                    
                } else{
                    do{
                        if let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? JSONDictionary, let feed = json["feed"] as? JSONDictionary, let entries = feed["entry"] as? JSONArray{
                            var videos = [Videos]();
                            for (index, entry) in entries.enumerated(){
                                let entry = Videos(data: entry as! JSONDictionary);
                                entry.vRank = index + 1;
                                videos.append(entry);
                            }
                            print("iTunes API Manager total count ----> \(videos.count)\n");
                            let priority = DispatchQueue.global(qos: .userInitiated);
                            priority.async {
                                DispatchQueue.main.async {
                                    completion(videos);
                                }
                            }
                            
                        } else{
                            print("error in parsing");
                        }
                    } catch {
                        print("error Catched");
                        
                    }
                }
            

        }
        task.resume();
    }

}
