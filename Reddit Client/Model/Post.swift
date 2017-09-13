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
    var postDate: String?
    var thumbnameImage: String?
    var sumofComments: Int?
    
    init(title: String, author: String, postDate: String, thumbnameImage: String, sumOfComments: Int) {
        self.title = title
        self.author = author
        self.postDate = postDate
        self.sumofComments = sumOfComments
    }
}
