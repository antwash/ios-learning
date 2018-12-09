//
//  ViewController.swift
//  ImageRequest
//
//  Created by Anthony Washington on 12/8/18.
//  Copyright © 2018 Anthony Washington. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let sendHttpRequest : UIButton = {
        let s = UIButton(type: .system)
            s.tag = 1
            s.backgroundColor = .red
            s.setTitle("Get http image", for: .normal)
            s.setTitleColor(.white, for: .normal)
            s.addTarget(self, action: #selector(sendDownLoadRequest), for: .touchUpInside)
        return s
    }()
    
    let sendHttpsRequest : UIButton = {
        let s = UIButton(type: .system)
            s.tag = 2
            s.backgroundColor = .gray
            s.setTitleColor(.white, for: .normal)
            s.setTitle("Get https image", for: .normal)
            s.addTarget(self, action: #selector(sendDownLoadRequest), for: .touchUpInside)
        return s
    }()
    
    let sendBadRequest : UIButton = {
        let s = UIButton(type: .system)
            s.tag = 3
            s.backgroundColor = .blue
            s.setTitleColor(.white, for: .normal)
            s.setTitle("Get image", for: .normal)
            s.addTarget(self, action: #selector(sendDownLoadRequest), for: .touchUpInside)
        return s
    }()
    
    let backgroudImage : UIImageView = {
        let b = UIImageView()
        b.contentMode = .scaleAspectFit
        return b
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        let stackView = UIStackView(arrangedSubviews: [
            sendHttpRequest, sendHttpsRequest, sendBadRequest ] )
            stackView.axis = .vertical
            stackView.spacing = 10
        
        view.addSubview(backgroudImage)
        view.addSubview(stackView)

        stackView.anchors(topAnchor: nil, bottomAnchor: view.safeAreaLayoutGuide.bottomAnchor,
                          leftAnchor: view.leftAnchor, rightAnchor: view.rightAnchor,
                          topPad: 0, bottomPad: 16, leftPad: 24, rightPad: 24,
                          width: 0, height: 0)
        
        backgroudImage.anchors(topAnchor: view.safeAreaLayoutGuide.topAnchor,
                               bottomAnchor: nil,
                               leftAnchor: view.leftAnchor, rightAnchor: view.rightAnchor,
                               topPad: 0, bottomPad: 16, leftPad: 16, rightPad: 16,
                               width: 0, height: 0)
    }
    
    @objc private func sendDownLoadRequest(sender: UIButton) {
        var imageURL: String = KittenImageLocation.error.rawValue
        
        if sender.tag == 1 { imageURL = KittenImageLocation.http.rawValue }
        else if sender.tag == 2 { imageURL = KittenImageLocation.https.rawValue }

        guard let url = URL(string: imageURL) else {
            print("There was an error generating the image URL")

            DispatchQueue.main.async {
                self.backgroudImage.image = nil
            }
            return
        }

        let task =  URLSession.shared.dataTask(with: url) { (data, response, err) in
            guard let data = data else {
                print("Error downloading image: ", err ?? "")
                return
            }
            
            let imageDownloaded = UIImage(data: data)
            
            DispatchQueue.main.async {
                self.backgroudImage.image = imageDownloaded
            }
        }
        
        task.resume()
    }
}


enum KittenImageLocation: String {
    case http = "http://www.kittenswhiskers.com/wp-content/uploads/sites/23/2014/02/Kitten-playing-with-yarn.jpg"
    case https = "https://upload.wikimedia.org/wikipedia/commons/thumb/0/06/Kitten_in_Rizal_Park%2C_Manila.jpg/460px-Kitten_in_Rizal_Park%2C_Manila.jpg"
    case error = "not a url"
}

extension UIView {
    func anchors(topAnchor: NSLayoutYAxisAnchor?,
                 bottomAnchor: NSLayoutYAxisAnchor?,
                 leftAnchor: NSLayoutXAxisAnchor?,
                 rightAnchor: NSLayoutXAxisAnchor?,
                 topPad: CGFloat = 0,
                 bottomPad: CGFloat = 0,
                 leftPad: CGFloat = 0,
                 rightPad: CGFloat = 0,
                 width: CGFloat = 0,
                 height: CGFloat = 0) {
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        if let top = topAnchor {
            self.topAnchor.constraint(equalTo: top, constant: topPad).isActive = true
        }
        
        if let bottom = bottomAnchor {
            self.bottomAnchor.constraint(equalTo: bottom, constant: -bottomPad).isActive = true
        }
        
        if let left = leftAnchor {
            self.leftAnchor.constraint(equalTo: left, constant: leftPad).isActive = true
        }
        
        if let right = rightAnchor {
            self.rightAnchor.constraint(equalTo: right, constant: -rightPad).isActive = true
        }
        
        if height > 0 {
            self.heightAnchor.constraint(equalToConstant: height).isActive = true
        }
        
        if width > 0 {
            self.widthAnchor.constraint(equalToConstant: width).isActive = true
        }
    }
}

