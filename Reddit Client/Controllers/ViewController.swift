//
//  ViewController.swift
//  Reddit Client
//
//  Created by Mark Rabins on 9/12/17.
//  Copyright © 2017 self. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: IBOutlets
    @IBOutlet weak var postsTableView: UITableView!
    
    // MARK: Global Variablea
    var posts: [Post] = []
    var postsTableViewCell = PostsTableViewCell()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        postsTableView.delegate = self
        postsTableView.dataSource = self
        
        DataServices.callAPI({ posts in
            self.posts = posts
            
            DispatchQueue.main.async {
                self.postsTableView.reloadData()
            }
        }) { (errorMessage) in
            print("An error occured \(errorMessage.debugDescription)")}
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SinglePostSegue" {
            let vc = segue.destination as! SinglePostVC
            let post = sender as! Post
            vc.post = post
        }
    }
    
    func timeAgoSinceDate(_ date: Date) -> String {
        let calendar = NSCalendar.current
        let unitFlags: Set<Calendar.Component> = [.minute, .hour, .day, .weekOfYear, .month, .year, .second]
        let now = Date()
        let earliest = now < date ? now : date
        let latest = (earliest == now) ? date : now
        let components = calendar.dateComponents(unitFlags, from: earliest,  to: latest)
        
        if (components.year! >= 2) {
            return "\(components.year!) years ago"
        } else if (components.year! >= 1){
                return "Last year"
        } else if (components.month! >= 2) {
            return "\(components.month!) months ago"
        } else if (components.month! >= 1){
                return "Last month"
        } else if (components.weekOfYear! >= 2) {
            return "\(components.weekOfYear!) weeks ago"
        } else if (components.weekOfYear! >= 1){
                return "Last week"
        } else if (components.day! >= 2) {
            return "\(components.day!) days ago"
        } else if (components.day! >= 1){
                return "Yesterday"
        } else if (components.hour! >= 2) {
            return "\(components.hour!) hours ago"
        } else if (components.hour! >= 1){
                return "An hour ago"
        } else if (components.minute! >= 2) {
            return "\(components.minute!) minutes ago"
        } else if (components.minute! >= 1){
                return "A minute ago"
        } else if (components.second! >= 3) {
            return "\(components.second!) seconds ago"
        } else {
            return "Just now"
        }
        
    }
}

// MARK: UITableViewDelegate
extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let indexPath = postsTableView.indexPathForSelectedRow
        let thePost: Post
        thePost = posts[(indexPath?.row)!]
        
        performSegue(withIdentifier: "SinglePostSegue", sender: thePost)
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 175.0
    }
}

// MARK: UITableViewDataSource
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as? PostsTableViewCell {
            let post = posts[indexPath.row]
            cell.postTitleLabel.text = post.title
            cell.postAuthorLabel.text = "Author: " + post.author!
            cell.numberOfCommentsLabel.text = "Comments: \(String(describing: post.sumofComments!))"
            cell.thumbnailImageView.imageFromServerURL(urlString: post.thumbnameImage!, defaultImage: "NoImage")
            
            let date = Date(timeIntervalSince1970: Double(post.postDate!))
            let dateString = date
            cell.createdAtLabel.text = "Posted Time: " + timeAgoSinceDate(dateString)
            
        }
        return PostsTableViewCell()
    }
    
}

