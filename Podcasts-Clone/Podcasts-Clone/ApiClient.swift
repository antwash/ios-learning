//  ApiClient.swift
//  Podcasts-Clone
//  Created by Anthony Washington on 3/25/18.
//  Copyright © 2018 Anthony Washington. All rights reserved.

import Foundation
import Alamofire
import FeedKit

class ApiClient {
    
    static let shared = ApiClient()
    
    func fetchPodCasts(podcast: String, completionHandler: @escaping ([Podcast]) -> ()) {
        let url = "https://itunes.apple.com/search"
        let parameters = ["term" : podcast,
                          "media" : "podcast"]
        
        Alamofire.request(url, method: .get, parameters:
            parameters, encoding: URLEncoding.default, headers:
            nil).response { (dataResponse) in
                
                if let err = dataResponse.error {
                    print("Error: failed to perform request", err)
                }
                
                guard let data = dataResponse.data else { return }
                do {
                    let results = try JSONDecoder().decode(SearchResults.self, from: data)
                    completionHandler(results.results)
                }
                catch let err {
                print("Error: failed to decode data:", err)
            }
        }
    }

    func parseRSSFeed(feedUrl: String, completionHandler: @escaping ([Episode]) -> ()) {
        let _url = feedUrl.secureHttps()
        guard let url = URL(string: _url) else { return }
        
        DispatchQueue.global(qos: .background).async {
            var episodes: [Episode] = []
            let parser = FeedParser(URL: url)
            
            parser?.parseAsync(result: { (results) in
                if let err = results.error {
                    print("Error parsing RSS feed:", err)
                    return
                }
                
                guard let feed = results.rssFeed else { return }
                let tempImageURL = feed.iTunes?.iTunesImage?.attributes?.href
                
                feed.items?.forEach({ (item) in
                    episodes.append(Episode(item: item, image: tempImageURL!))
                })
                
                completionHandler(episodes)
            })
        }
    }
}
