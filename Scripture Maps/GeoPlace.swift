//
//  GeoPlace.swift
//  Map Scriptures
//
//  Created by Steve Liddle on 11/5/14.
//  Copyright (c) 2014 IS 543. All rights reserved.
//

import Foundation
import SQLite

class GeoPlace {
    enum GeoCategory: Int {
        // Categories represent geocoded places we've constructed from various
        // Church history sources (1) or the Open Bible project (2)
        case ChurchHistory = 1,
             OpenBible = 2
    }
    
    enum GeoFlag: String {
        // Flags indicate different levels of certainty in the Open Bible database
        case None = "",
             Open1 = "~",
             Open2 = ">",
             Open3 = "?",
             Open4 = "<",
             Open5 = "+"
    }

    var id: Int!
    var placename: String!
    var latitude: Double!
    var longitude: Double!
    var flag: GeoFlag!
    var viewLatitude: Double?
    var viewLongitude: Double?
    var viewTilt: Double?
    var viewRoll: Double?
    var viewAltitude: Double?
    var viewHeading: Double?
    var category: GeoCategory!

    class func fromTagRow(geoRecord: Row) -> GeoPlace {
        var geoplace = GeoPlace()

        geoplace.id = geoRecord.get(gGeoTagGeoPlaceId)!
        geoplace.placename = geoRecord.get(gGeoPlacePlacename)!
        geoplace.latitude = geoRecord.get(gGeoPlaceLatitude)!
        geoplace.longitude = geoRecord.get(gGeoPlaceLongitude)!
        geoplace.category = GeoCategory(rawValue: geoRecord.get(gGeoPlaceCategory)!)

        if let flag = geoRecord.get(gGeoPlaceFlag) {
            geoplace.flag = GeoFlag(rawValue: flag)
        } else {
            geoplace.flag = GeoFlag.None
        }

        if let viewLatitude = geoRecord.get(gGeoPlaceViewLatitude) {
            geoplace.viewLatitude = viewLatitude
            geoplace.viewLongitude = geoRecord.get(gGeoPlaceViewLongitude)
            geoplace.viewTilt = geoRecord.get(gGeoPlaceViewTilt)
            geoplace.viewRoll = geoRecord.get(gGeoPlaceViewRoll)
            geoplace.viewAltitude = geoRecord.get(gGeoPlaceViewAltitude)
            geoplace.viewHeading = geoRecord.get(gGeoPlaceViewHeading)
        }

        return geoplace
    }
}