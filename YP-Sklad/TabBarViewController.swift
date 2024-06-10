//
//  TabBarViewController.swift
//  YP-Sklad
//
//  Created by Марат Хасанов on 10.06.2024.
//

import UIKit

class TabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewControllers = createViewController()
        view.backgroundColor = .white
    }
    
    private func createViewController() -> [UIViewController] {
        let newProductViewController = createNewViewController(for: NewProductViewController(), title: "Создать", imageName: "plusLogo")
        let productViewController = createNewViewController(for: ProductViewController(), title: "Товары", imageName: "checkListLogo")
        let searchViewController = createNewViewController(for: SearchViewController(), title: "Поиск", imageName: "searchLogo")
        let scannerViewController = createNewViewController(for: ScannerViewController(), title: "Сканер", imageName: "scannerLogo")
        return [newProductViewController, productViewController, searchViewController, scannerViewController]
    }
    
    private func createNewViewController(for rootViewController: UIViewController, title: String, imageName: String) -> UIViewController {
        let navController = UINavigationController(rootViewController: rootViewController)
        navController.tabBarItem = UITabBarItem(title: title, image: UIImage(named: imageName), tag: 0)
        return navController
    }
}
