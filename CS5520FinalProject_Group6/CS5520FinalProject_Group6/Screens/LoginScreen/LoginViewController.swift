//
//  LoginViewController.swift
//
//  Created by NIKITA LIANG on 11/4/24.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {

    private let loginView = LoginView()

    override func loadView() {
        view = loginView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Log In"
        setupActions()
    }

    private func setupActions() {
        // Set up button actions
        loginView.loginButton.addTarget(self, action: #selector(loginTapped), for: .touchUpInside)
        loginView.registerLinkButton.addTarget(self, action: #selector(registerTapped), for: .touchUpInside)
    }

    @objc private func loginTapped() {
        guard let email = loginView.usernameTextField.text, !email.isEmpty,
              let password = loginView.passwordTextField.text, !password.isEmpty else {
            showAlert("Please enter both email and password.")
            return
        }

        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            guard let self = self else { return }
            if let error = error {
                self.showAlert("Login failed: \(error.localizedDescription)")
                return
            }

            // Get username or email for personalization
            let username = email.components(separatedBy: "@").first ?? "User"

            // Navigate to Home screen
            let homeVC = HomeViewController()
            homeVC.username = username
            self.navigationController?.pushViewController(homeVC, animated: true)
        }
    }

    @objc private func registerTapped() {
        // Navigate to the Register screen
        let registerVC = RegisterViewController()
        navigationController?.pushViewController(registerVC, animated: true)
    }

    private func showAlert(_ message: String) {
        let alert = UIAlertController(title: "Notice", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}

