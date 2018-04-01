//  SearchController.swift
//  Podcasts-Clone
//  Created by Anthony Washington on 3/24/18.
//  Copyright © 2018 Anthony Washington. All rights reserved.

import UIKit

class SearchController: UITableViewController {
    
    let cellId = "podcastCellId"
    let searchController = UISearchController(searchResultsController: nil)

    var podcast : [Podcast] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        definesPresentationContext = true
        tableView.alwaysBounceVertical = false
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.register(SearchCell.self, forCellReuseIdentifier: cellId)
        
        searchController.searchBar.delegate = self
        searchController.dimsBackgroundDuringPresentation = false

        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        
        searchBar(searchController.searchBar, textDidChange: "Voong")
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let message = UILabel()
            message.textAlignment = .center
            message.text = "Search for your favorite podcast"
            message.font = UIFont.systemFont(ofSize: 15, weight: .medium)
            message.textColor = .purple
        return message
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let center = self.tableView.frame.height / 2
        return (self.podcast.count == 0) ? center : 0
    }

    override func tableView(_ tableView: UITableView,
                            heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 132
    }
        
    override func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int {
        return podcast.count
    }
    
    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId,
                                                 for: indexPath) as! SearchCell
            cell.podcast = self.podcast[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let episodesController = EpisodesController()
            episodesController.podcast = self.podcast[indexPath.row]
        navigationController?.pushViewController(episodesController, animated: true)
    }
}

extension SearchController : UISearchBarDelegate {
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.podcast = []
        self.tableView.reloadData()
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        ApiClient.shared.fetchPodCasts(podcast: searchText) { (podcasts) in
            self.podcast = podcasts
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}
