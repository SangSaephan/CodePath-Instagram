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
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    var img: PFObject! {
        didSet {
            let user = img.object(forKey: "author") as? PFUser
            let date = img.object(forKey: "date") as? Date
            
            captionLabel.text = img.object(forKey: "caption") as? String
            
            // Set date created if one is available
            if date != nil {
                dateLabel.text = calculateTimeStamp(timePostedAgo: (date?.timeIntervalSinceNow)!)
            } else {
                dateLabel.text = ""
            }
            
            // Only display username if there is a caption, just like real Instagram
            if captionLabel.text == "" {
                usernameLabel.text = ""
            } else {
                usernameLabel.text = user?.username!
            }
            
            let imageData = img.object(forKey: "media") as? PFFile
            imageData?.getDataInBackground(block: { (imageinfo: Data?, error: Error?) in
                if(error == nil) {
                    let picture = UIImage(data: imageinfo!)
                    self.posterImageView.image = picture
                }
            })
        }
    }
    
    // All credit for this method goes to David Wayman, slack @dwayman
    func calculateTimeStamp(timePostedAgo: TimeInterval) -> String {
        // Turn timeTweetPostedAgo into seconds, minutes, hours, days, or years
        var rawTime = Int(timePostedAgo)
        var timeAgo: Int = 0
        var timeChar = ""
        
        rawTime = rawTime * (-1)
        
        // Figure out time ago
        if (rawTime <= 60) { // SECONDS
            timeAgo = rawTime
            timeChar = "SECONDS AGO"
        } else if ((rawTime/60) <= 60) { // MINUTES
            timeAgo = rawTime/60
            timeChar = "MINUTES AGO"
        } else if (rawTime/60/60 <= 24) { // HOURS
            timeAgo = rawTime/60/60
            timeChar = "HOURS AGO"
        } else if (rawTime/60/60/24 <= 365) { // DAYS
            timeAgo = rawTime/60/60/24
            timeChar = "DAYS AGO"
        } else if (rawTime/(3153600) <= 1) { // YEARS
            timeAgo = rawTime/60/60/24/365
            timeChar = "YEARS AGO"
        }
        
        return "\(timeAgo) \(timeChar)"
    }

}
