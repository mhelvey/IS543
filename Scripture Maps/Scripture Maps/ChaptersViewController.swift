//
//  ChaptersViewController.swift
//  Scripture Maps
//
//  Created by Michael Helvey on 11/18/14.
//  Copyright (c) 2014 Michael Helvey. All rights reserved.
//

//import UIKit
//
//class ChaptersViewController : UITableViewController {
//    var books: [Book]!
//    var chapters: [String] = books[indexPath.row]
//    
//    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return books.count
//    }
//    
//    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCellWithIdentifier("BookCell", forIndexPath: indexPath) as UITableViewCell
//        
//        cell.textLabel.text = books[indexPath.row].fullName
//        
//        return cell
//    }
//}