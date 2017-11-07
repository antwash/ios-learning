//  CustomImageView.swift
//  Instagram
//  Created by Anthony Washington on 11/5/17.
//  Copyright © 2017 Anthony Washington. All rights reserved.

import UIKit

var imageCache: [String: UIImage] = [:]

class CustomImageView: UIImageView {
    
    var lastUrlLoaded: String?
    
    func loadImage(url: String) {
        lastUrlLoaded = url
        
        if let cachedImage = imageCache[url] {
            self.image = cachedImage
            return
        }
        
        guard let url = URL(string: url) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let err = error {
                print("Failed to download image:", err)
                return
            }
            
            // if not URL I tell to load return
            if url.absoluteString != self.lastUrlLoaded { return }
            
            guard let data = data else { return }
            guard let image = UIImage(data: data) else { return }
            imageCache[url.absoluteString] = image
            
            DispatchQueue.main.async {
                self.image = image
            }
        }.resume()
    }
}
