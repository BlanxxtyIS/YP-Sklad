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
        let productViewController = createNewViewController(for: ProductViewController(), title: "", imageName: "checkListLogo")
        let newProductViewController = createNewViewController(for: NewProductViewController(), title: "", imageName: "plusLogo")
        let searchViewController = createNewViewController(for: SearchViewController(), title: "", imageName: "searchLogo")
        let scannerViewController = createNewViewController(for: ScannerViewController(), title: "", imageName: "scannerLogo")
        return [productViewController, newProductViewController, searchViewController, scannerViewController]
    }
    
    private func createNewViewController(for rootViewController: UIViewController, title: String, imageName: String) -> UIViewController {
        let navController = UINavigationController(rootViewController: rootViewController)
        let tabBarItem = UITabBarItem(title: "", image: UIImage(named: imageName)?.withRenderingMode(.alwaysOriginal), selectedImage: nil)
        // Уменьшаем размер изображения путем установки отрицательных отступов
        tabBarItem.imageInsets = UIEdgeInsets(top: 8, left: 8, bottom: -8, right: 8)
        navController.tabBarItem = tabBarItem
        
        // Настройка внешнего вида текста надписей на таб-баре
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 10, weight: .regular), // Размер и стиль шрифта
            .foregroundColor: UIColor.kUltraDarkBlue // Цвет текста
        ]
        navController.tabBarItem.setTitleTextAttributes(attributes, for: .normal)
        
        
        return navController
    }

}
