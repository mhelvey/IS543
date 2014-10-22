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
    var templeCollection = TempleCollection()
    var temples = [Temple]()
    var temples2 = [Temple]()
    var templesInitial = [Temple]()
    var temple1 = ""
    var temple2 = ""
    var match = false
    var correct = 0
    var incorrect = 0

    // Mark: Outlets
    @IBOutlet weak var templeTable: UITableView!
    @IBOutlet weak var collection: UICollectionView!
    @IBOutlet weak var resetOutlet: UIBarButtonItem!
    @IBOutlet weak var matchLabel: UIBarButtonItem!
    @IBOutlet weak var incorrectLabel: UIBarButtonItem!
    @IBOutlet weak var correctLabel: UIBarButtonItem!

    // Reset game
    @IBAction func resetButton(sender: UIBarButtonItem) {
        reset()
    }
    // Mode Toggle
    @IBAction func modeButton(sender: UIBarButtonItem) {
        if study == false {
            templeTable.hidden = true
            sender.title = "Match Mode"
            study = true
            selectedTempleImage = -1
            resetOutlet.enabled = false
            collection.reloadData()
        }else {
            templeTable.hidden = false
            sender.title = "Study Mode"
            study = false
            selectedTempleImage = -1
            resetOutlet.enabled = true
            collection.reloadData()
  
        }
        
    }
    
    
    // fill the local arrays with temples
    override func viewDidLoad() {
        for t in templeCollection.TEMPLES{
            temples.append(t)
            temples2.append(t)
        }
        //shuffle one of the arrays and save it for reset
        temples = shuffle(temples)
        templesInitial = temples
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
                            temples2.removeAtIndex(selectedTempleTable)
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
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let temple = temples[indexPath.row]
        let size = UIImage(named: temple.filename).size
        let height = CGFloat(148.00)
        let width = height * size.width / size.height
        NSLog("\(size.width) \(size.height)")
        return CGSizeMake(width, height)
    }
    
    // MARK: Table view data source
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return temples2.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var tableCell: UITableViewCell
        tableCell = tableView.dequeueReusableCellWithIdentifier("templeName") as UITableViewCell
        let temple = temples2[indexPath.row]
        tableCell.textLabel!.text = "\(temple.name)"
        return tableCell
    }
    
    
    // MARK: Table view delegate
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        selectedTempleTable = indexPath.row
        var tableCell: UITableViewCell
        tableCell = tableView.dequeueReusableCellWithIdentifier("templeName") as UITableViewCell
        let temple = temples2[indexPath.row]
        tableCell.textLabel!.text = "\(temple.name)"
        if indexPath.row == selectedTempleTable {
            temple2 = temple.name
            NSLog("2 \(temple2)")
            if temple1 != "" {
                templeMatch()
                if match == true{
                    temples2.removeAtIndex(selectedTempleTable)
                    temples.removeAtIndex(selectedTempleImage)
                    selectedTempleTable = -1
                    selectedTempleImage = -1
                    match = false
                    tableView.reloadData()
                    collection.reloadData()
                }
            }
        }
    }
    
    // shuffle function found on stack overflow
    func shuffle<T>(var list: Array<T>) -> Array<T> {
        for i in 0..<(list.count - 1) {
            let j = Int(arc4random_uniform(UInt32(list.count - i))) + i
            swap(&list[i], &list[j])
        }
        return list
    }
    
    // matching method, compares the two selected temples and sends back a boolean
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
    
    // reset method, restores game to original state, when first opened
    func reset() {
        for t in temples{
            var i = 0
            temples.removeAtIndex(i)
            temples2.removeAtIndex(i)
            i++
        }
        for t in templeCollection.TEMPLES{
            temples2.append(t)
        }
        temples = templesInitial
        
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
