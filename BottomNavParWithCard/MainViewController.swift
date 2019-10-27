//
//  ViewController.swift
//  BottomNavParWithCard
//
//  Created by Martin Kim on 10/20/19.
//  Copyright © 2019 Martin Kim. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
    }
    
    func setupTabBar() {
        tabBar.barTintColor = UIColor(red: 38/255, green: 196/255, blue: 133/255, alpha: 0.5)
        let discoveryNavigationViewController = UINavigationController(rootViewController: DiscoveryViewController())
           discoveryNavigationViewController.tabBarItem.image = UIImage(systemName: "music.note")
        let libraryNavigationViewController = UINavigationController(rootViewController: LibraryViewController())
        libraryNavigationViewController.tabBarItem.image = UIImage(systemName: "music.note.list")
        viewControllers = [discoveryNavigationViewController, libraryNavigationViewController]
    }

}

