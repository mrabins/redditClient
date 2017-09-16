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
            print("the Posts are")
            
            self.posts = posts
            DispatchQueue.main.async {
                self.postsTableView.reloadData()
            }
        }) { (errorMessage) in print(errorMessage)}
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
        return 20
        //return posts.count exchange above line for this when ready
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        postsTableViewCell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as! PostsTableViewCell
        
        return postsTableViewCell
        
    }
}


