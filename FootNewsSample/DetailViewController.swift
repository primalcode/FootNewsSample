//
//  DetailViewController.swift
//  FootNewsSample
//
//  Created by 福田芳真 on 2015/02/07.
//  Copyright (c) 2015年 YoshimaFUKUDA. All rights reserved.
//

import UIKit

class DetailViewController : UIViewController, UIWebViewDelegate {
  
  var urlString : String?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let newsWebView : UIWebView = UIWebView()
    newsWebView.delegate = self
    newsWebView.frame = self.view.bounds
    self.view.addSubview(newsWebView)
    
    let url: NSURL! = NSURL(string: urlString!)
    let request: NSURLRequest = NSURLRequest(URL: url)
    newsWebView.loadRequest(request)
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
}
