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
    
    weak var mapViewController: MapViewController?
    
    // MARK: - Outlets
    @IBOutlet weak var webView: UIWebView!
    
    // MARK: - View controller lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let html = ScriptureRenderer.sharedRenderer.htmlForBookId(book.id, chapter: chapter)
        // NEDSWORK: load indicated book/chapter into web view
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
            
            //NEEDSWORK: Configure map view according to current context
            
            mapVC.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem()
            mapVC.navigationItem.leftItemsSupplementBackButton = true
        }
    }
    
    // MARK: - Webview delegate
    
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        
        if request.URL.absoluteString?.rangeOfString(ScriptureRenderer.sharedRenderer.BASE_URL) != nil {
            NSLog("geocoded place reguest: \(request)")

            if let mapVC = mapViewController{
                NSLog("your mom \(mapVC)")
                // NEEDSWORD: adjust to show map request point at default zoom level

            } else {
                performSegueWithIdentifier("Show Map", sender: self)
            }
            
            return false
        }
        return true
    }

}
