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
    
    // MARK: - Outlets
    @IBOutlet weak var webView: UIWebView!
    
    // MARK: - View controller lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let html = ScriptureRenderer.sharedRenderer.htmlForBookId(book.id, chapter: chapter)
        // NEDSWORK: load indicated book/chapter into web view
        webView.loadHTMLString(html, baseURL: nil)
    }
    
    // MARK: - Webview delegate
    
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        
        if request.URL.absoluteString?.rangeOfString(ScriptureRenderer.sharedRenderer.BASE_URL) != nil {
            NSLog("geocoded place reguest: \(request)")

            // NEEDSWORD: adjust to show map request point at default zoom level
            
            request.URL.parameterString
            return false
        }
        return true
    }

}
