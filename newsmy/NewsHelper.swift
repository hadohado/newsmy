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
// import Kingfisher    // in previous code, dont know why I had this "import Kingfisher" here
                        // we need "import Kingfisher" in ArticleTableViewController.swift
                        // since we use Kingfisher package there

/* ------------------------------------------------------------------------------

{
    "status": "ok",
    "totalResults": 36,
 
    "articles": [
        {
        "source"      : {   "id": "engadget",     "name": "Engadget"   },
        "author"      : "Kris Holt",
        "title"       : "Amazon brings Alexa's Follow-Up Mode to Fire TV Cube - Engadget",
        "description" : "Multiroom audio is also available on the device as part of your Echo setup.",
        "url"         : "https://www.engadget.com/2018/12/12/amazon-alexa-cube-multiroom-audio/",
 "      urlToImage"  : "https://o.aolcdn.com/images/dims?thumbnail=1200%2C630&..",
        "publishedAt" : "2018-12-12T23:32:07Z",
        "content"     : "With Follow-Up Mode, you can ask Alexa for  … [+726 chars]"
        },
 
        {
            "source"      : {   "id": null,   "name": "Ufc.com"    },
            "author"      : null,
            "title"       : "Website of the Ultimate Fighting Championship",
            "description" : "As Real As It Gets ...",
            "url"         : "https://www.ufc.com/news/ufc-233-pay-view-scheduled-jan-26-postponed",
            "urlToImage"  : null,
            "publishedAt" : "2018-12-12T19:38:17Z",
            "content"     : null
        }
    ]
 }
 
------------------------------------------------------------------------------ */

class NewsHelper {
   
    // https://color.adobe.com
    // send asynchronous result through closure
    func getArticles(returnArticles: @escaping ([Article]) -> Void) {
        let censorState = true
        var myImage = UIImage(named: "lighton")
        
        Alamofire.request("https://newsapi.org/v2/top-headlines?country=us&apiKey=d5a7abc05da045acb54266d081d6a983").responseJSON { ( response) in
            print(response)
            if let json = response.result.value as? [String: Any] {
                
                // jsonArticles is an array or list  [ ... ]   of sub-dictionaries
                //       = [
                //           { "title" : __ , "url" : __ },
                //           { "title" : __ , "url" : __ }
                //         ]
                if let jsonArticles = json["articles"] as? [[String:Any]] {
                    // json["articles"] will give the value associated with key = "articles"
                    // the value is [ { "title" : __ , "url" : __ }, { "title" : __ , "url" : __ } ]
                    var articles = [Article]()
                    
                    for jsonArticle in jsonArticles { // jsonArticle is a single dictionary
                        guard let title = jsonArticle["title"] as? String,
                            let urlToImage = jsonArticle["urlToImage"] as? String,
                            let url = jsonArticle["url"] as? String,
                            let description = jsonArticle["description"] as? String
                        else {
                            continue
                        }
                        let article = Article() // create an article object from Article class
                        article.title = title
                        // article.urlToImage = urlToImage
                        article.url = url
                        article.description = description
                        
                        // https:/color.adobe.com   click on Explore, then search for color = atend_mento
                        // RGB =  66    225     244
                        //     =   4    202     149
                        //     = 225    217      68
                        //     = 239    171      10
                        //     = 244    101      45
                        
                        guard let classification = DocumentClassifier().classify(title) else { return }
                        // article.category = classification.prediction.category.rawValue
                        switch (classification.prediction.category) {
                            case .business:
                                article.category = .business
                                article.categoryColor = UIColor(red: 0.298, green: 0.880, blue: 0.950, alpha: 1.0)
                            case .entertainment:
                                article.category = .entertainment
                                article.categoryColor = UIColor(red: 0.129, green: 0.788, blue: 0.128, alpha: 1.0)
                            case .politics:
                                article.category = .politics
                                article.categoryColor = UIColor(red: 0.995, green: 0.850, blue: 0.328, alpha: 1.0)
                            case .sports:
                                article.category = .sports
                                article.categoryColor = UIColor(red: 0.929, green: 0.670, blue: 0.172, alpha: 1.0)
                            case .technology:
                                article.category = .technology
                                article.categoryColor = UIColor(red: 0.950, green: 0.398, blue: 0.220, alpha: 1.0)
                            // case .censored:
                            //    article.category = .censored
                        }
                        
                        if censorState {
                            if title.contains("une") || description.contains("une") {
                            // if title.contains("rump") || description.contains("rump") {
                                print("------- censored ---------")
                                article.title = "CENSORED"
                                article.description = "CENSORED"
                                article.category = NewsCategory.censored
                                articles.append(article)
                            } else {
                                article.urlToImage = urlToImage
                                articles.append(article) // DONT DO THIS FOR REAL APP (this is for testing)
                            }
                        } else {
                            articles.append(article)
                        }
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
    var category : NewsCategory = .business
    // var category = ""
    var categoryColor = UIColor.red // var categoryColor :  UIColor = .red <-- this works also
}

// control + command + spacebar <- to get emoji
enum NewsCategory : String {
    case business = "💰 Business"
    case entertainment = "🎉 Entertainment"
    case politics = "🎤 Politics"
    case sports = "🎾 Sports"
    case technology = "📀 Technology"
    case censored = "⛔️ CENSORED"
}
