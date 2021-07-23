//
//  TweetTableViewCell.swift
//  Twitter
//
//  Created by Edidiong Ekong on 22/07/2021.
//  Copyright © 2021 Dan. All rights reserved.
//

import UIKit

class TweetTableViewCell: UITableViewCell {

    
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var tweetLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
