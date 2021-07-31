//
//  HomeTableViewController.swift
//  Twitter
//
//  Created by Edidiong Ekong on 21/07/2021.
//  Copyright © 2021 Dan. All rights reserved.
//

import UIKit

class HomeTableViewController: UITableViewController {
    let defaults = UserDefaults.standard
   var tweetArray = [NSDictionary]()
    var numberOfTweet :Int!
    let myRefreshControl = UIRefreshControl()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
      //
        loadTweets()
        myRefreshControl.addTarget(self, action: #selector(loadTweets), for: .valueChanged)
        
        tableView.refreshControl = myRefreshControl

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        loadTweets()
    }
    
    @objc func loadTweets()  {
        numberOfTweet = 20
        let url = "https://api.twitter.com/1.1/statuses/home_timeline.json"
        let params = ["count": numberOfTweet]
        
        TwitterAPICaller.client?.getDictionariesRequest(url: url, parameters:  params as [String : Any], success: {  (tweets :[NSDictionary] ) in
            
            self.tweetArray.removeAll()
            for tweet in tweets{
                self.tweetArray.append(tweet)
            }
            self.tableView.reloadData()
            self.myRefreshControl.endRefreshing()
            
        }, failure: {_ in
            
        })
        
        
    }
    
    @objc func loadMoreTweets()  {
        numberOfTweet += 20
        let url = "https://api.twitter.com/1.1/statuses/home_timeline.json"
        let params = ["count": numberOfTweet]
        
        TwitterAPICaller.client?.getDictionariesRequest(url: url, parameters:  params as [String : Any], success: {  (tweets :[NSDictionary] ) in
                        for tweet in tweets{
                self.tweetArray.append(tweet)
            }
            self.tableView.reloadData()
        }, failure: {_ in
            
        })
        
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if (indexPath.row + 1 == tweetArray.count
               ) {
                loadMoreTweets()
            
        }
    }
    

    // MARK: - Table view data source
    @IBAction func logoutFunc(_ sender: Any) {
        TwitterAPICaller.client?.logout()
        self.defaults.set(false, forKey: "isLoggedIn")
        self.dismiss(animated: true) {
            
            
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.tweetArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tweetCell", for: indexPath) as! TweetTableViewCell
        
        cell.tweetLabel.text = tweetArray[indexPath.row]["text"] as? String
        
        let user = tweetArray[indexPath.row]["user"] as! NSDictionary
        
        cell.userLabel.text = user["name"] as? String
        
        let url = URL(string: (user["profile_image_url_https"] as? String)!)
        
        let data = try? Data(contentsOf: url!)
        
        if let imageData = data {
            cell.profileImg.image = UIImage(data: imageData)
        }
        
        let fav = tweetArray[indexPath.row]["favorited"] as? Bool ?? false
        
        cell.setFavorited(fav)
        
        cell.tweetId = tweetArray[indexPath.row]["id"] as! Int
        
        let retweet = tweetArray[indexPath.row]["retweeted"] as? Bool ?? false
        
        cell.setRetweeted(retweet)

        return cell
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
