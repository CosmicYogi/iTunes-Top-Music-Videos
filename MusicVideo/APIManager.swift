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
            
            DispatchQueue.main.async {
                if error != nil{
                    print("error aa gayi hai beta");
                    completion(error!.localizedDescription);
                } else{
                    completion("NSURLSession successful");
                    print(data?.description);
                }
            }

        }
        task.resume();
    }

}
