//
//  WelcomeViewController.swift
//  YP-Sklad
//
//  Created by Марат Хасанов on 10.06.2024.
//

import UIKit
import FirebaseMe

class WelcomeViewController: UIViewController {
    
    private lazy var backgroundImage: UIImageView = {
       let image = UIImage(named: "BackgroundImage")
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var logoImage: UIImageView = {
       let image = UIImage(named: "008-rocket launch")
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
    
    private lazy var titleLabel: UILabel = {
       let title = UILabel()
        title.text = "👷🏻Мой Склад👷🏻"
        title.textColor = .kUltraDarkBlue
        title.textAlignment = .center
        title.numberOfLines = 0
        title.font = .systemFont(ofSize: 40, weight: .bold)
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    
    private lazy var registerButton: UIButton = {
        let button = UIButton()
        button.setTitle("Регистрация", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        button.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
        button.backgroundColor = .kDarkBlue
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.layer.cornerRadius = 10.0
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var enterButton: UIButton = {
        let button = UIButton()
        button.setTitle("Вход", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        button.addTarget(self, action: #selector(enterButtonTapped), for: .touchUpInside)
        button.backgroundColor = .kDarkBlue
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.layer.cornerRadius = 10.0
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        animatedLogo()
    }
    
    private func animatedLogo() {
        titleLabel.text = ""
        var stageIndex = 0.0
        let titleText = "👷🏻Мой Склад👷🏻"
        titleText.forEach { char in
            Timer.scheduledTimer(withTimeInterval: 0.20 * stageIndex, repeats: false) { _ in
                self.titleLabel.text?.append(char)
            }
            stageIndex += 1
        }
    }
    
    private func setupUI() {
        view.addSubview(backgroundImage)
        view.addSubview(logoImage)
        view.addSubview(backgroundView)
        backgroundView.addSubview(titleLabel)
        backgroundView.addSubview(registerButton)
        backgroundView.addSubview(enterButton)
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
            backgroundView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -140),
            
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: backgroundView.topAnchor, constant: 20),
        
            registerButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 40),
            registerButton.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 16),
            registerButton.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -16),
            
            enterButton.topAnchor.constraint(equalTo: registerButton.bottomAnchor, constant: 15),
            enterButton.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 16),
            enterButton.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -16)])
    }
    
    @objc
    private func registerButtonTapped() {
        let vc = UINavigationController(rootViewController: RegisterViewController())
        present(vc, animated: true)
    }
    
    @objc
    private func enterButtonTapped() {
        let vc = UINavigationController(rootViewController: EnterViewController())
        present(vc, animated: true)
    }
}
