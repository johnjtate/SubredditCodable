//
//  PostTableViewCell.swift
//  SubredditCodable
//
//  Created by John Tate on 9/4/18.
//  Copyright © 2018 John Tate. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell {

    // MARK: - Properties
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var upvotesLabel: UILabel!
    @IBOutlet weak var commentsLabel: UILabel!
    @IBOutlet weak var thumbnailImageView: UIImageView!
    
    var post: Post? {
        didSet{
            updateViews()
        }
    }
    
    var thumbnail: UIImage? {
        didSet {
            thumbnailImageView.image = thumbnail
        }
    }
    
    func updateViews() {
        
        guard let post = post else { return }
        titleLabel.text = post.title
        upvotesLabel.text = "Upvotes: \(post.numberOfUpvotes)"
        commentsLabel.text = "Comments: \(post.numberOfComments)"

    }
    
    // assists with an image not going away when scrolling really quickly
    override func prepareForReuse() {
        thumbnailImageView.image = nil
    }
}
