//  SearchController.swift
//  Podcasts-Clone
//  Created by Anthony Washington on 3/24/18.
//  Copyright © 2018 Anthony Washington. All rights reserved.

import UIKit

class SearchController: UITableViewController {
    
    let cellId = "podcastCellId"
    let searchController = UISearchController(searchResultsController: nil)

    let podcast = [
        Podcast(title: "Work hard, you'll become an iOS dev", creatorName: "Anthony Washington"),
        Podcast(title: "Being black in Portland", creatorName: "Anthony D. Washington")
    ]
    
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
            cell.textLabel?.text = podcast[indexPath.row].title
            cell.imageView?.image = #imageLiteral(resourceName: "appicon")
            cell.textLabel?.numberOfLines = -1
        return cell
    }
}


extension SearchController : UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("Typed text:", searchText)
    }
}
