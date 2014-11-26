//
//  MapwViewController.swift
//  Scripture Maps
//
//  Created by Michael Helvey on 11/10/14.
//  Copyright (c) 2014 Michael Helvey. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var detailDescriptionLabel: UILabel!
    @IBOutlet weak var mapTitle: UINavigationItem!
    @IBOutlet weak var mapView: MKMapView!
    
    var locationID = 0
    var allLocations = [GeoPlace]()
    var currentGeoPlace: GeoPlace? = nil
    let locationManager = CLLocationManager()
    



    var detailItem: AnyObject? {
        didSet {
            // Update the view.
            self.configureView()
        }
    }

    func configureView() {
        // Update the user interface for the detail item.
        if let detail: AnyObject = self.detailItem {
            if let label = self.detailDescriptionLabel {
                label.text = detail.description
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Could not get current location to work, always through erros of unwrapping nil
//        // For use in foreground
//        self.locationManager.requestWhenInUseAuthorization()
//        
//        if CLLocationManager.locationServicesEnabled() {
//            locationManager.delegate = self
//            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
//            locationManager.startUpdatingLocation()
//        }
        
        
        self.configureView()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        var annotation = MKPointAnnotation()
        
        // Find which geoPlace was selected
        for (key, val) in enumerate(allLocations) {
            if val.id == locationID {
                currentGeoPlace = allLocations[key]
            }
        }
        
        //this will change the map to zoom in to the selected geo reference
        if locationID > 0 {
            
            annotation.coordinate = CLLocationCoordinate2DMake(currentGeoPlace!.latitude, currentGeoPlace!.longitude)
            annotation.title = "\(currentGeoPlace!.placename)"
            annotation.subtitle = "\(currentGeoPlace!.latitude), \(currentGeoPlace!.longitude)"
            
            mapTitle.title = currentGeoPlace?.placename
            mapView.addAnnotation(annotation)
            
            var camera = MKMapCamera(
                lookingAtCenterCoordinate: CLLocationCoordinate2DMake(currentGeoPlace!.latitude, currentGeoPlace!.longitude),
                fromEyeCoordinate: CLLocationCoordinate2DMake((currentGeoPlace!.viewLatitude)!, currentGeoPlace!.viewLongitude!),
                eyeAltitude: currentGeoPlace!.viewAltitude!)
            camera.heading = currentGeoPlace!.viewHeading!
            
            mapView.setCamera(camera, animated: true)
        // should only happen when app is first opened. tried to set to current location, but could never get it to work.
        }else {
            annotation.coordinate = CLLocationCoordinate2DMake(40.2506, -111.65247)
            annotation.title = "Tanner Building"
            annotation.subtitle = "BYU Campus"
            
            mapView.addAnnotation(annotation)
            mapTitle.title = "Current Location"
            
            var camera = MKMapCamera(
                lookingAtCenterCoordinate: CLLocationCoordinate2DMake(40.2506, -111.65247),
                fromEyeCoordinate: CLLocationCoordinate2DMake(40.2406, -111.65247),
                eyeAltitude: 300)
            
            mapView.setCamera(camera, animated: true)
        }
        

    }

    // MARK: - Map View Delegate
    
    func mapView(mapView: MKMapView!, viewForAnnotation annotation: MKAnnotation!) -> MKAnnotationView! {
        let reuseIdentifier = "Pin"
        
        var view = mapView.dequeueReusableAnnotationViewWithIdentifier(reuseIdentifier)
        
        if view == nil{
            var pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseIdentifier)
            
            pinView.canShowCallout = true
            pinView.animatesDrop = true
            pinView.pinColor = .Green
            view = pinView
            
        } else {
            view.annotation = annotation
        }
        
        return view
    }
    
    // MARK: - Actions
    
    @IBAction func setMapRegion(sender: AnyObject) {
        
        let region = MKCoordinateRegionMake(CLLocationCoordinate2DMake(40.23, -111.62), MKCoordinateSpanMake(1, 1))
        mapView.setRegion(region, animated: true)
    }
    
    //Location delegate - does not get called
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        var locValue:CLLocationCoordinate2D = manager.location.coordinate
        println("locations = \(locValue.latitude) \(locValue.longitude)")
    }

}

