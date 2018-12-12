//
//  ArticleTableViewController.swift
//  newsmy
//
//  Created by ha tuong do on 12/10/18.
//  Copyright © 2018 alpine. All rights reserved.
//

import UIKit

class ArticleTableViewController: UITableViewController {

    var articles = [Article]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NewsHelper().getArticles { (articles) in
            self.articles = articles
            self.tableView.reloadData()
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return articles.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleCell", for: indexPath) as? ArticleCell {

        // Configure the cell...
        let article =  articles[indexPath.row]
            cell.titleLabel.text = article.title
            cell.categoryLabel.text  = article.category
        return cell
        
        }
        
        return UITableViewCell() // dummy
    }
    
}

class ArticleCell : UITableViewCell {
    
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var articleImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
}
