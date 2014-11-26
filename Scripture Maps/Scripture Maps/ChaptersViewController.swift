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
    
    //determines number of cells to make
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return book.numChapters
    }
    
    // names cells and adds the chapter number
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ChapterCell", forIndexPath: indexPath) as UITableViewCell
        
        cell.textLabel.text = "\(book.fullName) \(indexPath.row + 1)"
        
        return cell
    }
    

    //sends needed information to destination view controller
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "Show Scripture" {
            if let indexPath = tableView.indexPathForSelectedRow(){
                if let destVC = segue.destinationViewController as? ScriptureViewController{
                    destVC.book = book
                    destVC.chapter = indexPath.row + 1
                    destVC.title = "\(book.fullName) \(indexPath.row + 1)"
                }
            }
        }
    }
}
