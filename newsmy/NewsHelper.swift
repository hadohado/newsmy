//
//  NewsHelper.swift
//  newsmy
//
//  Created by ha tuong do on 12/10/18.
//  Copyright © 2018 alpine. All rights reserved.
//
import Foundation
import Alamofire
import DocumentClassifier
import Kingfisher

class NewsHelper {
    
    
    // send asynchronous result through closure
    func getArticles(returnArticles: @escaping ([Article]) -> Void) {
        var censorState = true
        var myImage = UIImage(named: "lighton")
        
        Alamofire.request("https://newsapi.org/v2/top-headlines?country=us&apiKey=d5a7abc05da045acb54266d081d6a983").responseJSON { ( response) in
            print(response)
            if let json = response.result.value as? [String: Any] {
                if let jsonArticles = json["articles"] as? [[String:Any]] {
                    var articles = [Article]()
                    
                    for jsonArticle in jsonArticles {
                        guard let title = jsonArticle["title"] as? String,
                            let urlToImage = jsonArticle["urlToImage"] as? String,
                            let url = jsonArticle["url"] as? String,
                            let description = jsonArticle["description"] as? String
                        else {
                            continue
                        }
                        let article = Article()
                        article.title = title
                        // article.urlToImage = urlToImage
                        article.url = url
                     // article.description = description
                        article.description = description
                        
                        guard let classification = DocumentClassifier().classify(title) else { return }
                        article.category = classification.prediction.category.rawValue
                        
                        if censorState {
                            if title.contains("rump") || description.contains("rump") {
                                print("------- censored ---------")
                                article.title = "CENSORED"
                                article.description = "CENSORED"
                                article.category = "CENSORED"
                                articles.append(article)
                            } else {
                                article.urlToImage = urlToImage
                                articles.append(article) // DONT DO THIS FOR REAL APP (this is for testing)
                            }
                        } else {
                            articles.append(article)
                        }
                        
                        
                        // print(title)
                        // print(classification.prediction)
                        
                        // articles.append(article)
                    }
                    returnArticles(articles)
                }
            }
        }
        // Alamofire.Request(underlyingQueue: <#DispatchQueue#>)
        // JSON data is a large dictionary   { articles = { article objects }   }
        //                                     key      =  value
        
    }
}

class Article {
    var title = ""
    var urlToImage = ""
    var url = ""
    var description = ""
    var category = ""
}
