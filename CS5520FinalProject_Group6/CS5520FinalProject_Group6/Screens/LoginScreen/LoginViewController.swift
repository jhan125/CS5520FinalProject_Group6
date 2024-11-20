//
//  LoginViewController.swift
//
//  Created by NIKITA LIANG on 11/4/24.
// 
//  Modified by JIALI HAN on 11/19/24.
//  Set UI Color to match the layout design.

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {

    private let loginView = LoginView()

    override func loadView() {
        view = loginView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "PrimaryColor")
        title = "Log In"
        setupActions()
    }
    
    @objc private func registerTapped() {
//        let registerVC = RegisterViewController()
//        navigationController?.pushViewController(registerVC, animated: true)
        let registerVC = RegisterViewController()
        let navController = UINavigationController(rootViewController: registerVC)
        present(navController, animated: true, completion: nil)
    }


    private func setupActions() {
        // Set up button actions
        loginView.loginButton.addTarget(self, action: #selector(loginTapped), for: .touchUpInside)
        loginView.registerLinkButton.addTarget(self, action: #selector(registerTapped), for: .touchUpInside)
    }
    
//   previous code
//    @objc private func loginTapped() {
//        guard let email = loginView.usernameTextField.text, !email.isEmpty,
//              let password = loginView.passwordTextField.text, !password.isEmpty else {
//            showAlert("Please enter both email and password.")
//            return
//        }
//
//        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
//            guard let self = self else { return }
//            if let error = error {
//                self.showAlert("Login failed: \(error.localizedDescription)")
//                return
//            }
//
//            // Get username or email for personalization
//            let username = email.components(separatedBy: "@").first ?? "User"
//
//            // Navigate to Home screen
//            let homeVC = HomeViewController()
//            homeVC.username = username
//            self.navigationController?.pushViewController(homeVC, animated: true)
//        }
//    }
    
    
    // After a successful login, replace the root view controller with MainTabBarController.
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

            // Create the MainTabBarController
            let mainTabBarController = MainTabBarController()

            // Set username for the profile view
            if let username = email.components(separatedBy: "@").first {
                if let profileVC = (mainTabBarController.viewControllers?.first as? UINavigationController)?.viewControllers.first as? ProfileViewController {
                    profileVC.username = username
                }
            }

//            // Get the current scene and set the root view controller
//            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
//               let window = windowScene.windows.first {
//                UIView.transition(with: window, duration: 0.5, options: .transitionFlipFromRight, animations: {
//                    window.rootViewController = mainTabBarController
//                }, completion: nil)
//            }
            
            
            // Safely update the rootViewController
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
               let window = windowScene.windows.first {
                window.rootViewController = mainTabBarController
                window.makeKeyAndVisible()
            }
        }
    }

    private func showAlert(_ message: String) {
        let alert = UIAlertController(title: "Notice", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}

