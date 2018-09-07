//
//  Post.swift
//  SubredditCodable
//
//  Created by John Tate on 9/4/18.
//  Copyright © 2018 John Tate. All rights reserved.
//

import Foundation

struct JSONDictionary: Decodable {
    let data: DataDictionary
    
    struct DataDictionary: Decodable {

        let children: [PostDictionary]
        
        struct PostDictionary: Decodable {
            let post: Post
            
            private enum CodingKeys: String, CodingKey {
                case post = "data"
            }
        }
    }
}

struct Post: Decodable {
    
    let title: String
    let thumbnailEndpoint: String
    let numberOfUpvotes: Int
    let numberOfComments: Int
    
    private enum CodingKeys: String, CodingKey {
        case title
        case thumbnailEndpoint = "thumbnail"
        case numberOfUpvotes = "ups"
        case numberOfComments = "num_comments"
    }
}
