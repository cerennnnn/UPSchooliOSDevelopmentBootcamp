//
//  MainTabBarViewController.swift
//  Netflix-UI
//
//  Created by Ceren Güneş on 8.08.2023.
//


import UIKit

protocol ResizeImageProtocol {
    func resizeImage(image: UIImage, newWidth: CGFloat, newHeight: CGFloat) -> UIImage?
}

class TabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let vc1 = UINavigationController(rootViewController: MainPageViewController())
        let vc2 = UINavigationController(rootViewController: NewAndPopularViewController())
        let vc3 = UINavigationController(rootViewController: MyNetflixViewController())
        
        var image = UIImage(named: "smiley_icon")
        
        if let originalImage = UIImage(named: "smiley_icon") {
            let newWidth: CGFloat = 30
            let newHeight: CGFloat = 30
            
            if let resizedImage = resizeImage(image: originalImage, newWidth: newWidth, newHeight: newHeight) {
                image = resizedImage
            }
        }
        
        vc1.tabBarItem.image = UIImage(systemName: "house")
        vc2.tabBarItem.image = UIImage(systemName: "play.rectangle.on.rectangle")
        vc3.tabBarItem.image = image?.withRenderingMode(.alwaysOriginal)
        
        vc1.title = "Home"
        vc2.title = "New & Popular"
        vc3.title = "My Netflix"
        
        tabBar.tintColor = .label
        
        setViewControllers([vc1, vc2, vc3], animated: true)
    }
}

extension TabBarViewController {
    private func resizeImage(image: UIImage, newWidth: CGFloat, newHeight: CGFloat) -> UIImage? {
        let newSize = CGSize(width: newWidth, height: newHeight)
        
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        image.draw(in: CGRect(origin: .zero, size: newSize))
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
}
