//
//  MainTabBarViewController.swift
//  Netflix-UI
//
//  Created by Ceren Güneş on 8.08.2023.
//


import UIKit

class MainTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let vc1 = UINavigationController(rootViewController: MainPageViewController())
        let vc2 = UINavigationController(rootViewController: NewAndPopularViewController())
        let vc3 = UINavigationController(rootViewController: MyNetflixViewController())
        
        vc1.tabBarItem.image = UIImage(systemName: "house")
        vc2.tabBarItem.image = UIImage(systemName: "play.rectangle.on.rectangle")
        vc3.tabBarItem.image = UIImage(systemName: "magnifyingglass")
        
        vc1.title = "Ana Sayfa"
        vc2.title = "Yeni ve Populer"
        vc3.title = "Benim Netflix'im"
        
        tabBar.tintColor = .white
        
        setViewControllers([vc1, vc2, vc3], animated: true)
    }
}

