//
//  AuthenticateViewController.swift
//  YP-Sklad
//
//  Created by Марат Хасанов on 10.06.2024.
//

import UIKit
import FirebaseAuth

class RegisterViewController: UIViewController {
    
    private lazy var emailTextField: UITextField = {
        let email = UITextField()
        email.placeholder = "Адрес электронной почты"
        email.layer.borderWidth = 1.0
        email.layer.borderColor = UIColor.systemGray.cgColor
        email.layer.cornerRadius = 5.0
        email.delegate = self
        email.heightAnchor.constraint(equalToConstant: 50).isActive = true
        email.translatesAutoresizingMaskIntoConstraints = false
        return email
    }()
    
    private lazy var passwordTextField: UITextField = {
        let password = UITextField()
        password.placeholder = "Пароль"
        password.layer.borderWidth = 1.0
        password.layer.borderColor = UIColor.systemGray.cgColor
        password.layer.cornerRadius = 5.0
        password.delegate = self
        password.heightAnchor.constraint(equalToConstant: 50).isActive = true
        password.translatesAutoresizingMaskIntoConstraints = false
        return password
    }()
    
    private lazy var enterButton: UIButton = {
       let button = UIButton()
        button.setTitle("Зарегистрироваться", for: .normal)
        button.addTarget(self, action: #selector(enterButtonTapped), for: .touchUpInside)
        button.backgroundColor = .blue
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.layer.cornerRadius = 5.0
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var stackView: UIStackView = {
       let stack = UIStackView(arrangedSubviews: [emailTextField, passwordTextField, enterButton])
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fillEqually
        stack.spacing = 10
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
    }
    
    @objc
    private func enterButtonTapped() {
        if let email = emailTextField.text, let password = passwordTextField.text {
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let e = error {
                    print(e.localizedDescription)
                    return
                } else {
                    let vc = TabBarViewController()
                    vc.modalPresentationStyle = .fullScreen
                    self.present(vc, animated: true)
                }
            }
        }
    }
    
    private func setupUI() {
        view.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50)
        ])
    }
}

extension RegisterViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // Получаем текущий текст
        if let currentText = textField.text, let textRange = Range(range, in: currentText) {
            let updatedText = currentText.replacingCharacters(in: textRange, with: string)
            print(updatedText)
        }
        return true
    }
}
