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
}
    
    
    
    // MARK: UITableViewDelegate
    extension ViewController: UITableViewDelegate {
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            print("I was selected")
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
                cell.postAuthorLabel.text = post.author
                cell.numberOfCommentsLabel.text = "\(String(describing: post.sumofComments!))"
                cell.thumbnailImageView.imageFromServerURL(urlString: post.thumbnameImage!, defaultImage: "NoImage")
                cell.createdAtLabel.text = "\(String(describing: post.postDate))"
                
            }
            return PostsTableViewCell()
        }
        
}
