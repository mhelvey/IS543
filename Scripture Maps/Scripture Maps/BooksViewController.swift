//
//  BooksViewController.swift
//  Scripture Maps
//
//  Created by Michael Helvey on 11/18/14.
//  Copyright (c) 2014 Michael Helvey. All rights reserved.
//

import UIKit

class BooksViewController : UITableViewController {
    var books: [Book]!
    
    //determines number of cells to make
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return books.count
    }
    
    // names cells
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("BookCell", forIndexPath: indexPath) as UITableViewCell
        
        cell.textLabel.text = books[indexPath.row].fullName
        
        return cell
    }
    
    //performs segues depending on if book selected has chapters or not
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if let numChapters = books[indexPath.row].numChapters {
            performSegueWithIdentifier("Show Chapters", sender: self)
            
        } else{
            performSegueWithIdentifier("Show Scripture", sender: self)
        }
    }
    
    //prepares segues by creating a destination view controller as either a scripture or chapter view controller
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "Show Scripture" {
            if let indexPath = tableView.indexPathForSelectedRow(){
                
                var selectedBook = books[indexPath.row]
                
                if let destVC = segue.destinationViewController as? ScriptureViewController{
                    destVC.book = selectedBook
                    destVC.title = selectedBook.fullName
                }
            }
        }
        if segue.identifier == "Show Chapters" {
            if let indexPath = tableView.indexPathForSelectedRow(){
                var selectedBook = books[indexPath.row]

                if let destVC = segue.destinationViewController as? ChaptersViewController{
                    destVC.book = selectedBook
                    destVC.title = selectedBook.fullName
                }
            }
        }

    }
}
