//
//  NewProductViewController.swift
//  YP-Sklad
//
//  Created by Марат Хасанов on 10.06.2024.
//

import UIKit

class NewProductViewController: UIViewController {
    
    // MARK: - Public Properties
    // MARK: - Private Properties
    private lazy var productName: UILabel = {
        let label = UILabel()
        label.text = "Наименование:"
        label.textColor = .systemBlue
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var productNameCreate: UITextField = {
        let search = UITextField()
        search.placeholder = "Введите наименование"
        search.layer.borderWidth = 1.0
        search.layer.borderColor = UIColor.systemGray.cgColor
        search.layer.cornerRadius = 5.0
        search.delegate = self
        // Создаем UIView для левого отступа
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: search.frame.height))
        search.leftView = paddingView
        search.leftViewMode = .always  // Показывать отступ всегда
        search.translatesAutoresizingMaskIntoConstraints = false
        return search
    }()
    
    //Размер
    private lazy var productSize: UILabel = {
        let label = UILabel()
        label.text = "Размер: X-Y-Z"
        label.textColor = .systemBlue
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
        
    private lazy var productSizeX: UITextField = {
        let search = UITextField()
        search.placeholder = "размер X"
        search.layer.borderWidth = 1.0
        search.layer.borderColor = UIColor.systemGray.cgColor
        search.layer.cornerRadius = 5.0
        search.delegate = self
        // Создаем UIView для левого отступа
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: search.frame.height))
        search.leftView = paddingView
        search.leftViewMode = .always  // Показывать отступ всегда
        search.translatesAutoresizingMaskIntoConstraints = false
        return search
    }()
    
    private lazy var productSizeY: UITextField = {
        let search = UITextField()
        search.placeholder = "размер Y"
        search.layer.borderWidth = 1.0
        search.layer.borderColor = UIColor.systemGray.cgColor
        search.layer.cornerRadius = 5.0
        search.delegate = self
        // Создаем UIView для левого отступа
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: search.frame.height))
        search.leftView = paddingView
        search.leftViewMode = .always  // Показывать отступ всегда
        search.translatesAutoresizingMaskIntoConstraints = false
        return search
    }()
    
    private lazy var productSizeZ: UITextField = {
        let search = UITextField()
        search.placeholder = "размер Z"
        search.layer.borderWidth = 1.0
        search.layer.borderColor = UIColor.systemGray.cgColor
        search.layer.cornerRadius = 5.0
        search.delegate = self
        // Создаем UIView для левого отступа
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: search.frame.height))
        search.leftView = paddingView
        search.leftViewMode = .always  // Показывать отступ всегда
        search.translatesAutoresizingMaskIntoConstraints = false
        return search
    }()
    
    private lazy var sizeStackView: UIStackView = {
       let stack = UIStackView(arrangedSubviews: [productSizeX, productSizeY, productSizeZ])
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .fillEqually
        stack.spacing = 10
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    //Вес
    private lazy var productWeight: UILabel = {
        let label = UILabel()
        label.text = "Вес:"
        label.textColor = .systemBlue
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var productWeightCreate: UITextField = {
        let search = UITextField()
        search.placeholder = "Введите вес"
        search.layer.borderWidth = 1.0
        search.layer.borderColor = UIColor.systemGray.cgColor
        search.layer.cornerRadius = 5.0
        search.delegate = self
        // Создаем UIView для левого отступа
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: search.frame.height))
        search.leftView = paddingView
        search.leftViewMode = .always  // Показывать отступ всегда
        search.translatesAutoresizingMaskIntoConstraints = false
        return search
    }()

    //Количество
    private lazy var productCount: UILabel = {
        let label = UILabel()
        label.text = "Количество и цена:"
        label.textColor = .systemBlue
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var productCountCreate: UITextField = {
        let search = UITextField()
        search.placeholder = "Введите количество"
        search.layer.borderWidth = 1.0
        search.layer.borderColor = UIColor.systemGray.cgColor
        search.layer.cornerRadius = 5.0
        search.delegate = self
        // Создаем UIView для левого отступа
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: search.frame.height))
        search.leftView = paddingView
        search.leftViewMode = .always  // Показывать отступ всегда
        search.translatesAutoresizingMaskIntoConstraints = false
        return search
    }()
    
    private lazy var productPriceCreate: UITextField = {
        let search = UITextField()
        search.placeholder = "Цена"
        search.layer.borderWidth = 1.0
        search.layer.borderColor = UIColor.systemGray.cgColor
        search.layer.cornerRadius = 5.0
        search.delegate = self
        // Создаем UIView для левого отступа
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: search.frame.height))
        search.leftView = paddingView
        search.leftViewMode = .always  // Показывать отступ всегда
        search.translatesAutoresizingMaskIntoConstraints = false
        return search
    }()
    
    private lazy var productCountAndPrice: UIStackView = {
       let stack = UIStackView(arrangedSubviews: [productCountCreate, productPriceCreate])
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .fillEqually
        stack.spacing = 10
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    //Складирование
    private lazy var productSclading: UILabel = {
        let label = UILabel()
        label.text = "Можно складировать?"
        label.textColor = .systemBlue
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var productScladingCreate: UITextField = {
        let search = UITextField()
        search.placeholder = "Да/Нет"
        search.layer.borderWidth = 1.0
        search.layer.borderColor = UIColor.systemGray.cgColor
        search.layer.cornerRadius = 5.0
        search.delegate = self
        // Создаем UIView для левого отступа
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: search.frame.height))
        search.leftView = paddingView
        search.leftViewMode = .always  // Показывать отступ всегда
        search.translatesAutoresizingMaskIntoConstraints = false
        return search
    }()
    
    private lazy var productKontragent: UILabel = {
        let label = UILabel()
        label.text = "Поставщик:"
        label.textColor = .systemBlue
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var productKontagentCreate: UITextField = {
        let search = UITextField()
        search.placeholder = "Наименование поставщика"
        search.layer.borderWidth = 1.0
        search.layer.borderColor = UIColor.systemGray.cgColor
        search.layer.cornerRadius = 5.0
        search.delegate = self
        // Создаем UIView для левого отступа
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: search.frame.height))
        search.leftView = paddingView
        search.leftViewMode = .always  // Показывать отступ всегда
        search.translatesAutoresizingMaskIntoConstraints = false
        return search
    }()
    
    private lazy var saveProductButton: UIButton = {
       let button = UIButton()
        button.addTarget(self, action: #selector(saveProductButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .blue
        button.setTitle("Сохранить", for: .normal)
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.widthAnchor.constraint(equalToConstant: 100).isActive = true
        return button
    }()

    // MARK: - Initilaized
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.systemBackground
        title = "Новый товар"
        print("ПОЛЬЗОВАТЕЛИ:")
        setupUI()
    }
    
    // MARK: - Public Methods
    
    // MARK: - Private Methods
    @objc
    private func saveProductButtonTapped() {
        print("Сохранить")
    }
    
    private func setupUI() {
        let allViews = [productName, productNameCreate, productSize, sizeStackView, productWeight, productWeightCreate, productCount, productCountAndPrice, productSclading, productScladingCreate, productKontragent, productKontagentCreate, saveProductButton]
        
        allViews.forEach { view in
            self.view.addSubview(view)
        }
        
        NSLayoutConstraint.activate([
            productName.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            productName.bottomAnchor.constraint(equalTo: productNameCreate.topAnchor),
            productName.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            
            productNameCreate.topAnchor.constraint(equalTo: productName.bottomAnchor, constant: -10),
            productNameCreate.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 25),
            productNameCreate.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
            productNameCreate.heightAnchor.constraint(equalToConstant: 44),
            
            productSize.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            productSize.topAnchor.constraint(equalTo: productNameCreate.bottomAnchor, constant: 10),
            
            sizeStackView.topAnchor.constraint(equalTo: productSize.bottomAnchor),
            sizeStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            sizeStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
            sizeStackView.heightAnchor.constraint(equalToConstant: 44),
            
            productWeight.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            productWeight.topAnchor.constraint(equalTo: sizeStackView.bottomAnchor, constant: 10),
            
            productWeightCreate.topAnchor.constraint(equalTo: productWeight.bottomAnchor),
            productWeightCreate.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            productWeightCreate.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
            productWeightCreate.heightAnchor.constraint(equalToConstant: 44),
            
            productCount.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            productCount.topAnchor.constraint(equalTo: productWeightCreate.bottomAnchor, constant: 10),
            
            productCountAndPrice.topAnchor.constraint(equalTo: productCount.bottomAnchor),
            productCountAndPrice.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            productCountAndPrice.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
            productCountAndPrice.heightAnchor.constraint(equalToConstant: 44),
            
            productCountCreate.widthAnchor.constraint(equalTo: productCountAndPrice.widthAnchor, multiplier: 0.7),
            productPriceCreate.widthAnchor.constraint(equalTo: productCountAndPrice.widthAnchor, multiplier: 0.2),
            
            productSclading.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            productSclading.topAnchor.constraint(equalTo: productCountAndPrice.bottomAnchor, constant: 10),
            
            productScladingCreate.topAnchor.constraint(equalTo: productSclading.bottomAnchor),
            productScladingCreate.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            productScladingCreate.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
            productScladingCreate.heightAnchor.constraint(equalToConstant: 44),
            
            productKontragent.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            productKontragent.topAnchor.constraint(equalTo: productScladingCreate.bottomAnchor, constant: 10),
            
            productKontagentCreate.topAnchor.constraint(equalTo: productKontragent.bottomAnchor),
            productKontagentCreate.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            productKontagentCreate.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
            productKontagentCreate.heightAnchor.constraint(equalToConstant: 44),
            
            saveProductButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            saveProductButton.topAnchor.constraint(equalTo: productKontagentCreate.bottomAnchor, constant: 10)
        ])
    }
}

// MARK: - UITextFieldDelegate
extension NewProductViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()  // Скрыть клавиатуру
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // Получаем текущий текст
        if let currentText = textField.text, let textRange = Range(range, in: currentText) {
            let updatedText = currentText.replacingCharacters(in: textRange, with: string)
            
            switch textField {
            case productNameCreate:
                print("хай")
            case productSizeX:
                print("хой")
            default:
                print("хуй")
            }
        }
        return true
    }
}
