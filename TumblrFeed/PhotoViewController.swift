//
//  ViewController.swift
//  TumblrFeed
//
//  Created by Satoru Sasozaki on 10/11/16.
//  Copyright © 2016 Satoru Sasozaki. All rights reserved.
//

import UIKit
import AFNetworking

class PhotoViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    static let apiKey = "Q6vHoaVm5L1u2ZAW1fqv3Jw48gFzYVg9P0vH0VHl3GVy6quoGV"
    let url = URL(string:"https://api.tumblr.com/v2/blog/humansofnewyork.tumblr.com/posts/photo?api_key=\(apiKey)")
    //var photosArray: [String]?
    
    var response: NSDictionary?
    var photosArray: [String]?
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        title = "Tumblr Feed"
        photosArray = [String]()
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(PhotoViewController.getResponse(refreshControl:)), for: UIControlEvents.valueChanged)
        getResponse(refreshControl: refreshControl)
        tableView.insertSubview(refreshControl, at: 0)
        tableView.rowHeight = 320
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (photosArray?.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "photoTableViewCell") as! PhotoTableViewCell
        let urlString = photosArray?[indexPath.row] //as! String
        print(indexPath.row)
        print(urlString)
        let url = NSURL(string: urlString!) as! URL
        cell.photoImageView.setImageWith(url)
        return cell
    }
    
    func getResponse(refreshControl: UIRefreshControl) {
        let request = URLRequest(url: url!)
        let session = URLSession(
            configuration: URLSessionConfiguration.default,
            delegate:nil,
            delegateQueue:OperationQueue.main
        )
        
        let task : URLSessionDataTask = session.dataTask(with: request,completionHandler: { (dataOrNil, response, error) in
            if let data = dataOrNil {
                if let responseDictionary = try! JSONSerialization.jsonObject(with: data, options:[]) as? NSDictionary {
                    self.response = responseDictionary.object(forKey: "response") as? NSDictionary
                    self.photosArray = self.getPhotosUrls(response: self.response!)
                    self.tableView.reloadData()
                    refreshControl.endRefreshing()
                }
            }
        });
        task.resume()
    }
    
    func getPhotosUrls(response: NSDictionary) -> [String] {
        let posts = response.object(forKey: "posts") as! [NSDictionary]
        var photosArray = [String]()
        for post in posts {
            let photos = post.object(forKey: "photos") as! [NSDictionary]
            //let original = photos[0].object(forKey: "original_size") as! NSDictionary
            let original = photos[0].object(forKey: "original_size") as! NSDictionary
            let url = original.object(forKey: "url") as! String
            photosArray.append(url)
        }
        return photosArray
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! PhotoDetailsViewController
        var indexPath = tableView.indexPathForSelectedRow
        let url = photosArray?[(indexPath?.row)!]
        vc.photoUrl = NSURL(string: url!) as? URL
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}



