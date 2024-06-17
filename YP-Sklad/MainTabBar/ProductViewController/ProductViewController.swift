//
//  ProductViewController.swift
//  YP-Sklad
//
//  Created by Марат Хасанов on 10.06.2024.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage

class ProductViewController: UIViewController {
    
    let db = Firestore.firestore()
    
    var productCell: [ProductModel] = []
    
    private lazy var backgroundImage: UIImageView = {
        let image = UIImage(named: "BackgroundImage")
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleToFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var productTableView: UITableView = {
        let table = UITableView()
        table.register(ProductTableViewCell.self, forCellReuseIdentifier: ProductTableViewCell.reuseIdentifier)
        table.backgroundColor = UIColor.white
        table.layer.cornerRadius = 16
        table.delegate = self
        table.dataSource = self
        table.backgroundColor = .clear
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        startLoadingData()
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
            backgroundImage.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImage.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5),
            
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
    
    //Достать из 'Firebase Cloud Firestore' данные
    private func loadData(completion: @escaping () -> Void) {
        
        DispatchQueue.global(qos: .background).async {
            self.db.collection("infoBody").order(by: "date").getDocuments { querySnapshot, error in
                if let e = error {
                    print("\(e) Ошибка при загрузке данных")
                } else {
                    if let data = querySnapshot?.documents {
                        let group = DispatchGroup()
                        data.forEach { document in
                            group.enter()
                            let data = document.data()
                            let id = data["id"] as! String
                            let sender = data["sender"]  as! String
                            //let date = data["date"] as! Date
                            let name = data["name"] as! String
                            let sizeX = data["sizeX"] as! String
                            let sizeY = data["sizeY"] as! String
                            let sizeZ = data["sizeZ"] as! String
                            let weight = data["weight"] as! String
                            let count = data["count"] as! String
                            let price = data["price"] as! String
                            let stack = data["stack"] as! String
                            let counterparty = data["counterparty"] as! String
                            let imageURLString = data["image"] as! String
                            let type = data["type"] as! String
                            
                            guard let imageURL = URL(string: imageURLString), imageURL.scheme == "gs" || imageURL.scheme == "http" || imageURL.scheme == "https" else {
                                print("Некорректный URL: \(imageURLString)")
                                let product = ProductModel(id: id,
                                                           name: name,
                                                           sizeX: sizeX,
                                                           sizeY: sizeY,
                                                           sizeZ: sizeZ,
                                                           weigth: weight,
                                                           count: count,
                                                           price: price,
                                                           stack: stack,
                                                           counterparty: counterparty,
                                                           image: UIImage(named: "Поршни"), 
                                                           type: type)
                                self.productCell.append(product)
                                group.leave()
                                return
                            }
                            
                            let storageRef = Storage.storage().reference(forURL: imageURLString)
                            storageRef.getData(maxSize: 1 * 1024 * 1024) { data, error in
                                var image: UIImage?
                                if let error = error {
                                    print("Ошибка при загрузке изображения: \(error)")
                                    image = UIImage(named: "Диск1")
                                } else {
                                    if let imageData = data {
                                        image = UIImage(data: imageData)
                                    }
                                }
                                if image == nil {
                                    image = UIImage(named: "Поршни")
                                }
                                let product = ProductModel(id: id,
                                                           name: name,
                                                           sizeX: sizeX,
                                                           sizeY: sizeY,
                                                           sizeZ: sizeZ,
                                                           weigth: weight,
                                                           count: count,
                                                           price: price,
                                                           stack: stack,
                                                           counterparty: counterparty,
                                                           image: image,
                                                           type: type)
                                self.productCell.append(product)
                                group.leave()
                            }
                        }
                        group.notify(queue: .main) {
                            completion()
                        }
                    } else {
                        completion()
                    }
                }
            }
        }
    }
    
    func startLoadingData() {
        loadData {
            self.productTableView.reloadData()
        }
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
        cell.backgroundColor = .clear
        return cell
    }
}
