//
//  GeoDatabase.swift
//  Scripture Maps
//
//  Created by Michael Helvey on 11/10/14.
//  Copyright (c) 2014 Michael Helvey. All rights reserved.
//

import Foundation
import SQLite

class GeoDatabase {
    class var sharedGeoDatabase : GeoDatabase {
        struct Singleton {
            static let instance = GeoDatabase()
        }
        return Singleton.instance
    }
    
    private init() {
        //guarentees that the code outside this file cant instantiats a geodatabase.
    }
    
    let db = Database (NSBundle.mainBundle().pathForResource("geo20", ofType: "db"))
    
    //MARL: - Helpers
//    func bookForId(bookId: Book.BookId) -> Book{
//        let bookRecord = db["book"].filter(Expression<Int>("ID") == bookId.rawValue)
//        
//        return Book.fromRow(bookRecord}
//    }
    
    func volumes() ->[String] {
        var volumes = [String]()
        
        let books = db["book"]
        let bookId = Expression<Int>("ID")
        let parentBookId = Expression<Int>("ParentBookId")
        let volumeTitle = Expression<String>("TOCName")
        
        for volume in books.filter(parentBookId == nil).order(bookId) {
            volumes.append(volume.get(volumeTitle)!)
        }
        
        
        return volumes
    }
}

