//
//  TweetCellTableViewCell.swift
//  Twitter
//
//  Created by Jonah Tjandra on 3/11/22.
//  Copyright © 2022 Dan. All rights reserved.
//

import UIKit

class TweetCellTableViewCell: UITableViewCell {
    var liked: Bool = false
    
    var retweeted: Bool = false
    
    var tweetId: Int = -1
    
    var isDirtyLike: Bool = false
    
    var isDirtyRetweet: Bool = false

    @IBOutlet weak var tweetImage: UIImageView!
    
    @IBOutlet weak var tweetName: UILabel!
    
    @IBOutlet weak var tweetLabel: UILabel!
    
    @IBOutlet weak var likeButton: UIButton!
    
    @IBOutlet weak var retweetButton: UIButton!
    
    @IBAction func likeTweet(_ sender: Any) {
        isDirtyLike = true
        if (!liked) {
            liked = true
            TwitterAPICaller.client?.likeTweet(tweetId: self.tweetId, success: {
                self.setLiked(true)
            }, failure: { Error in
                print("error when liking tweet: \(Error)")
            })
        } else {
            liked = false
            TwitterAPICaller.client?.unlikeTweet(tweetId: self.tweetId, success: {
                self.setLiked(false)
            }, failure: { Error in
                print("error when unliking tweet: \(Error)")
            })
        }
    }
    
    @IBAction func retweet(_ sender: Any) {
        isDirtyRetweet = true
        retweeted = true
        TwitterAPICaller.client?.retweet(tweetId: self.tweetId, success: {
            self.setRetweeted(true)
        }, failure: { Error in
            print("error when retweeting: \(Error)")
        })
    }
    
    func setLiked(_ isLiked: Bool) {
        if (!isDirtyLike) {
            liked = isLiked
        }
        if (liked) {
            likeButton.setImage(UIImage(named: "favicon_red"), for: UIControl.State.normal)
            print("liked!")
        } else {
            likeButton.setImage(UIImage(named: "favicon"), for: UIControl.State.normal)
            print("unliked!")
        }
    }
    
    func setRetweeted(_ isRetweeted: Bool) {
        if (!isDirtyRetweet) {
            retweeted = isRetweeted
        }
        if (retweeted) {
            retweetButton.setImage(UIImage(named: "retweet_green"), for: UIControl.State.normal)
            print("retweet!")
        } else {
            retweetButton.setImage(UIImage(named: "retweet"), for: UIControl.State.normal)
            print("unretweet!")
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
    
    func configure() {
        tweetLabel.sizeToFit()
    }

}
