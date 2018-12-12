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
        // NewsHelper().getArticles { (articles) in
        //    self.articles = articles
        //    self.tableView.reloadData()
        // }
        getArticles()
    }
    
    func getArticles() {
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
            // let url = URL(string: "https://example.com/image.png")
            // imageView.kf.setImage(with: url)
            let url = URL(string: article.urlToImage)
            // cell.articleImageView.kf.setImage(with: url)
            if article.category == "CENSORED" {
                cell.articleImageView.image = UIImage(named: "lighton")
            } else {
                // cell.articleImageView.kf.setImage(with: url)
                cell.articleImageView.kf.setImage(with: url, placeholder: UIImage(named: "lighton"), options: nil, progressBlock: nil)
            }
            
            return cell
        }
        return UITableViewCell() // dummy
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 260
    }
    
    // add in section 3 lecture 21 about 3:30 min
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("this is the row = ", indexPath.row)
        let article =  articles[indexPath.row]
        performSegue(withIdentifier: "goToURL", sender: article)
        
        // performSegue(withIdentifier: <#T##String#>, sender: <#T##Any?#>)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToURL" {
            if let article = sender as? Article {
                if let webVC = segue.destination as? ArticleWebViewController {
                    webVC.article = article
                }
            }
        }
    }
    @IBAction func reloadTapped(_ sender: Any) {
        getArticles()
    }
}

class ArticleCell : UITableViewCell {
    
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var articleImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
}
