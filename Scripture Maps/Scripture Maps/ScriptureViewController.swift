//
//  ScriptureViewController.swift
//  Scripture Maps
//
//  Created by Michael Helvey on 11/21/14.
//  Copyright (c) 2014 Michael Helvey. All rights reserved.
//

import UIKit

class ScriptureViewController : UIViewController, UIWebViewDelegate {
    // MARK: - Properties
    
    var book: Book!
    var chapter = 0
    var mapViewConfiguration = ""
    var locationID = 0
    
    weak var mapViewController: MapViewController?
    
    // MARK: - Outlets
    @IBOutlet weak var webView: UIWebView!
    
    // MARK: - View controller lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let html = ScriptureRenderer.sharedRenderer.htmlForBookId(book.id, chapter: chapter)
        webView.loadHTMLString(html, baseURL: nil)
        
        configureMapViewController()
    }
    
    func configureMapViewController() {
        if let splitVC = splitViewController {
            if let navVC = splitVC.viewControllers.last as? UINavigationController {
                mapViewController = navVC.topViewController as? MapViewController
            }
        }

    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        configureMapViewController()
    }
    // MARK: - Segues
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "Show Map" {
            let navVC = segue.destinationViewController as UINavigationController
            let mapVC = navVC.topViewController as MapViewController
            
            mapVC.allLocations = ScriptureRenderer.sharedRenderer.collectedGeocodedPlaces
            mapVC.locationID = locationID
            mapVC.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem()
            mapVC.navigationItem.leftItemsSupplementBackButton = true
        }
    }
    
    // MARK: - Webview delegate
    
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        
        if request.URL.absoluteString?.rangeOfString(ScriptureRenderer.sharedRenderer.BASE_URL) != nil {
            locationID = request.URL.lastPathComponent.toInt()!
            NSLog("\(locationID)")
            if let mapVC = mapViewController{
                mapVC.locationID = locationID
                performSegueWithIdentifier("Show Map", sender: self)
            } else {
                performSegueWithIdentifier("Show Map", sender: self)
            }
            
            return false
        }
        return true
    }

}
