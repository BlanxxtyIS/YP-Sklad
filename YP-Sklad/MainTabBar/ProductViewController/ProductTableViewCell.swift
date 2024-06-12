//
//  ProductTableViewCell.swift
//  YP-Sklad
//
//  Created by Марат Хасанов on 11.06.2024.
//

import UIKit

class ProductTableViewCell: UITableViewCell {

    static let reuseIdentifier = "ProductCell"

    private lazy var productImage: UIImageView = {
       let image = UIImage(named: "Диск")
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFill
        imageView.heightAnchor.constraint(equalToConstant: 65).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 55).isActive = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 8
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private lazy var productGroupType: UILabel = {
        let label = UILabel()
        label.text = "Диски"
        label.font = .systemFont(ofSize: 10, weight: .bold)
        label.textColor = .kDarkBlue
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var productName: UILabel = {
        let label = UILabel()
        label.text = "Диски на ваз-2112"
        label.font = .systemFont(ofSize: 15, weight: .bold)
        label.textColor = .kUltraDarkBlue
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var productPrice: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .bold)
        label.textColor = .kUltraDarkBlue
        label.text = "5$"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var productInteger: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .bold)
        label.textColor = .kUltraDarkBlue
        label.text = "3-243245-3131"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
        
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .white
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCustomCell(name: String, price: String, integer: String, image: UIImage, groupType: String) {
        productName.text = name
        productPrice.text = price
        productInteger.text = integer
        productImage.image = image
        productGroupType.text = groupType
    }
    
    private func setupUI() {
        contentView.backgroundColor = UIColor(white: 1, alpha: 0.5)
        let uiElements = [productImage, productGroupType, productName, productPrice, productInteger]
        uiElements.forEach { ui in
            contentView.addSubview(ui)
        }
        
        NSLayoutConstraint.activate([
            
            // Product image constraints
            productImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            productImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            // Product stack constraints
            productGroupType.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            productGroupType.leadingAnchor.constraint(equalTo: productImage.trailingAnchor, constant: 15),
            
            productName.topAnchor.constraint(equalTo: productGroupType.bottomAnchor, constant: 5),
            productName.leadingAnchor.constraint(equalTo: productImage.trailingAnchor, constant: 15),
            
            productPrice.topAnchor.constraint(equalTo: productName.bottomAnchor, constant: 5),
            productPrice.leadingAnchor.constraint(equalTo: productImage.trailingAnchor, constant: 15),
            
            productInteger.topAnchor.constraint(equalTo: productPrice.bottomAnchor, constant: 5),
            productInteger.leadingAnchor.constraint(equalTo: productImage.trailingAnchor, constant: 15),
        ])
    }
}
