//
//  APIManager.swift
//  MusicVideo
//
//  Created by mitesh soni on 10/09/16.
//  Copyright © 2016 Mitesh Soni. All rights reserved.
//

import Foundation

class APIManager{
    func loadData(urlString:String, completion: @escaping (_ result: String) -> Void) -> Void {

        let config = URLSessionConfiguration.ephemeral;
        let session = URLSession(configuration: config);
        let url = NSURL(string: urlString);
        let task = session.dataTask(with: url! as URL) { (data, response, error) in
            //If I am not wrong here we had used dispatch_adync(dispatch_get_main_queue()) because the session is running in background and when we are using stuff of this closure then we are putting this back to main thread and then doing it.
                if error != nil{
                    DispatchQueue.main.async {
                        print("error aa gayi hai beta");
                        completion(error!.localizedDescription);
                    }
                    
                } else{
                    do{
                        if let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [String: AnyObject]{
                            print(json);
                            let priority = DispatchQueue.global(qos: .userInitiated)
                            priority.async {
                                print("priority")
                                DispatchQueue.main.async {
                                    completion("JSONSerialization successful");
                                }
                            }
                        }
                    } catch {
                        DispatchQueue.main.async {
                            print("Error had occured while catching");
                            completion("error occured in NSJSONSerialization");
                        }
                        
                    }
                }
            

        }
        task.resume();
    }

}
