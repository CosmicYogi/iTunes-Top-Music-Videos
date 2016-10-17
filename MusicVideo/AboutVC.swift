//
//  AboutVC.swift
//  MusicVideo
//
//  Created by mitesh soni on 17/10/16.
//  Copyright © 2016 Mitesh Soni. All rights reserved.
//

import UIKit

class AboutVC: UIViewController {

    @IBOutlet weak var rights: UILabel!
    @IBOutlet weak var blaBlaBla: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(self, selector: "preferredFontChange", name: NSNotification.Name.UIContentSizeCategoryDidChange, object: nil)
    }
    func preferredFontChange(){
        rights.font = UIFont.preferredFont(forTextStyle: .headline);
        rights.font = UIFont.preferredFont(forTextStyle: .subheadline);
    }


}
