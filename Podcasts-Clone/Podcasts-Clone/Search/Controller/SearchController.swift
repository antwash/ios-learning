//  SearchController.swift
//  Podcasts-Clone
//  Created by Anthony Washington on 3/24/18.
//  Copyright © 2018 Anthony Washington. All rights reserved.

import UIKit
import Alamofire

class SearchController: UITableViewController {
    
    let cellId = "podcastCellId"
    let searchController = UISearchController(searchResultsController: nil)

    var podcast : [Podcast] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.alwaysBounceVertical = false
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        
        searchController.searchBar.delegate = self
        searchController.dimsBackgroundDuringPresentation = false

        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    override func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int {
        return podcast.count
    }
    
    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId,
                                                 for: indexPath)
            cell.textLabel?.text = podcast[indexPath.row].trackName ?? ""
            cell.imageView?.image = #imageLiteral(resourceName: "appicon")
            cell.textLabel?.numberOfLines = -1
        return cell
    }
}


extension SearchController : UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let url = "https://itunes.apple.com/search"
        let parameters = ["term" : searchText,
                          "media": "podcast"]
        
        Alamofire.request(url, method: .get, parameters:
            parameters, encoding: URLEncoding.default, headers: nil).responseData { (dataResponse) in
                
            if let err = dataResponse.error {
                print("ERROR: failed to fetch info from: \(url)" +
                      "\n" + err.localizedDescription)
            }
                
            guard let data = dataResponse.data else { return }
             do {
                let results = try  JSONDecoder().decode(SearchResults.self, from: data)
                self.podcast = results.results
                self.tableView.reloadData()
              } catch let err {
                print("Error: failed to decode data:", err)
           }
        }
    }
}















