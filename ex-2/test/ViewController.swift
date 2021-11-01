//
//  ViewController.swift
//  test
//
//  Created by NDHU_CSIE on 2021/10/25.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet var headTitle: UILabel!
    
    var sports = ["Football", "Basketball", "Baseball", "Wrestling", "BJJ", "MMA", "Box"]

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        sports.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "datacell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)

        // Configure the cell...

        cell.textLabel?.text = sports[indexPath.row]
        cell.imageView?.image = UIImage(named: "ball")
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        headTitle.text = "My favorite sport is " + sports[indexPath.row]
        
       
        }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

