//
//  Book.swift
//  Map Scriptures
//
//  Created by Steve Liddle on 11/5/14.
//  Copyright (c) 2014 IS 543. All rights reserved.
//

import Foundation
import SQLite

class Book {
    var id: Int!
    var abbr: String!
    var citeAbbr: String!
    var fullName: String!
    var numChapters: Int!
    var urlPath: String!
    var parentBookId: Int!
    var parentBook: Book?
    var webTitle: String!
    var jstTitle: String!
    var tocName: String!
    var subdiv: String!
    var backName: String!
    var gridName: String!
    var citeFull: String!
    var heading2: String!

    class func fromRow(bookRecord: Row) -> Book {
        var book = Book()

        book.id = bookRecord.get(gBookId)!
        book.abbr = bookRecord.get(gBookAbbr)!
        book.citeAbbr = bookRecord.get(gBookCiteAbbr)!
        book.citeFull = bookRecord.get(gBookCiteFull)!
        book.fullName = bookRecord.get(gBookFullName)!
        book.parentBookId = bookRecord.get(gBookParentBookId)!
        book.webTitle = bookRecord.get(gBookWebTitle)!
        book.tocName = bookRecord.get(gBookTocName)!
        book.subdiv = bookRecord.get(gBookSubdiv)
        book.backName = bookRecord.get(gBookBackName)!
        book.gridName = bookRecord.get(gBookGridName)!
        book.heading2 = bookRecord.get(gBookHeading2)!

        if let numChapters = bookRecord.get(gBookNumChapters) {
            book.numChapters = numChapters
        }

        return book
    }
}