//
//  UIViewController+Extension.swift
//  ChatApp
//
//  Created by user on 18/05/24.
//

import UIKit

extension UIViewController {
    func configure<T: SelfConfiguringCell, U: Hashable>(collectionView: UICollectionView, cellType: T.Type, with model: U, for indexPath: IndexPath) -> T {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: T.reuseId, for: indexPath) as? T else {
            fatalError("Unable to dequeue \(cellType)")
        }
        cell.configure(with: model)
        return cell
    }
}

extension UIApplication {
    class func getTopViewController(controller: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let navigationController = controller as? UINavigationController {
            return getTopViewController(controller: navigationController.visibleViewController)
        }
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return getTopViewController(controller: selected)
            }
        }
        if let presented = controller?.presentedViewController {
            return getTopViewController(controller: presented)
        }
        return controller
    }
}

