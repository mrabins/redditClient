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
        
        DataServices.callAPI({ (posts) in
            self.posts = posts
            DispatchQueue.main.async {
                self.postsTableView.reloadData()
            }
            
        }) { (errorMessage) in
            print("An error occured \(errorMessage.debugDescription)")
        }
    }
}



// MARK: UITableViewDelegate
extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("I was selected")
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 175.0
    }
}

// MARK: UITableViewDataSource
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("I am the posts count \(posts.count)")
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as? PostsTableViewCell {
            let post = posts[indexPath.row]
            cell.postTitleLabel.text = post.title
            cell.postAuthorLabel.text = post.author
            cell.numberOfCommentsLabel.text = "\(String(describing: post.sumofComments))"
            print("I am a cell my title is \(cell.postAuthorLabel.text) and my sumOf comments are \(cell.numberOfCommentsLabel.text)")
        }
        return PostsTableViewCell()
    }
    
}
