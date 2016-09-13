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
            
            dispatch_async(dispatch_get_main_queue()){
                if error != nil{
                    print("error aa gayi hai beta");
                    completion(result: error!.localizedDescription);
                } else{
                    completion(result: "NSURLSession successful");
                    print(data?.description);
                }
            }

        }
        task.resume();
    }

}
