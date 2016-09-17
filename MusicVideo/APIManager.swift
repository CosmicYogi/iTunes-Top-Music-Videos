//
//  APIManager.swift
//  MusicVideo
//
//  Created by mitesh soni on 10/09/16.
//  Copyright © 2016 Mitesh Soni. All rights reserved.
//

import Foundation

class APIManager{
    func loadData(urlString:String, completion: (result: String) -> Void) -> Void {

        let config = NSURLSessionConfiguration.ephemeralSessionConfiguration();
        let session = NSURLSession(configuration: config);

        let url = NSURL(string: urlString);
        let task = session.dataTaskWithURL(url!) { (data, response, error) in
            //If I am not wrong here we had used dispatch_adync(dispatch_get_main_queue()) because the session is running in background and when we are using stuff of this closure then we are putting this back to main thread and then doing it.

            if error != nil{
                dispatch_async(dispatch_get_main_queue(), { 
                    print("error aa gayi hai beta");
                    completion(result: error!.localizedDescription);
                })
            } else{
                //JSON Serialization works here
                //print(data?.description);
                do{
                    if let json = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments) as? [String : AnyObject]{
                        print(json);
                        let priority = DISPATCH_QUEUE_PRIORITY_HIGH;
                        dispatch_async(dispatch_get_global_queue(priority, 0), { 
                            dispatch_async(dispatch_get_main_queue(), { 
                                completion(result: "JSON Serialization successful");
                            })
                        })
                    }
                } catch{
                    dispatch_async(dispatch_get_main_queue(), { 
                        completion(result: "Error in NSJSONSerialization");
                    })
                }
            }

        }
        task.resume();
    }

}
