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
    
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var likeButton: UIButton!
    var favorited = false
    var tweetId:Int = -1
    var isRetweeted = false

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setFavorited(_ isFavorited:Bool){
        favorited = isFavorited
        if(favorited){
            likeButton.setImage(UIImage(named: "favor-icon-red"), for: UIControl.State.normal)
             }
        else{
            likeButton.setImage(UIImage(named: "favor-icon"), for: UIControl.State.normal)
             }
    }
    
    func setRetweeted(_ isFavorited:Bool){
        isRetweeted = isFavorited
        
        if isRetweeted {
            
            retweetButton.setImage(UIImage(named: "retweet-icon-green"), for: UIControl.State.normal)
            retweetButton.isEnabled = false
    } else{
   retweetButton.setImage(UIImage(named: "retweet-icon"), for: UIControl.State.normal)
        retweetButton.isEnabled = true

     }

    }
    
    @IBAction func retweetAction(_ sender: Any) {
    
            TwitterAPICaller.client?.retweet(tweetId: tweetId, success: {
                self.setRetweeted(true)
                        }, failure: { _ in
            
            })
       
    }
    
    @IBAction func likeAction(_ sender: Any) {
        let tobe = !favorited
        if tobe {
            TwitterAPICaller.client?.favoriteTweet(tweetId: tweetId, success: {
                self.setFavorited(true)
                        }, failure: { Error in
            
            })
        }else{
            TwitterAPICaller.client?.unFavoriteTweet(tweetId: tweetId, success: {
                self.setFavorited(false)

            }, failure: { _ in
             
            })
        }
      
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
