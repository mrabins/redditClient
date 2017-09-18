//
//  Post.swift
//  Reddit Client
//
//  Created by Mark Rabins on 9/12/17.
//  Copyright © 2017 self. All rights reserved.
//

import Foundation

struct Post {
    
    var title: String?
    var author: String?
    var postDate: Int?
    var thumbnameImage: String?
    var sumofComments: Int?
    
    init?(jsonDict: [String: AnyObject]) {
        guard let thumbnameImage = jsonDict["thumbnail"] as? String,
            let title = jsonDict["title"] as? String,
            let author = jsonDict["author"] as? String,
            let sumofComments = jsonDict["num_comments"] as? Int,
            let postDate = jsonDict["created_utc"] as? Int  else {
                return nil
        }
        
        self.thumbnameImage = thumbnameImage
        self.title = title
        self.author = author
        self.sumofComments = sumofComments
        self.postDate = postDate
    }
}
