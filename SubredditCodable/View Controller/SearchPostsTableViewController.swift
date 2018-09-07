//
//  SearchPostsTableViewController.swift
//  SubredditCodable
//
//  Created by John Tate on 9/4/18.
//  Copyright © 2018 John Tate. All rights reserved.
//

import UIKit

class SearchPostsTableViewController: UITableViewController, UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    
        guard let searchTerm = searchBar.text else { return }
        searchBar.text = ""
        searchBar.resignFirstResponder()
        
        PostController.shared.fetchPosts(by: searchTerm) {
            DispatchQueue.main.async {
                self.title = "r/\(searchTerm)"
                self.tableView.reloadData()
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 370
    }
    
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return PostController.shared.posts.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath) as? PostTableViewCell else { return UITableViewCell() }
        let post = PostController.shared.posts[indexPath.row]
        
        PostController.shared.fetchImage(at: post.thumbnailEndpoint) { (image) in
            guard let photo = image else {print("There was no Image returned") ; return}
            DispatchQueue.main.async {
                
                cell.post = post
                cell.thumbnail = photo
            }
        }
    
        return cell
    }
}
