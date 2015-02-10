//
//  TableViewController.swift
//  FootNewsSample
//
//  Created by 福田芳真 on 2015/02/07.
//  Copyright (c) 2015年 YoshimaFUKUDA. All rights reserved.
//

import UIKit
import SwiftyJSON

class TableViewController : UITableViewController {
  // Section Num
  let sectionNum = 1
  
  // Cell Num
  let cellNum = 10
  
  // Api Url
  let apiUrl = "https://ajax.googleapis.com/ajax/services/feed/load?v=1.0&q=http://www.dailymail.co.uk/sport/football/index.rss&num=30"
  
  // Cell Contents
  var cellItems: [(content: String, link: String)] = []
  
  // Load check
  var isInLoad = false
  
  // Selected Row
  var selectedRowNum: Int?
  
  override func scrollViewDidScroll(scrollView: UIScrollView) {
    // Bottom check
    if(self.tableView.contentOffset.y >= (self.tableView.contentSize.height - self.tableView.bounds.size.height))
    {
      // TODO more content.
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Get JsonData From Api Url
    makeTableData(0)
  }
  
  func makeTableData(index:Int) {
    self.isInLoad = true
    var url = NSURL(string: self.apiUrl)!
    var task = NSURLSession.sharedSession().dataTaskWithURL(url, completionHandler: {data, response, error in
      var json = JSON(data: data)
      
      for var i = index; i < self.cellNum; i++ {
        var content = json["responseData"]["feed"]["entries"][i]["content"]
        var link = json["responseData"]["feed"]["entries"][i]["link"]
        self.cellItems += [(content:"\(content)", link:"\(link)")]
      }
      
      self.isInLoad = false
    })
    
    task.resume()
    
    while isInLoad {
      usleep(10)
    }
  }
  
  override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return self.sectionNum
  }
  
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.cellNum
  }
  
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("tableCell", forIndexPath: indexPath) as UITableViewCell
    
    var info = self.cellItems[indexPath.row]
    cell.textLabel?.text = info.content
    return cell
  }
  
  override func tableView(tableView: UITableView?, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    self.selectedRowNum = indexPath.row
    performSegueWithIdentifier("toDetailViewController", sender: nil)
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "toDetailViewController" {
      let detailViewController : DetailViewController = segue.destinationViewController as DetailViewController
      detailViewController.urlString = cellItems[self.selectedRowNum!].link
    }
  }
}
