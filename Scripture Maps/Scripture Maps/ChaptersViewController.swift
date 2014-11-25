//
//  ChaptersViewController.swift
//  Scripture Maps
//
//  Created by Michael Helvey on 11/18/14.
//  Copyright (c) 2014 Michael Helvey. All rights reserved.
//

import UIKit

class ChaptersViewController : UITableViewController {
    var books: [Book]!
    var book: Book!
    var chapter = 0
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return book.numChapters
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ChapterCell", forIndexPath: indexPath) as UITableViewCell
        
        cell.textLabel.text = "yahoo"
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier("Show Scripture", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "Show Scripture" {
            if let indexPath = tableView.indexPathForSelectedRow(){
                if let destVC = segue.destinationViewController as? ScriptureViewController{
                    destVC.book = books[indexPath.row]
                    destVC.chapter = 1
                    destVC.title = books[indexPath.row].fullName
                }
            }
        }
    }
}
