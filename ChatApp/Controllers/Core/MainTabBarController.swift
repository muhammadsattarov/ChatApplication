//
//  MailTabBarController.swift
//  ChatApp
//
//  Created by user on 16/05/24.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let listVC = ListViewController()
        let peopleVC = PeopleViewController()
        tabBar.tintColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
        let convImage = UIImage(systemName: "bubble.left.and.bubble.right")!
        let peopleImage = UIImage(systemName: "person.2")!
        
        viewControllers = [
            generateNavigationController(viewController: peopleVC, title: "People", image: peopleImage),
            generateNavigationController(viewController: listVC, title: "Conversations", image: convImage)
        ]
    }
    
    func generateNavigationController(viewController: UIViewController, title: String, image: UIImage) -> UIViewController  {
        let navVC = UINavigationController(rootViewController: viewController)
        navVC.tabBarItem.title = title
        navVC.tabBarItem.image = image
        return navVC
    }
}
