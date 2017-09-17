//
//  DataServices.swift
//  Reddit Client
//
//  Created by Mark Rabins on 9/12/17.
//  Copyright © 2017 self. All rights reserved.
//

import Foundation

class DataServices {
    
    class func callAPI(_ success: @escaping (_ posts: [Post]) -> (), error errorCallback: @escaping (_ errorMessage: String) -> ()) {
        
        let getEndpoint = BASE_URL + REQUEST_CATEGORY + TYPE_OF_DATA
        let session = URLSession.shared
        let url = URL(string: getEndpoint)!
        var posts = [Post]()
        
        let task = session.dataTask(with: url) { (data, response, error) in
            guard let data = data else {
                return
            }
            
            do {
                let object = try JSONSerialization.jsonObject(with: data, options: [])
                
                guard let rootDict = object as? [String: AnyObject],
                    let data = rootDict["data"] as? [String: AnyObject],
                    let children = data["children"] as? [[String: AnyObject]] else {
                        return
                }
                
                for child in children {
                    if let childData = child["data"] as? [String: AnyObject] {
                        let post = Post(jsonDict: childData)
                        if let post = post {
                            print("I am a post \(post)")
                            posts.append(post)
                        }
                    }
                }
                
            } catch {
                print("JSON Error!\(error.localizedDescription)")
            }
        }
        
        task.resume()
    }
}
