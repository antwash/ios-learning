//  ApiClient.swift
//  Podcasts-Clone
//  Created by Anthony Washington on 3/25/18.
//  Copyright © 2018 Anthony Washington. All rights reserved.

import Foundation
import Alamofire

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
}
