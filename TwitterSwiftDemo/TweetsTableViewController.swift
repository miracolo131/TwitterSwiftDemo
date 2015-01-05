//
//  TweetsTableViewController.swift
//  TwitterSwiftDemo
//
//  Created by Miracolo Bosco on 15/1/5.
//  Copyright (c) 2015年 MI-31. All rights reserved.
//

import UIKit
import TwitterKit

class TweetsTableViewController: UITableViewController, TWTRTweetViewDelegate {
    
    // 给推文设置容器
    var tweets: [TWTRTweet] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    var prototypeCell: TWTRTweetTableViewCell?
    let tweetTableCellReuseIdentifier = "TweetCell"
//    var isLoadingTweets = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // TODO：将navigationBar显示出来
        self.navigationController?.navigationBarHidden = false
        
        // 创建一个prototypeCell用来计算cell的高度
        self.prototypeCell = TWTRTweetTableViewCell(style: .Subtitle, reuseIdentifier: tweetTableCellReuseIdentifier)
        
        // 注册cell
        self.tableView.registerClass(TWTRTweetTableViewCell.self, forCellReuseIdentifier: tweetTableCellReuseIdentifier)
        
        // 设置数据
        loadTweets()
    }
    
    func loadTweets() {
        getHomeTimeline({
            twttrs in
            for tweet in twttrs {
                self.tweets.append(tweet)
            }
            }, error: {
                error in
                println(error.localizedDescription)
        })
    }
    
    func getHomeTimeline(tweets: [TWTRTweet]->(), error: (NSError) -> ()) {
        var clientError : NSError?
        let statusesHomeTimeline = "https://api.twitter.com/1.1/statuses/home_timeline.json"
        let request = Twitter.sharedInstance().APIClient.URLRequestWithMethod("GET", URL: statusesHomeTimeline, parameters: nil, error: &clientError)
        
        if request != nil {
            Twitter.sharedInstance().APIClient.sendTwitterRequest(request, completion: {
                response, data, err in
                if err == nil {
                    var jsonError: NSError?
                    let json: AnyObject? =  NSJSONSerialization.JSONObjectWithData(data,
                        options: nil,
                        error: &jsonError)
                    if let jsonArray = json as? NSArray {
                        tweets(TWTRTweet.tweetsWithJSONArray(jsonArray) as [TWTRTweet])
                    }
                } else {
                    error(err)
                }
            })
        }
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
//    override func viewDidAppear(animated: Bool){
//        super.viewDidAppear(animated)
//        self.navigationController?.navigationBar.translucent = false
//        println("run")
//    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        println("count = \(tweets.count)")
        return tweets.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCellWithIdentifier("TweetCell") as TWTRTweetTableViewCell
        
        let tweet = tweets[indexPath.row]
        cell.configureWithTweet(tweet)
        println("tweet = \(tweet)")
        
        return cell
    }
    
    override func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let tweet = tweets[indexPath.row]
//        println("tweet = \(tweet)")
        
        prototypeCell?.configureWithTweet(tweet)
        
        if let height = prototypeCell?.calculatedHeightForWidth(self.view.bounds.width) {
            return height
        } else {
            return tableView.estimatedRowHeight
        }

    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
