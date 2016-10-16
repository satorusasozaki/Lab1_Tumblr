//
//  APIManager.swift
//  TumblrFeed
//
//  Created by Satoru Sasozaki on 10/11/16.
//  Copyright © 2016 Satoru Sasozaki. All rights reserved.
//

import Foundation

class APIManager: NSObject {
    private static let apiKey = "Q6vHoaVm5L1u2ZAW1fqv3Jw48gFzYVg9P0vH0VHl3GVy6quoGV"
    private static let url = URL(string:"https://api.tumblr.com/v2/blog/humansofnewyork.tumblr.com/posts/photo?api_key=\(apiKey)")
    
    class func get(closure: (NSDictionary) -> (Void)) -> Void {
        let request = URLRequest(url: url!)
        let session = URLSession(
            configuration: URLSessionConfiguration.default,
            delegate:nil,
            delegateQueue:OperationQueue.main
        )
        
        let task : URLSessionDataTask = session.dataTask(with: request,completionHandler: { (dataOrNil, response, error) in
            if let data = dataOrNil {
                if let responseDictionary = try! JSONSerialization.jsonObject(with: data, options:[]) as? NSDictionary {
                    NSLog("response: \(responseDictionary)")
//                    let photosArray = responseDictionary["response"]["posts"]
                    let response = responseDictionary.object(forKey: "response") as! NSDictionary
                    let posts = response.object(forKey: "posts") as! [NSDictionary]
                    var photosArray = [String]()
                    for post in posts {
                        let photoUrl = post["image_permalink"] as! String
                        print(photoUrl)
                        photosArray.append(photoUrl)
                    }
                }
            }
        });
        task.resume()
    }
}


