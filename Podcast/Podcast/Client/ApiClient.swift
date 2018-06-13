//  ApiClient.swift
//  Podcast
//  Created by Anthony Washington on 6/10/18.
//  Copyright © 2018 Anthony Washington. All rights reserved.

import Alamofire
import FeedKit

class ApiClient {
    static let shared = ApiClient()
    
    func fetchPodcast(term: String, completionHandler: @escaping ([Podcast]) -> ()) {
        let url = "https://itunes.apple.com/search"
        let parameters = ["term" : term, "media" : "podcast"]
        
        Alamofire.request(url, method: .get, parameters:
            parameters, encoding: URLEncoding.default, headers:
            nil).response { (dataResponse) in
                
                if let err = dataResponse.error {
                    print("Error finding matching podcast: ", err)
                    completionHandler([])
                    return
                }
                
                guard let data = dataResponse.data else { return }
                do {
                    let results = try JSONDecoder().decode(SearchResults.self, from: data)
                    completionHandler(results.results)
                } catch let err {
                    print("Failed to decode data: ", err)
                    completionHandler([])
            }
        }
    }
    
    func fetchEpisodes(link : String, img: String,
                       completionHandler: @escaping ([Episode]) -> ()) {
        var episodes : [Episode] = []
        if !link.isEmpty {
            guard let url = URL(string: link) else { return }
            let parser = FeedParser(URL: url)
            
            parser?.parseAsync(queue: DispatchQueue.global(qos:
                .userInitiated), result: { (result) in
                
                guard let feed = result.rssFeed, result.isSuccess else {
                    print("Error getting rssFeed: ", result.error ?? "")
                    return
                }
                
                feed.items?.forEach({ (feedItem) in
                    episodes.append(Episode(feedItem: feedItem,
                                            parentImage: img))
                })

                completionHandler(episodes)
            })
        }
        completionHandler([])
    }
}





