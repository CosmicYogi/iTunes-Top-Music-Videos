//
//  APIManager.swift
//  MusicVideo
//
//  Created by mitesh soni on 10/09/16.
//  Copyright © 2016 Mitesh Soni. All rights reserved.
//

import Foundation

class APIManager{
    func loadData(urlString:String, completion: [Videos] -> Void) -> Void {

        let config = NSURLSessionConfiguration.ephemeralSessionConfiguration();
        let session = NSURLSession(configuration: config);

        let url = NSURL(string: urlString);
        let task = session.dataTaskWithURL(url!) { (data, response, error) in
            //If I am not wrong here we had used dispatch_adync(dispatch_get_main_queue()) because the session is running in background and when we are using stuff of this closure then we are putting this back to main thread and then doing it.

            if error != nil{
                print(error?.localizedDescription);
                print("error occured in JSON Serialization");
            } else{
                //JSON Serialization works here
                //print("JSONSerialization started");
                //print(data?.description);
                do{
                    if let json = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments) as? JSONDictionary, feed = json["feed"] as? JSONDictionary, entries = feed["entry"] as? JSONArray{
                        //print("enteries are as follows: \n\(entries)");
                        var videos = [Videos]();
                        for entry in entries{
                            let entry = Videos(data: entry as! JSONDictionary)
                            videos.append(entry);
                        }
                        print("iTunes API Manager total count ----> \(videos.count)\n");
                        let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT;
                        dispatch_async(dispatch_get_global_queue(priority, 0), { 
                            completion(videos);
                        })
                    } else{
                        print("Error in JSON Parsing");
                    }
                } catch{
                    print("error catched");
                }
            }
                

        }
        task.resume();
    }

}
