//
//  Service.swift
//  Twitter-Clone
//
//  Created by Anthony Washington on 7/4/17.
//  Copyright © 2017 Anthony Washington. All rights reserved.
//

import TRON
import SwiftyJSON

class Error: JSONDecodable {
    required init(json: JSON) throws {
        print("JSON error \n")
    }
}


struct Service {
    let tron = TRON(baseURL: "https://api.letsbuildthatapp.com/")
    static let sharedInstance = Service()
    
    func fetchData(completion: @escaping (HomeDataSource) -> ()){
        let request: APIRequest<HomeDataSource,Error> = tron.request("/twitter/home")
        request.perform(withSuccess: { (homeDataSource) in
            // pass datasouce to completion handler function caller
            completion(homeDataSource)
        }) { (err) in
            print("Failed to fetch JSON ", err )
        }
    }
}
