//
//  NewProductViewController.swift
//  YP-Sklad
//
//  Created by Марат Хасанов on 10.06.2024.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage

class NewProductViewController: UIViewController {
    
    // MARK: - Public Properties
    // MARK: - Private Properties
    let storage = Storage.storage()
    var test = ""
    private let db = Firestore.firestore()
    private var productImage = UIImage(named: "003-delivery")
    
    private lazy var successufulImage: UIImageView = {
       let image = UIImage(named: "007-thumbs up")
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleToFill
        imageView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 150).isActive = true
        imageView.isHidden = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
        
    }()
    
    private lazy var backgroundImage: UIImageView = {
        let image = UIImage(named: "BackgroundImage")
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleToFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = 16
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var productName: UILabel = {
        let label = UILabel()
        label.text = "НАИМЕНОВАНИЕ:"
        label.font = .systemFont(ofSize: 10, weight: .bold)
        label.textColor = .kDarkBlue
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var productNameCreate: UITextField = {
        let search = UITextField()
        let attributes: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.kBlueShadow]
        search.attributedPlaceholder = NSAttributedString(string: "Введите наименование", attributes: attributes)
        search.textColor = .kDarkBlue
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
        label.text = "РАЗМЕР: X-Y-Z"
        label.font = .systemFont(ofSize: 10, weight: .bold)
        label.textColor = .kDarkBlue
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var productSizeX: UITextField = {
        let search = UITextField()
        let attributes: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.kBlueShadow]
        search.attributedPlaceholder = NSAttributedString(string: "размер Х", attributes: attributes)
        search.textColor = .kDarkBlue
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
        let attributes: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.kBlueShadow]
        search.attributedPlaceholder = NSAttributedString(string: "размер Y", attributes: attributes)
        search.textColor = .kDarkBlue
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
        let attributes: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.kBlueShadow]
        search.attributedPlaceholder = NSAttributedString(string: "размер Z", attributes: attributes)
        search.textColor = .kDarkBlue
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
        label.text = "ВЕС:"
        label.font = .systemFont(ofSize: 10, weight: .bold)
        label.textColor = .kDarkBlue
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var productWeightCreate: UITextField = {
        let search = UITextField()
        let attributes: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.kBlueShadow]
        search.attributedPlaceholder = NSAttributedString(string: "Введите вес", attributes: attributes)
        search.textColor = .kDarkBlue
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
        label.text = "КОЛИЧЕСТВО И ЦЕНА:"
        label.font = .systemFont(ofSize: 10, weight: .bold)
        label.textColor = .kDarkBlue
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var productCountCreate: UITextField = {
        let search = UITextField()
        let attributes: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.kBlueShadow]
        search.attributedPlaceholder = NSAttributedString(string: "Введите количество", attributes: attributes)
        search.textColor = .kDarkBlue
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
        let attributes: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.kBlueShadow]
        search.attributedPlaceholder = NSAttributedString(string: "Цена", attributes: attributes)
        search.textColor = .kDarkBlue
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
        label.text = "МОЖНО СКЛАДИРОВАТЬ?"
        label.font = .systemFont(ofSize: 10, weight: .bold)
        label.textColor = .kDarkBlue
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var productScladingCreate: UITextField = {
        let search = UITextField()
        let attributes: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.kBlueShadow]
        search.attributedPlaceholder = NSAttributedString(string: "Да/Нет", attributes: attributes)
        search.textColor = .kDarkBlue
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
        label.text = "ПОСТАВЩИК:"
        label.font = .systemFont(ofSize: 10, weight: .bold)
        label.textColor = .kDarkBlue
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var productKontagentCreate: UITextField = {
        let search = UITextField()
        let attributes: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.kBlueShadow]
        search.attributedPlaceholder = NSAttributedString(string: "Наименование поставщика", attributes: attributes)
        search.textColor = .kDarkBlue
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
    
    private lazy var productQR: UILabel = {
        let label = UILabel()
        label.text = "QR-КОД И ТИП ТОВАРА:"
        label.font = .systemFont(ofSize: 10, weight: .bold)
        label.textColor = .kDarkBlue
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var productQRCreate: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(addQrCode), for: .touchUpInside)
        button.setTitle("QR-Код товара", for: .normal)
        button.setTitleColor(.kDarkBlue, for: .normal)
        button.layer.borderColor = UIColor.kDarkBlue.cgColor
        button.layer.borderWidth = 1
        button.titleLabel?.font = .systemFont(ofSize: 12, weight: .bold)
        button.layer.cornerRadius = 5.0
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var productTypeCreate: UITextField = {
        let search = UITextField()
        let attributes: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.kBlueShadow]
        search.attributedPlaceholder = NSAttributedString(string: "Тип товара", attributes: attributes)
        search.textColor = .kDarkBlue
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
    
    private lazy var productQRAndType: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [productQRCreate, productTypeCreate])
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .fillEqually
        stack.spacing = 10
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var productImageCreate: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(addProductImage), for: .touchUpInside)
        button.setTitle("Изображение товара", for: .normal)
        button.setTitleColor(.kDarkBlue, for: .normal)
        button.layer.borderColor = UIColor.kDarkBlue.cgColor
        button.layer.borderWidth = 1
        button.titleLabel?.font = .systemFont(ofSize: 12, weight: .bold)
        button.layer.cornerRadius = 5.0
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var saveProductButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(saveProductButtonTapped), for: .touchUpInside)
        button.setTitle("Сохранить", for: .normal)
        button.backgroundColor = .kDarkBlue
        button.layer.cornerRadius = 5.0
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.widthAnchor.constraint(equalToConstant: 150).isActive = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var productImageAndButtonStack: UIStackView = {
       let stack = UIStackView(arrangedSubviews: [productImageCreate, saveProductButton])
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .fillEqually
        stack.spacing = 10
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    
    // MARK: - Initilaized
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        title = "Новый товар"
        setupUI()
        //loadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //loadData()
    }
    
    // MARK: - Public Methods
    
    // MARK: - Private Methods
    @objc
    private func addQrCode() {
        let vc = ScannerViewController()
        present(vc, animated: true)
    }
    
    @objc
    private func addProductImage() {
        print("Добавивть изображение")
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.allowsEditing = false
        present(imagePickerController, animated: true, completion: nil)
    }
    
    //Отправить в DB
    @objc
    private func saveProductButtonTapped() {
        guard let name = productNameCreate.text,
              let sender = Auth.auth().currentUser?.email,
              let image = UIImage(named: "Диск1"),
              let imageData = image.jpegData(compressionQuality: 0.8) else {
            print("Ошибка: не удалось получить данные изображения")
            return
        }
        
        let imageID = UUID().uuidString
        let storageRef = Storage.storage().reference().child("images/\(imageID).jpg")
        
        // Загрузка изображения в Firebase Storage
        storageRef.putData(imageData, metadata: nil) { metadata, error in
            if let error = error {
                print("Ошибка при загрузке изображения в Storage: \(error)")
                return
            }
            
            // Получение URL загруженного изображения
            storageRef.downloadURL { url, error in
                if let error = error {
                    print("Ошибка при получении URL изображения: \(error)")
                    return
                }
                
                guard let imageUrl = url?.absoluteString else {
                    print("Ошибка: не удалось получить URL изображения")
                    return
                }
                
                // Сохранение данных в Firestore
                self.saveProductToFirestore(imageUrl: imageUrl)
            }
        }
    }
    
    private func saveProductToFirestore(imageUrl: String) {
        if let name = productNameCreate.text,
           let sender = Auth.auth().currentUser?.email {
            db.collection("infoBody").addDocument(data: [
                "id": "UUID",
                "sender": sender,
                "date": Date().timeIntervalSince1970,
                "name" : productNameCreate.text!,
                "sizeX" : productSizeX.text!,
                "sizeY" : productSizeY.text!,
                "sizeZ" : productSizeZ.text!,
                "weight" : productWeightCreate.text!,
                "count" : productCountCreate.text!,
                "price" : productPriceCreate.text!,
                "stack" : productScladingCreate.text!,
                "counterparty" : productKontagentCreate.text!,
                "image" : imageUrl,
                "type" : productTypeCreate.text!
            ]) { error in
                if let e = error {
                    print("\(e) - Ошибка при сохранении в FireStore")
                } else {
                    print("Successfully! Данные сохранены")
                    self.successufulImageView()
                }
            }
        }
    }
    
    private func setupUI() {
        view.addSubview(backgroundImage)
        view.addSubview(contentView)
    
        let allViews = [
            productName, productNameCreate, productSize, sizeStackView, productWeight, productWeightCreate,
            productCount, productCountAndPrice, productSclading, productScladingCreate, productKontragent,
            productKontagentCreate, productQR, productQRAndType, productImageAndButtonStack, successufulImage
        ]
        
        allViews.forEach { view in
            contentView.addSubview(view)
        }
        
        NSLayoutConstraint.activate([
            backgroundImage.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            backgroundImage.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5),
            
            contentView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            contentView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            
            productName.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            productName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 25),
            productName.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            
            productNameCreate.topAnchor.constraint(equalTo: productName.bottomAnchor, constant: 8),
            productNameCreate.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 25),
            productNameCreate.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -25),
            productNameCreate.heightAnchor.constraint(equalToConstant: 44),
            
            productSize.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 25),
            productSize.topAnchor.constraint(equalTo: productNameCreate.bottomAnchor, constant: 12),
            
            sizeStackView.topAnchor.constraint(equalTo: productSize.bottomAnchor, constant: 8),
            sizeStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 25),
            sizeStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -25),
            sizeStackView.heightAnchor.constraint(equalToConstant: 44),
            
            productWeight.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 25),
            productWeight.topAnchor.constraint(equalTo: sizeStackView.bottomAnchor, constant: 12),
            
            productWeightCreate.topAnchor.constraint(equalTo: productWeight.bottomAnchor, constant: 8),
            productWeightCreate.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 25),
            productWeightCreate.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -25),
            productWeightCreate.heightAnchor.constraint(equalToConstant: 44),
            
            productCount.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 25),
            productCount.topAnchor.constraint(equalTo: productWeightCreate.bottomAnchor, constant: 12),
            
            productCountAndPrice.topAnchor.constraint(equalTo: productCount.bottomAnchor, constant: 8),
            productCountAndPrice.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 25),
            productCountAndPrice.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -25),
            productCountAndPrice.heightAnchor.constraint(equalToConstant: 44),
            
            productSclading.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 25),
            productSclading.topAnchor.constraint(equalTo: productCountAndPrice.bottomAnchor, constant: 12),
            
            productScladingCreate.topAnchor.constraint(equalTo: productSclading.bottomAnchor, constant: 8),
            productScladingCreate.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 25),
            productScladingCreate.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -25),
            productScladingCreate.heightAnchor.constraint(equalToConstant: 44),
            
            productKontragent.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 25),
            productKontragent.topAnchor.constraint(equalTo: productScladingCreate.bottomAnchor, constant: 12),
            
            productKontagentCreate.topAnchor.constraint(equalTo: productKontragent.bottomAnchor, constant: 8),
            productKontagentCreate.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 25),
            productKontagentCreate.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -25),
            productKontagentCreate.heightAnchor.constraint(equalToConstant: 44),
            
            productQR.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 25),
            productQR.topAnchor.constraint(equalTo: productKontagentCreate.bottomAnchor, constant: 12),
            
            productQRAndType.topAnchor.constraint(equalTo: productQR.bottomAnchor, constant: 8),
            productQRAndType.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 25),
            productQRAndType.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -25),
            productQRAndType.heightAnchor.constraint(equalToConstant: 44),
                        
            productImageAndButtonStack.topAnchor.constraint(equalTo: productQRAndType.bottomAnchor, constant: 20),
            productImageAndButtonStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 25),
            productImageAndButtonStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -25),
            productImageAndButtonStack.heightAnchor.constraint(equalToConstant: 50),
            
            successufulImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            successufulImage.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func successufulImageView() {
        successufulImage.isHidden = false
        DispatchQueue.main.async {
            sleep(2)
            self.successufulImage.isHidden = true
        }
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
            
//            switch textField {
//            case productNameCreate:
//                print("тест")
//            case productSizeX:
//                print("тест2")
//            default:
//                print("тест3")
//            }
        }
        return true
    }
}

extension NewProductViewController: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        
        if let selectedImage = info[.originalImage] as? UIImage {
            productImage = selectedImage
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}

extension NewProductViewController: ScannerViewControllerDelegate {
    func getQrData(product: ProductModel) {
        print(product)
        productNameCreate.text = product.name
        productSizeX.text = product.sizeX
        productSizeY.text = product.sizeY
        productSizeZ.text = product.sizeZ
    }
}
