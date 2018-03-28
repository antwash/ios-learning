//  EpisodesController.swift
//  Podcasts-Clone
//  Created by Anthony Washington on 3/26/18.
//  Copyright © 2018 Anthony Washington. All rights reserved.

import UIKit
import FeedKit

class EpisodesController : UITableViewController {
    
    let cellId = "episodeCellId"
    var episodes: [Episode] = []
    var podcast: Podcast? { didSet { self.parseRssFeed() } }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Episodes"
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return episodes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
            cell.textLabel?.text = self.episodes[indexPath.row].title
        return cell
    }
    
    
    fileprivate func parseRssFeed() {
        guard let _url = podcast?.feedUrl else { return }
        
        let httpsUrl = _url.contains("https") ? _url :
            _url.replacingOccurrences(of: "http", with: "https")
        
        guard let url = URL(string: httpsUrl) else { return }
        let parser = FeedParser(URL: url)
        
        parser?.parseAsync(result: { (results) in
            switch results {
            case let .rss(feed):
                feed.items?.forEach({ (item) in
                    self.episodes.append(Episode(title: item.title))
                })
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                break
            default: break
            }
        })
    }
}
