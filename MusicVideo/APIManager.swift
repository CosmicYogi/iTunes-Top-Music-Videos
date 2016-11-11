//
//  APIManager.swift
//  MusicVideo
//
//  Created by mitesh soni on 10/09/16.
//  Copyright © 2016 Mitesh Soni. All rights reserved.
//

import Foundation

class APIManager{
    func loadData(urlString:String, completion: @escaping ([Video]) -> Void) -> Void {
        
        let config = URLSessionConfiguration.ephemeral;
        let session = URLSession(configuration: config);
        let url = NSURL(string: urlString);
        let task = session.dataTask(with: url! as URL) { (data, response, error) in
            //If I am not wrong here we had used dispatch_adync(dispatch_get_main_queue()) because the session is running in background and when we are using stuff of this closure then we are putting this back to main thread and then doing it.
            if error != nil{
                print("error occured in JSON Serialization");
                print(error!.localizedDescription);
                
            } else{
                let videos = self.parseJson(data: data as NSData?);
                
                let priority = DispatchQueue.global(qos: .userInitiated);
                priority.async {
                    DispatchQueue.main.async {
                        completion(videos);
                    }
                }
            }
            }
            task.resume();
        }
        
        func parseJson(data: NSData?) -> [Video] {
            do {
                if let json = try JSONSerialization.jsonObject(with: data! as Data, options: .allowFragments) as? AnyObject{
                    return JsonDataExtractor.extractVideoDataFromJson(videoDataObject: json);
                }
            } catch{
                print("Failed to parse data: \(error)");
            }
            return [Video]();
        }
        
}
