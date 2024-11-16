//
//  TableViewController.swift
//  Project4
//
//  Created by Muhammed Yılmaz on 5.11.2024.
//

import UIKit

class TableViewController: UITableViewController {
    
    let websites = ["apple.com.tr", "hackingwithswift.com", "googl.com.tr"]

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "WebSites"
        
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        websites.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = websites[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Browser") as? ViewController {
            vc.selectWebsite = websites[indexPath.row]
            navigationController?.pushViewController(vc, animated: true)
        }
    }

    

}
