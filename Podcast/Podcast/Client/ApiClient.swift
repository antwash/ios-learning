//  ApiClient.swift
//  Podcast
//  Created by Anthony Washington on 6/10/18.
//  Copyright © 2018 Anthony Washington. All rights reserved.

import Alamofire
import Foundation

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
}
