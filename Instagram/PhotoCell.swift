//
//  PhotoCell.swift
//  Instagram
//
//  Created by Sang Saephan on 3/9/17.
//  Copyright © 2017 Sang Saephan. All rights reserved.
//

import UIKit
import Parse

class PhotoCell: UITableViewCell {

    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var captionLabel: UILabel!
    
    var img: PFObject! {
        didSet {
            captionLabel.text = img.object(forKey: "caption") as? String
            
            let imageData = img.object(forKey: "media") as? PFFile
            imageData?.getDataInBackground(block: { (imageinfo: Data?, error: Error?) in
                if(error == nil) {
                    let picture = UIImage(data: imageinfo!)
                    self.posterImageView.image = picture
                }
            })
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
