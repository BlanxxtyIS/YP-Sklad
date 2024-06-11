//
//  ProductViewController.swift
//  YP-Sklad
//
//  Created by Марат Хасанов on 10.06.2024.
//

import UIKit
import FirebaseAuth

class ProductViewController: UIViewController {
    
    let productCell =
        [ProductModel(name: "Marat", sizeX: 10, sizeY: 10, sizeZ: 10, weigth: 10, count: 1, price: 15, stack: true, counterparty: "Hello"),
        ProductModel(name: "Milya", sizeX: 10, sizeY: 10, sizeZ: 10, weigth: 10, count: 1, price: 15, stack: true, counterparty: "Hello"),
        ProductModel(name: "Lenar", sizeX: 10, sizeY: 10, sizeZ: 10, weigth: 10, count: 1, price: 15, stack: true, counterparty: "Hello"),
        ProductModel(name: "Leysan", sizeX: 10, sizeY: 10, sizeZ: 10, weigth: 10, count: 1, price: 15, stack: true, counterparty: "Hello")]
    
    private lazy var backgroundImage: UIImageView = {
       let image = UIImage(named: "BackgroundImage")
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var productTableView: UITableView = {
        let table = UITableView()
        table.register(ProductTableViewCell.self, forCellReuseIdentifier: ProductTableViewCell.reuseIdentifier)
        table.delegate = self
        table.dataSource = self
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        title = "Товары"
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(closeTapped))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(createTapped))
        view.backgroundColor = .white
        
        view.addSubview(backgroundImage)
        view.addSubview(productTableView)
        
        NSLayoutConstraint.activate([
            backgroundImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            backgroundImage.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        
            productTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            productTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            productTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            productTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 10)])
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

extension ProductViewController: UITableViewDelegate {
    
}

extension ProductViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productCell.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ProductTableViewCell.reuseIdentifier, for: indexPath) as! ProductTableViewCell
        return cell
    }
}
