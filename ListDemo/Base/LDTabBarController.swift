//
//  LDTabBarController.swift
//  ListDemo
//
//  Created by 张玥 on 2021/3/7.
//

import UIKit

class LDTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.isTranslucent = false
        tabBar.tintColor = UIColor.black
        let homeVC = LDUserListViewController()
        addChildViewController(homeVC,
                               title: "",
                               image: UIImage(named: "tab_index"),
                               selectedImage: UIImage(named: "tab_index_selected"))
    }
    
    func addChildViewController(_ childController: UIViewController, title:String?, image:UIImage? ,selectedImage:UIImage?) {
        
        childController.title = title
        childController.tabBarItem = UITabBarItem(title: title,
                                                  image: image?.withRenderingMode(.alwaysOriginal),
                                                  selectedImage: selectedImage?.withRenderingMode(.alwaysOriginal))
        
        if UIDevice.current.userInterfaceIdiom == .phone {
            childController.tabBarItem.imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
        addChild(LDNavigationController(rootViewController: childController))
    }
}


