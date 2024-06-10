//
//  OnboardingFirstScreenViewController.swift
//  YP-Sklad
//
//  Created by Марат Хасанов on 10.06.2024.
//

import UIKit

class OnboardingFirstScreenViewController: UIViewController {
    
    private lazy var goToApp: UIButton = {
       let button = UIButton()
        button.backgroundColor = .white
        button.heightAnchor.constraint(equalToConstant: 90).isActive = true
        button.widthAnchor.constraint(equalToConstant: 180).isActive = true
        button.addTarget(self, action: #selector(goToAppButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
        setupUI()
    }
    
    private func setupUI() {
        view.addSubview(goToApp)
        
        NSLayoutConstraint.activate([
            goToApp.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            goToApp.centerYAnchor.constraint(equalTo: view.centerYAnchor)])
    }
    
    @objc
    private func goToAppButtonTapped() {
        //сохраняем значение заходили ли мы в Onboarding
        let userDefaults = UserDefaults.standard
        userDefaults.set(1, forKey: "onboardingView")
        
        let nextViewController = TabBarViewController()
        nextViewController.modalPresentationStyle = .fullScreen
        present(nextViewController, animated: true)
    }
}
