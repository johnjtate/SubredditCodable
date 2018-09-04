//
//  PostController.swift
//  SubredditCodable
//
//  Created by John Tate on 9/4/18.
//  Copyright © 2018 John Tate. All rights reserved.
//

import UIKit

class PostController {
    
    static let shared = PostController()
    private init() {}
    
    // MARK: - Properties
    let baseURLString = "https://www.reddit.com/r"
    
    var posts: [Post] = []
    
    func fetchPosts(by searchTerm: String, completion: @escaping ([Post]?) -> Void) {
    
        guard let baseURL = URL(string: baseURLString) else {
            fatalError("Bad base URL")
        }
        
        let requestURL = baseURL.appendingPathComponent(searchTerm).appendingPathExtension("json")
        
        URLSession.shared.dataTask(with: requestURL) { (data, _, error) in
            
            do {
                if let error = error { throw error }
                guard let data = data else { throw NSError() }
                let jsonDictionary = try JSONDecoder().decode(JSONDictionary.self, from: data)
                let postsWithoutImages = jsonDictionary.data.children.compactMap{ $0.post }
                self.posts = postsWithoutImages
                completion(postsWithoutImages)
           
            } catch let error {
                print("Error fetching posts from subreddit \(error) \(error.localizedDescription)")
                completion(nil); return
            }
            
            
        }.resume()
    }
    
    
}
