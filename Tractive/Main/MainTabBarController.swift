//
//  MainTabBarController.swift
//  Tractive
//
//  Created by Mona Shamsolebad on 2019-10-09.
//  Copyright © 2019 Derrick Park. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController , UITabBarControllerDelegate{
    
    var addRequestController:AddRequestTableViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        let addRequestController = UIStoryboard(name: "AddRequest", bundle: nil).instantiateViewController(withIdentifier: "AddRequestTableViewController") as! AddRequestTableViewController

        viewControllers = [
            createViewController(viewController: ReviewViewController(), title: "Review", imageName: "Review-gray"),
            createViewController(viewController: StatsViewController(), title: "Statistics", imageName: "Statistics-gray"),
            createViewController(viewController: addRequestController, title: "Add Request", imageName: "AddRequest-gray")
        ]
    }
    /// Helper method to create a ViewController for each tab
    ///
    /// - Parameters:
    ///   - viewController: containter view controller.
    ///   - title: nagivation title.
    ///   - imageName: tab icon image name.
    fileprivate func createViewController(viewController: UIViewController, title: String, imageName: String) -> UIViewController {
        
        
        let navController = UINavigationController(rootViewController: viewController)
        navController.navigationBar.isTranslucent = false
        navController.navigationBar.tintColor = .tractiveBackgroudColor
        navController.tabBarItem.title = title
        navController.tabBarItem.image = UIImage(named: imageName)
        viewController.navigationItem.title = title
        
        return navController
    }
   
}
