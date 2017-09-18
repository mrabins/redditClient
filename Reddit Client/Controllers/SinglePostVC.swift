//
//  SinglePostVC.swift
//  Reddit Client
//
//  Created by Mark Rabins on 9/17/17.
//  Copyright © 2017 self. All rights reserved.
//

import UIKit

class SinglePostVC: UIViewController {
    
    // MARK: IBOutlets
    
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var postDateLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    
    var post: Post!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        postImage.imageFromServerURL(urlString: post.thumbnameImage!, defaultImage: "NoImage")
        titleLabel.text = post.title
        authorLabel.text = post.author
        postDateLabel.text = "\(String(describing: post.postDate))"
        commentLabel.text = "\(String(describing: post.sumofComments!))"
        

    }

    
}
