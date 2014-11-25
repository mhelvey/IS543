//
//  AppDelegate.swift
//  Scripture Maps
//
//  Created by Michael Helvey on 11/10/14.
//  Copyright (c) 2014 Michael Helvey. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UISplitViewControllerDelegate {
    // MARK: - Properties
    var window: UIWindow?


    // MARK: - Lifecycle
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        let splitViewController = self.window!.rootViewController as UISplitViewController
        let navigationController = splitViewController.viewControllers.last as UINavigationController
        navigationController.topViewController.navigationItem.leftBarButtonItem = splitViewController.displayModeButtonItem()
        splitViewController.delegate = self
        return true
    }

    // MARK: - Split view

    func splitViewController(splitViewController: UISplitViewController,
        collapseSecondaryViewController secondaryViewController:UIViewController!,
        ontoPrimaryViewController primaryViewController:UIViewController!) -> Bool {
            
        if let secondaryAsNavController = secondaryViewController as? UINavigationController {
            if let topAsDetailController = secondaryAsNavController.topViewController as? MapViewController {
                if topAsDetailController.detailItem == nil {
                    // Return true to indicate that we have handled the collapse by doing nothing; the secondary controller will be discarded.
                    return true
                }
            }
        }
        return false
    }
    func splitViewController(splitViewController: UISplitViewController, separateSecondaryViewControllerFromPrimaryViewController primaryViewController: UIViewController!) -> UIViewController? {
        if let navVC = primaryViewController as? UINavigationController {
            for controller in navVC.viewControllers {
                if let controllerVC = controller as? UINavigationController {
                    return controllerVC
                }
            }
        }
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let detailView = storyboard.instantiateViewControllerWithIdentifier("detailVC") as UINavigationController
        
        let controller = detailView.visibleViewController
        
        controller.navigationItem.leftBarButtonItem = splitViewController.displayModeButtonItem()
        controller.navigationItem.leftItemsSupplementBackButton = true
        
        return detailView
    }
    

}

