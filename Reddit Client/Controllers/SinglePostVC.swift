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
    var myViewController = ViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        postImage.imageFromServerURL(urlString: post.thumbnameImage!, defaultImage: "NoImage")
        titleLabel.text = post.title
        authorLabel.text = "Author: " + post.author!
        commentLabel.text = "Comments: \(String(describing: post.sumofComments!))"
        let date = Date(timeIntervalSince1970: Double(post.postDate!))
        let dateString = date
        postDateLabel.text = "Posted Time: " + myViewController.timeAgoSinceDate(dateString)
        
        
        /*
         
         cell.postAuthorLabel.text = "Author: " + post.author!
         cell.numberOfCommentsLabel.text = "Comments: \(String(describing: post.sumofComments!))"
         cell.thumbnailImageView.imageFromServerURL(urlString: post.thumbnameImage!, defaultImage: "NoImage")
         
         let date = Date(timeIntervalSince1970: Double(post.postDate!))
         let dateString = date
         cell.createdAtLabel.text = "Posted Time: " + timeAgoSinceDate(dateString)
         
         */
        
    }

    @IBAction func saveImage(_ sender: Any) {
        UIImageWriteToSavedPhotosAlbum(postImage.image!, nil, nil, nil)
    }
    
}
