//
//  AboutMeController.swift
//  FoodPin
//
//  Created by NDHU_CSIE on 2020/12/24.
//  Copyright © 2020 NDHU_CSIE. All rights reserved.
//

import UIKit
import SafariServices

class AboutMeController: UITableViewController {
    
    var sectionContent = [
        [ "https://www.apple.com/ios/app-store/",                     "http://www.appcoda.com/contact"
        ],
        [
            "https://twitter.com/appcodamobile",
            "https://facebook.com/appcodamobile",
            "https://www.instagram.com/appcodadotcom"
        ]
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView()
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let link = sectionContent[indexPath.section][indexPath.row]
        if let url = URL(string: link) {
            let safariController = SFSafariViewController(url: url)
            present(safariController, animated: true, completion: nil)
        }
        
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    
    
}
