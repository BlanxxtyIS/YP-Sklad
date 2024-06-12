//
//  ProductViewController.swift
//  YP-Sklad
//
//  Created by Марат Хасанов on 10.06.2024.
//

import UIKit
import FirebaseAuth

class ProductViewController: UIViewController {
    
    let productCell = [
    ProductModel(name: "Двигатель BMW", sizeX: 10, sizeY: 10, sizeZ: 10, weigth: 100, count: 1, price: 100, stack: false, counterparty: "ООО BMW", qrCode: "QR CODE", image: UIImage(named: "Двигатель"), type: "Двигатели"),
    ProductModel(name: "Двигатель AUDI", sizeX: 10, sizeY: 10, sizeZ: 10, weigth: 100, count: 1, price: 100, stack: false, counterparty: "ООО Audi", qrCode: "QR CODE", image: UIImage(named: "Двигатель1"), type: "Двигатели"),
    ProductModel(name: "Диск 16R", sizeX: 10, sizeY: 10, sizeZ: 10, weigth: 100, count: 1, price: 100, stack: false, counterparty: "ООО Тапки", qrCode: "QR CODE", image: UIImage(named: "Диск"), type: "Диски"),
    ProductModel(name: "Диск 18R", sizeX: 10, sizeY: 10, sizeZ: 10, weigth: 100, count: 1, price: 100, stack: false, counterparty: "ООО Тапки", qrCode: "QR CODE", image: UIImage(named: "Диск1"), type: "Диски"),
    ProductModel(name: "Масло", sizeX: 10, sizeY: 10, sizeZ: 10, weigth: 100, count: 1, price: 100, stack: false, counterparty: "ООО Поставщик", qrCode: "QR CODE", image: UIImage(named: "масло"), type: "Расходники"),
    ProductModel(name: "Поршни", sizeX: 10, sizeY: 10, sizeZ: 10, weigth: 100, count: 1, price: 100, stack: false, counterparty: "ООО Поставщик", qrCode: "QR CODE", image: UIImage(named: "Поршни"), type: "Детали"),
    ProductModel(name: "Пружины", sizeX: 10, sizeY: 10, sizeZ: 10, weigth: 100, count: 1, price: 100, stack: false, counterparty: "ООО Поставщик", qrCode: "QR CODE", image: UIImage(named: "Пружины"), type: "Расходники"),
    ]
    
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
        table.backgroundColor = UIColor(white: 1, alpha: 0.3)
        table.layer.cornerRadius = 16
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
            productTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10)])
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }
}

extension ProductViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productCell.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ProductTableViewCell.reuseIdentifier, for: indexPath) as! ProductTableViewCell
        let product = productCell[indexPath.row]
        cell.setupCustomCell(name: product.name,
                             price: "\(product.price) $",
                             integer: "кол-во: \(product.count)",
                             image: product.image ?? UIImage(named: "007-thumbs up")!,
                             groupType: product.type)
        return cell
    }
}
