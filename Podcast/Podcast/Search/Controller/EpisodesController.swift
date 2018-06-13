//  EpisodesController.swift
//  Podcast
//  Created by Anthony Washington on 6/10/18.
//  Copyright © 2018 Anthony Washington. All rights reserved.

import UIKit

class EpisodesController : UITableViewController {
    
    var podcast : Podcast! {
        didSet {
            navigationItem.title = podcast.trackName
            fetchEpisodes()
        }
    }
    
    var episodes : [Episode] = []
    
    let cellId = "episodeCellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.register(EpisodeCell.self, forCellReuseIdentifier: cellId)
    }
    
    
    override func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int {
        return episodes.count
    }
    
    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId,
                                                 for: indexPath) as! EpisodeCell
            cell.episodeArtwork.image = nil
            cell.episodeArtwork.sd_cancelCurrentImageLoad()
            cell.episode = episodes[indexPath.item]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let audioPlayer = AudioPlayerController()
        navigationController?.present(audioPlayer, animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView,
                            heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 132
    }
    
    fileprivate func fetchEpisodes() {
        let link = podcast.feedUrl ?? ""
        let img = podcast.artworkUrl600 ?? ""

        ApiClient.shared.fetchEpisodes(link: link, img: img) { (episodes) in
            DispatchQueue.main.async {
                self.episodes = episodes
                self.tableView.reloadData()
            }
        }
    }
}
