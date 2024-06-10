//
//  ProductViewController.swift
//  YP-Sklad
//
//  Created by Марат Хасанов on 10.06.2024.
//

import UIKit
import FirebaseAuth

class ProductViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Товары"
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(closeTapped))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(createTapped))
        view.backgroundColor = .white
    }
    
    @objc func closeTapped() {
        do {
            try Auth.auth().signOut()
            let vc = WelcomeViewController()
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true)
        } catch let signOutError as NSError {
            print("Ошибка", signOutError)
        }
        print("Выйти")
    }
    
    @objc func createTapped() {
        print("Создать")
    }
}
