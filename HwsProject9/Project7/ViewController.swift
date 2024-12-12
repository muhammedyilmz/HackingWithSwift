//
//  ViewController.swift
//  Project7
//
//  Created by Muhammed Yılmaz on 14.11.2024.
//

import UIKit

class ViewController: UITableViewController {
    var petitions = [Petition]()
   
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        performSelector(inBackground: #selector (fetchJSON), with: nil)
        
        title = "Petitions "
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .bookmarks, target: self, action: #selector(info))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(search))
    }
        
    @objc func fetchJSON() {
        let urlString: String

        if navigationController?.tabBarItem.tag == 0 {
            urlString = "https://api.whitehouse.gov/v1/petitions.json?limit=100"
        } else {
            urlString = "https://api.whitehouse.gov/v1/petitions.json?signatureCountFloor=10000&limit=100"
        }

        if let url = URL(string: urlString) {
            if let data = try? Data(contentsOf: url) {
                parse(json: data)
                return
            }
        }


        performSelector(onMainThread: #selector(showError), with: nil, waitUntilDone: false)
    }
    
    
    @objc func info() {
        let ac = UIAlertController(title: "INFO", message: "We The People API of the Whitehouse", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default)
        ac.addAction(action)
        present(ac, animated: true)
    }
    
    @objc func search() {
        let ac = UIAlertController(title: "Search", message: "Please enter the petition title you want to search.", preferredStyle: .alert)
        ac.addTextField()
        
        
        let action = UIAlertAction(title: "Search", style: .default) { _ in
            let keyword = ac.textFields?.first?.text ?? ""
            for petition in self.petitions {
                if petition.title.lowercased().contains(keyword.lowercased()) && petition.body.lowercased().contains(keyword.lowercased()){
                     let ac = UIAlertController(title: petition.title, message: petition.body, preferredStyle: .alert)
                     ac.addAction(UIAlertAction(title: "OK", style: .default))
                     self.present(ac, animated: true)
                 }
             }
        }
        ac.addAction(action)
        present(ac, animated: true)
        
    }
    
@objc func showError() {
    let ac = UIAlertController(title: "Loading error", message: "There was a problem loading the feed; please check your connection and try again.", preferredStyle: .alert)
    ac.addAction(UIAlertAction(title: "OK", style: .default))
    present(ac, animated: true)
}

func parse(json: Data) {
    let decoder = JSONDecoder()

    if let jsonPetitions = try? decoder.decode(Petitions.self, from: json) {
        petitions = jsonPetitions.results
        tableView.performSelector(onMainThread: #selector(UITableView.reloadData), with: nil, waitUntilDone: false)
    } else {
        performSelector(onMainThread: #selector(showError), with: nil, waitUntilDone: false)
    }
}
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return petitions.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let petition = petitions[indexPath.row]
        cell.textLabel?.text = petition.title
        cell.detailTextLabel?.text = petition.body
        return cell
    }
    
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
        vc.detailItem = petitions[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }

}
