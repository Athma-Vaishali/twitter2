//
//  TweetCellTableViewCell.swift
//  Twitter
//

import UIKit

class TweetCellTableViewCell: UITableViewCell {
    var favorited:Bool=false
    var tweetId:Int = -1
//    var retweeted:Bool=false
    

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var userNamelabel: UILabel!
    @IBOutlet weak var tweetContent: UILabel!
    
    @IBOutlet weak var favButton: UIButton!

    @IBOutlet weak var rtButton: UIButton!
    
    @IBAction func favAction(_ sender: Any) {
        let toBeFavorited = !favorited
        if(toBeFavorited){
            TwitterAPICaller.client?.favoriteTweet(tweetId: tweetId, success: {
                self.setFavorite(true)
            }, failure: { (error) in
                print("Favorite did not succeed \(error)")
            })
        }else{
            TwitterAPICaller.client?.unfavoriteTweet(tweetId: tweetId, success: {
                self.setFavorite(false)
            }, failure: { (error) in
                print("Unfavorite did not succeed \(error)")
            })
        }
    }
    
    @IBAction func rtAction(_ sender: Any) {
        TwitterAPICaller.client?.retweet(tweetId: tweetId, success: {
            self.setRetweeted(true)
        }, failure: { (error) in
            print("Error in retweeting \(error)")
        })
    }
    
    func setRetweeted(_ isRetweeted:Bool){
        if(isRetweeted){
            rtButton.setImage(UIImage(named: "retweet-icon-green"), for: UIControl.State.normal)
            rtButton.isEnabled=false
        }else{
            rtButton.setImage(UIImage(named: "retweet-icon"), for: UIControl.State.normal)
            rtButton.isEnabled=true
        }
    }
    
    func setFavorite(_ isFavorited:Bool){
        favorited=isFavorited
        if(favorited){
            favButton.setImage(UIImage(named: "favor-icon-red"),for:UIControl.State.normal)
        }else{
            favButton.setImage(UIImage(named: "favor-icon"),for:UIControl.State.normal)
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
