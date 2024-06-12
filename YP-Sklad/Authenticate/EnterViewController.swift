//
//  EnterViewController.swift
//  YP-Sklad
//
//  Created by Марат Хасанов on 10.06.2024.
//

import UIKit
import FirebaseAuth

class EnterViewController: UIViewController {
    
    private lazy var backgroundImage: UIImageView = {
       let image = UIImage(named: "BackgroundImage")
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleToFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var logoImage: UIImageView = {
       let image = UIImage(named: "018-pin")
        let imageView = UIImageView(image: image)
        imageView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 150).isActive = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var backgroundView: UIView = {
       let view = UIView()
        view.backgroundColor = .white
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.masksToBounds = false
        view.layer.cornerRadius = 16
        // Настройка тени
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.5
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowRadius = 4
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var titleLogin: UILabel = {
       let label = UILabel()
        label.text = "LOGIN"
        label.textColor = UIColor.kUltraDarkBlue
        label.font = .systemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var emailLabel: UILabel = {
        let label = UILabel()
        label.text = "EMAIL"
        label.font = .systemFont(ofSize: 10, weight: .bold)
        label.textColor = .kDarkBlue
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var emailTextField: UITextField = {
        let email = UITextField()
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.kBlueShadow
        ]
        email.attributedPlaceholder = NSAttributedString(string: "Адрес электронной почты", attributes: attributes)
        email.backgroundColor = .kBlueShadow
        email.layer.cornerRadius = 8
        email.delegate = self
        email.heightAnchor.constraint(equalToConstant: 50).isActive = true
        let leftPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: email.frame.height))
        email.leftView = leftPaddingView
        email.leftViewMode = .always
        email.textColor = .kUltraDarkBlue
        email.translatesAutoresizingMaskIntoConstraints = false
        return email
    }()
    
    private lazy var passwordLabel: UILabel = {
        let label = UILabel()
        label.text = "PASSWORD"
        label.font = .systemFont(ofSize: 10, weight: .bold)
        label.textColor = .kDarkBlue
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var passwordTextField: UITextField = {
        let password = UITextField()
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.kBlueShadow
        ]
        password.attributedPlaceholder = NSAttributedString(string: "Пароль", attributes: attributes)
        password.backgroundColor = .kBlueShadow
        password.layer.cornerRadius = 8
        password.delegate = self
        password.heightAnchor.constraint(equalToConstant: 50).isActive = true
        password.textColor = .kUltraDarkBlue
        password.translatesAutoresizingMaskIntoConstraints = false
        
        let leftPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: password.frame.height))
        password.leftView = leftPaddingView
        password.leftViewMode = .always
        password.translatesAutoresizingMaskIntoConstraints = false
        return password
    }()
    
    private lazy var enterButton: UIButton = {
       let button = UIButton()
        button.setTitle("ВОЙТИ", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        button.addTarget(self, action: #selector(enterButtonTapped), for: .touchUpInside)
        button.backgroundColor = .kDarkBlue
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.layer.cornerRadius = 5.0
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var stackView: UIStackView = {
       let stack = UIStackView(arrangedSubviews: [emailLabel, emailTextField, passwordLabel, passwordTextField])
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var errorButton: UIButton = {
        let button = UIButton()
        button.setTitle("ЗАБЫЛИ ПАРОЛЬ?", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 10, weight: .bold)
        button.setTitleColor(.kDarkBlue, for: .normal)
        button.addTarget(self, action: #selector(errorButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    // Метод для скрытия клавиатуры при нажатии на экран
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc
    private func enterButtonTapped() {
        if let email = emailTextField.text, let password = passwordTextField.text {
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                if let e = error {
                    self.logoImage.image = UIImage(named: "016-monitor")
                    return
                } else {
                    self.logoImage.image = UIImage(named: "007-thumbs up")
                    DispatchQueue.main.async {
                        sleep(2)
                        let vc = TabBarViewController()
                        vc.modalPresentationStyle = .fullScreen
                        self.present(vc, animated: true)
                    }
                }
            }
        }
    }
    
    @objc
    private func errorButtonTapped() {
        print("Забыли пароль")
    }
    
    private func setupUI() {
        view.addSubview(backgroundImage)
        view.addSubview(logoImage)
        view.addSubview(backgroundView)
        backgroundView.addSubview(titleLogin)
        backgroundView.addSubview(stackView)
        view.addSubview(enterButton)
        view.addSubview(errorButton)
        
        NSLayoutConstraint.activate([
            backgroundImage.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImage.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5),
            
            logoImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
            
            backgroundView.topAnchor.constraint(equalTo: logoImage.bottomAnchor, constant: 50),
            backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            backgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            backgroundView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -100),
            
            titleLogin.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLogin.topAnchor.constraint(equalTo: backgroundView.topAnchor, constant: 10),
            
            stackView.topAnchor.constraint(equalTo: titleLogin.bottomAnchor, constant: 10),
            stackView.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor),
            stackView.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -20),
            stackView.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor, constant: -80),
            
            enterButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            enterButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            enterButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -115),
            
            errorButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            errorButton.topAnchor.constraint(equalTo: enterButton.bottomAnchor, constant: 10)
        ])
    }
}

extension EnterViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
