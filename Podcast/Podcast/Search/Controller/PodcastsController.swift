//  PodcastsController.swift
//  Podcast
//  Created by Anthony Washington on 6/9/18.
//  Copyright © 2018 Anthony Washington. All rights reserved.

import UIKit

class PodcastsController: UITableViewController {
    
    var podcasts : [Podcast] = []
    
    let cellId = "podcastCellId"
    let searchController = UISearchController(searchResultsController: nil)
    

    override func tableView(_ tableView: UITableView,
                            heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 132
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        definesPresentationContext = true
        searchController.searchBar.delegate = self
        searchController.dimsBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.register(PodcastCell.self, forCellReuseIdentifier: cellId)
    }
    
    override func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int {
        return podcasts.count
    }
    
    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId,
                                                 for: indexPath) as! PodcastCell
            cell.podcastArtWork.image = nil
            cell.podcastArtWork.sd_cancelCurrentImageLoad()
            cell.podcast = podcasts[indexPath.item]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let episodesController = EpisodesController()
            episodesController.podcast = self.podcasts[indexPath.item]
        navigationController?.pushViewController(episodesController, animated: true)
    }
}


extension PodcastsController : UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else { return }
        
        ApiClient.shared.fetchPodcast(term: text) { (podcasts) in
            self.podcasts = podcasts
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            self.searchBarCancelButtonClicked(searchBar)
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        DispatchQueue.main.async {
            self.podcasts = []
            self.tableView.reloadData()
        }
    }
}
