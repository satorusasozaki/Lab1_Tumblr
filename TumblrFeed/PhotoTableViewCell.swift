//
//  PhotoTableViewCell.swift
//  
//
//  Created by Satoru Sasozaki on 10/13/16.
//
//

import UIKit

class PhotoTableViewCell: UITableViewCell {

    @IBOutlet weak var photoImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
