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

class MapViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var detailDescriptionLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    
    var locationID = ""


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
        
        
        self.configureView()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        var annotation = MKPointAnnotation()
        NSLog(locationID)
        annotation.coordinate = CLLocationCoordinate2DMake(40.2506, -111.65247)
        annotation.title = "Tanner Building"
        annotation.subtitle = "BYU Campus"
        
        mapView.addAnnotation(annotation)
        
        var camera = MKMapCamera(
            lookingAtCenterCoordinate: CLLocationCoordinate2DMake(40.2506, -111.65247),
            fromEyeCoordinate: CLLocationCoordinate2DMake(40.2406, -111.65247),
            eyeAltitude: 300)
        mapView.setCamera(camera, animated: true)
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
            NSLog("this is the location \(locationID)")
        }
        
        return view
    }
    
    // MARK: - Actions
    
    @IBAction func setMapRegion(sender: AnyObject) {
        
        let region = MKCoordinateRegionMake(CLLocationCoordinate2DMake(40.23, -111.62), MKCoordinateSpanMake(1, 1))
        mapView.setRegion(region, animated: true)
    }
    

}

