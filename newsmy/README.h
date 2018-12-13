//
//  README.h
//  newsmy
//
//  Created by ha tuong do on 12/12/18.
//  Copyright © 2018 alpine. All rights reserved.
//

#ifndef README_h
#define README_h

name    =  "Kingfisher"
version = "5.0.0"
summary = "A lightweight and pure Swift implemented library for
           downloading and cacheing image from the web."

* Everything in Kingfisher goes asynchronously, not only downloading,
  but also caching. That means you can never worry about blocking your UI thread.
* Multiple-layer cache. Downloaded image will be cached in both memory and disk.
  So there is no need to download it again and this could boost your app dramatically.
* Cache management. You can set the max duration or size the cache could take.
  And the cache will also be cleaned automatically to prevent taking too much resource.
* Modern framework. Kingfisher uses `NSURLSession` and the latest technology of GCD,
  which makes it a strong and swift framework. It also provides you easy APIs to use.
* Cancellable processing task. You can cancel the downloading
  or retriving image process if it is not needed anymore.
* Independent components. You can use the downloader or caching system separately.
  Or even create your own cache based on Kingfisher's code.
* Options to decompress the image in background before render it, which could improve
  the UI performance.
* A category over `UIImageView` for setting image from an url directly.
-------------------------------------------------------------------

#endif /* README_h */
