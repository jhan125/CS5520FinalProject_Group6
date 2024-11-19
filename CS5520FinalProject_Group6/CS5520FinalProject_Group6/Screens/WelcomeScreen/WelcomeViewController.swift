//
//  HomeViewController.swift
//

import UIKit

class WelcomeViewController: UIViewController {

    private let welcomeView = WelcomeView()
    
    override func loadView() {
        view = welcomeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupActions()
    }
    
    private func setupActions() {
        welcomeView.loginButton.addTarget(self, action: #selector(goToLogin), for: .touchUpInside)
        welcomeView.signupButton.addTarget(self, action: #selector(goToSignUp), for: .touchUpInside)
    }
    
    @objc private func goToLogin() {
        let loginVC = LoginViewController()
        navigationController?.pushViewController(loginVC, animated: true)
    }
    
    @objc private func goToSignUp() {
        let registerVC = RegisterViewController()
        navigationController?.pushViewController(registerVC, animated: true)
    }
}

