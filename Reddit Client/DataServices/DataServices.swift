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
        let request = URLRequest(url: url)
        
        let task = session.dataTask(with: request) { (data, response, error) in
            if let data = data {
                
                if let response = response as? HTTPURLResponse , 200...299 ~= response.statusCode {
                    
                    do {
                        if NSString(data:data, encoding: String.Encoding.utf8.rawValue) != nil {
                            
                            // Parse the Json
                            let jsonDictionary = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary
                       
                           
                            var result: [Post] = []

                            success(result)
                        } else {
                            errorCallback("No Valid Information")
                        }
                    } catch {
                        print("Data was not properly formatted")
                    }
                } else {
                    print("Not a 200 response")
                    errorCallback(error as! String)
                    return
                }
            }
        }
        task.resume()
}
}
