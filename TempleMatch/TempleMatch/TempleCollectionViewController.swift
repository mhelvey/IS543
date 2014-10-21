//
//  TempleCollectionViewController.swift
//  TempleMatch
//
//  Created by Michael Helvey on 10/19/14.
//  Copyright (c) 2014 Michael Helvey. All rights reserved.
//

import UIKit

class TempleCollectionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UITableViewDataSource, UITableViewDelegate {
   
    // MARK: Model
    var selectedTempleImage = -1
    var selectedTempleTable = -1
    var study = false
    var temples = [Temple]()
    var temple1 = ""
    var temple2 = ""
    var match = false
    var correct = 0
    var incorrect = 0

    
    @IBOutlet weak var templeTable: UITableView!
    @IBOutlet weak var collection: UICollectionView!
    
    
    @IBOutlet weak var matchLabel: UIBarButtonItem!
    @IBOutlet weak var incorrectLabel: UIBarButtonItem!
    @IBOutlet weak var correctLabel: UIBarButtonItem!

    @IBAction func resetButton(sender: UIBarButtonItem) {
        reset()
    }

    @IBAction func modeButton(sender: UIBarButtonItem) {
//        mode()
        if study == false {
            templeTable.hidden = true
            sender.title = "Match Mode"
            study = true
            selectedTempleImage = -1
            collection.reloadData()
        }else {
            templeTable.hidden = false
            sender.title = "Study Mode"
            study = false
            selectedTempleImage = -1
            collection.reloadData()
  
        }
        
    }
    var templeCollection = TempleCollection()
    
    
    override func viewDidLoad() {
        for t in templeCollection.TEMPLES{
            temples.append(t)
        }
    }
    
    
    // MARK: Collection view data source
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return temples.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        var cell = collectionView.dequeueReusableCellWithReuseIdentifier("TempleCell", forIndexPath: indexPath) as UICollectionViewCell
        let temple = temples[indexPath.row]
        if let templeCell = cell as? TempleCollectionViewCell{
            if study == true {
                templeCell.templeName.hidden = false
            }else {
                templeCell.templeName.hidden = true
            }
            templeCell.templeName.text = "\(temple.name)"
            templeCell.templeImage.image = UIImage(named: temple.filename)
            templeCell.templeImage.layer.borderWidth = 4.0
            templeCell.templeImage.layer.borderColor = (UIColor( red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0)).CGColor
            if study == false{
                if indexPath.row == selectedTempleImage {
                    templeCell.templeImage.layer.borderColor = (UIColor( red: 1.0, green: 1.0, blue: 0.0, alpha: 1.0)).CGColor
                    cell.alpha = 0.5
                    temple1 = temple.name
                    NSLog("1 \(temple1)")
                    if temple2 != ""{
                        templeMatch()
                        if match == true{
                            cell.alpha = 1.0
                            templeCell.templeImage.layer.borderColor = (UIColor( red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0)).CGColor
                            temples.removeAtIndex(selectedTempleImage)
                            selectedTempleImage = -1
                            selectedTempleTable = -1
                            match = false
                            collectionView.reloadData()
                            templeTable.reloadData()
                        }
                    }
                } else {
                    
                    cell.alpha = 1.0
                }
            }else {
                cell.alpha = 1.0
            }
        }
        return cell
    }
    
    // MARK: Collection view delegate
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        NSLog("Selected item \(indexPath.row)")
        selectedTempleImage = indexPath.row
        
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
            if temple1 != "" {
                templeMatch()
                if match == true{
                    temples.removeAtIndex(selectedTempleTable)
                    selectedTempleTable = -1
                    selectedTempleImage = -1
                    match = false
                    tableView.reloadData()
                    collection.reloadData()
                }
            }
        }
        
        return tableCell
        
    }
    
    
    // MARK: Table view delegate
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        selectedTempleTable = indexPath.row
        
        tableView.reloadData()        
    }
    
    func templeMatch() -> Bool {
        
        if temple1 == temple2 {
            match = true
            matchLabel.title = "Correct Match"
            temple1 = ""
            temple2 = ""
            correct++
            correctLabel.title = "Correct: \(correct)"
            
        } else {
            match = false
            matchLabel.title = "Incorrect Match"
            incorrect++
            incorrectLabel.title = "Incorrect: \(incorrect)"
            
        }
        NSLog(match.description)
        return match
    }

    func reset() {
        for t in temples{
            var i = 0
            temples.removeAtIndex(i)
            i++
        }
        for t in templeCollection.TEMPLES{
            temples.append(t)
        }
        
        selectedTempleImage = -1
        selectedTempleTable = -1
        NSLog("reset complete")
        templeTable.reloadData()
        collection.reloadData()
        correct = 0
        incorrect = 0
        correctLabel.title = "Correct: 0"
        incorrectLabel.title = "Incorrect: 0"
        matchLabel.title = ""
        
    }
    


}
