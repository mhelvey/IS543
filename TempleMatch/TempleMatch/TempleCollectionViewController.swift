//
//  TempleCollectionViewController.swift
//  TempleMatch
//
//  Created by Michael Helvey on 10/19/14.
//  Copyright (c) 2014 Michael Helvey. All rights reserved.
//

import UIKit

class TempleCollectionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UITableViewDataSource, UITableViewDelegate {
    

    @IBAction func resetButton(sender: UIBarButtonItem) {
        NSLog("reset")
    }


    @IBAction func modeButton(sender: UIBarButtonItem) {
    }
    

    @IBOutlet weak var matchLabel: UIBarButtonItem!
    var templeCollection = TempleCollection()
    
    var temples = [Temple]()
    var temple1 = ""
    var temple2 = ""
    var match = false
    
    override func viewDidLoad() {
        for t in templeCollection.TEMPLES{
            temples.append(t)
        }
    }
    // MARK: Model
    var selectedTempleCell = -1
    var selectedTempleTable = -1
    
    
    // MARK: Collection view data source
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return temples.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        var cell = collectionView.dequeueReusableCellWithReuseIdentifier("TempleCell", forIndexPath: indexPath) as UICollectionViewCell
        let temple = temples[indexPath.row]
        if let templeCell = cell as? TempleCollectionViewCell{
            templeCell.templeName.text = "\(temple.name)"
            templeCell.templeImage.image = UIImage(named: temple.filename)
            templeCell.templeImage.layer.borderWidth = 4.0
            templeCell.templeImage.layer.borderColor = (UIColor( red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0)).CGColor
                        
            if indexPath.row == selectedTempleCell {
                templeCell.templeImage.layer.borderColor = (UIColor( red: 1.0, green: 1.0, blue: 0.0, alpha: 1.0)).CGColor
                cell.alpha = 0.5
              temple1 = temple.name
                NSLog("1 \(temple1)")
                templeMatch()
                if match == true{
                    temples.removeAtIndex(selectedTempleCell)
                    collectionView.reloadInputViews()
                }
            } else {
                cell.alpha = 1.0
            }
        }
        return cell
    }
    
    // MARK: Collection view delegate
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        NSLog("Selected item \(indexPath.row)")
        selectedTempleCell = indexPath.row
        
        collectionView.reloadData()
    }

    //MARK: Collection View Delegate Flow Layout
    
//    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
//        let temple = temples[indexPath.row]
//        let size = UIImage(named: temple.filename).size
//        let height = CGFloat(148.00)
//        let width = height * size.width / size.height
//        NSLog("\(size.width) \(size.height)")
//        return CGSizeMake(width, height)
//    }
    
    // MARK: Table view data source
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return temples.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var tableCell: UITableViewCell
        tableCell = tableView.dequeueReusableCellWithIdentifier("templeName") as UITableViewCell
        let temple = temples[indexPath.row]
        tableCell.textLabel!.text = "\(temple.name)"
        if indexPath.row == selectedTempleTable {
            temple2 = temple.name
            NSLog("2 \(temple2)")
            templeMatch()
            if match == true{
                temples.removeAtIndex(selectedTempleTable)
            }
        }
        
        return tableCell
        
    }
    
    
    // MARK: Table view delegate
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        selectedTempleTable = indexPath.row
//        func indexPathForSelectedRow() -> NSIndexPath?
        
        tableView.reloadData()
        
    }
    
    func templeMatch() -> Bool {
        if temple1 == temple2 {
            match = true
            matchLabel.title = "Correct Match"
        } else {
            match = false
            matchLabel.title = "Incorrect Match"
        }
        NSLog(match.description)
        return match
    }

//    func reset() {
//        
//    }

}
