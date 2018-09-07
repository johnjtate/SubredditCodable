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
    let baseURLString = "https://www.reddit.com/r/"
    
    var posts: [Post] = []
    
    func fetchPosts(by searchTerm: String, completion: @escaping () -> Void) {
    
        guard let baseURL = URL(string: baseURLString) else {
            fatalError("Bad base URL")
        }
        
        let requestURL = baseURL.appendingPathComponent(searchTerm).appendingPathExtension("json")
        
        URLSession.shared.dataTask(with: requestURL) { (data, _, error) in
            
            do {
                if let error = error { throw error }
                guard let data = data else { throw NSError() }
                let jsonDictionary = try JSONDecoder().decode(JSONDictionary.self, from: data)
                let postsWithoutImages = jsonDictionary.data.children.compactMap({ $0.post })
                self.posts = postsWithoutImages
                completion()
           
            } catch let error {
                print("Error fetching posts from subreddit \(error) \(error.localizedDescription)")
                completion(); return
            }
            
        }.resume()
    } 
    
    func fetchImage(at urlString: String, completion: @escaping(UIImage?) -> Void) {
    
        guard let url = URL(string: urlString) else { completion(nil); return}
    
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            
            if let error = error {
                print("There was an error fetching the post's thumbnail: Error \(error.localizedDescription)")
                completion(nil); return
            }
            
            guard let data = data, let image = UIImage(data: data) else { completion(nil); return }
            completion(image); print("Fetched image")

        }.resume()
    }
}
