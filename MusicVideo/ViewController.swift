//
//  ViewController.swift
//  MusicVideo
//
//  Created by mitesh soni on 09/09/16.
//  Copyright © 2016 Mitesh Soni. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let apiManager = APIManager();
        apiManager.loadData(urlString: "https://itunes.apple.com/us/rss/topmusicvideos/limit=10/json", completion: loadData);
    }

    func loadData(data: String) -> Void {
        print(data);
        let alert = UIAlertController(title: data, message: nil, preferredStyle: .alert);
        
        let okActio = UIAlertAction(title: "OK", style: .default) { (action) in
            
        }
        alert.addAction(okActio);
        self.present(alert, animated: true, completion: nil);
    }


}

