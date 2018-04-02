//  EpisodesController.swift
//  Podcasts-Clone
//  Created by Anthony Washington on 3/26/18.
//  Copyright © 2018 Anthony Washington. All rights reserved.

import UIKit

class EpisodesController : UITableViewController {
    
    let cellId = "episodeCellId"

    var episodes: [Episode] = []
    var podcast: Podcast? { didSet { self.parseRssFeed() } }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Episodes"
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.register(EpisodeCell.self, forCellReuseIdentifier: cellId)
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 132
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return episodes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! EpisodeCell
            cell.feedEpisode = self.episodes[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let podcastPlayer = PlayerView()
            podcastPlayer.frame = view.frame
            podcastPlayer.episode = self.episodes[indexPath.row]
    
        let window = UIApplication.shared.keyWindow
            window?.addSubview(podcastPlayer)
    }
    
    
    override func tableView(_ tableView: UITableView,
                            viewForFooterInSection section: Int) -> UIView? {
        let activityView = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
            activityView.color = .darkGray
            activityView.startAnimating()
        return activityView
    }
    
    override func tableView(_ tableView: UITableView,
                            heightForFooterInSection section: Int) -> CGFloat {
        return episodes.isEmpty ? 250 : 0
    }
    
    fileprivate func parseRssFeed() {
        guard let url = podcast?.feedUrl else { return }
        ApiClient.shared.parseRSSFeed(feedUrl: url) { (episodes) in
            self.episodes = episodes
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}
