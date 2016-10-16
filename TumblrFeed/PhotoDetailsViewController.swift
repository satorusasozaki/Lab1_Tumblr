//
//  PhotoDetailsViewController.swift
//  TumblrFeed
//
//  Created by Satoru Sasozaki on 10/13/16.
//  Copyright © 2016 Satoru Sasozaki. All rights reserved.
//

import UIKit

class PhotoDetailsViewController: UIViewController {
    @IBOutlet weak var photoImageView: UIImageView!
    var photoUrl: URL?

    override func viewDidLoad() {
        super.viewDidLoad()
        photoImageView.setImageWith(photoUrl!)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
