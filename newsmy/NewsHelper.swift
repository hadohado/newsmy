//
//  NewsHelper.swift
//  newsmy
//
//  Created by ha tuong do on 12/10/18.
//  Copyright © 2018 alpine. All rights reserved.
//
import Foundation
import Alamofire

class NewsHelper {
    
    
    // send asynchronous result through closure
    func getArticles() {
        
        Alamofire.request("https://newsapi.org/v2/top-headlines?country=us&apiKey=d5a7abc05da045acb54266d081d6a983").responseJSON { ( response) in
            print(response)
        }
        // Alamofire.Request(underlyingQueue: <#DispatchQueue#>)
        
    }
}
