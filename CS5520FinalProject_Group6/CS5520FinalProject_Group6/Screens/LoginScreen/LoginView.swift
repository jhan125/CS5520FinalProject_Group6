//
//  LoginView.swift
//  Modified by Jiali Han on 11/19/24.
//  
//  Set UI Color to match the layout design.
//

import UIKit

class LoginView: UIView {
    
    // UI Elements
    let welcomeLabel = UILabel()
    let registerPromptStack = UIStackView()
    let registerPromptLabel = UILabel()
    let registerLinkButton = UIButton()
    let usernameTextField = UITextField()
    let passwordTextField = UITextField()
    let loginButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = .white
        
        // Configure welcome label
        welcomeLabel.text = "FeelFree"
        welcomeLabel.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        welcomeLabel.textColor = .black
        welcomeLabel.textAlignment = .center
        
        // Configure register prompt label
        registerPromptLabel.text = "Don't have an account?"
        registerPromptLabel.font = UIFont.systemFont(ofSize: 20)
        registerPromptLabel.textColor = .black
        
        // Configure register link button
        registerLinkButton.setTitle("Register now!", for: .normal)
        registerLinkButton.setTitleColor(.systemBlue, for: .normal)
        registerLinkButton.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        registerLinkButton.contentHorizontalAlignment = .left

        // Create register prompt stack
        registerPromptStack.axis = .horizontal
        registerPromptStack.alignment = .center
        registerPromptStack.spacing = 5
        registerPromptStack.addArrangedSubview(registerPromptLabel)
        registerPromptStack.addArrangedSubview(registerLinkButton)
        
        // Configure username text field
        usernameTextField.placeholder = "Email"
        usernameTextField.borderStyle = .roundedRect
        usernameTextField.font = UIFont.systemFont(ofSize: 16)
        usernameTextField.autocapitalizationType = .none
        
        // Configure password text field
        passwordTextField.placeholder = "Password"
        passwordTextField.borderStyle = .roundedRect
        passwordTextField.font = UIFont.systemFont(ofSize: 16)
        passwordTextField.isSecureTextEntry = true
        
        // Configure login button
        loginButton.setTitle("Log in", for: .normal)
//        loginButton.backgroundColor = .darkGray
        loginButton.backgroundColor = UIColor(named: "DarkColor")
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.layer.cornerRadius = 5
        loginButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        
        // Add views
        addSubview(welcomeLabel)
        addSubview(registerPromptStack)
        addSubview(usernameTextField)
        addSubview(passwordTextField)
        addSubview(loginButton)
        
        // Layout constraints
        welcomeLabel.translatesAutoresizingMaskIntoConstraints = false
        registerPromptStack.translatesAutoresizingMaskIntoConstraints = false
        usernameTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            // Welcome label
            welcomeLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 40),
            welcomeLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            // Register prompt stack
            registerPromptStack.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 20),
            registerPromptStack.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            // Username text field
            usernameTextField.topAnchor.constraint(equalTo: registerPromptStack.bottomAnchor, constant: 30),
            usernameTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            usernameTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
            usernameTextField.heightAnchor.constraint(equalToConstant: 40),
            
            // Password text field
            passwordTextField.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor, constant: 15),
            passwordTextField.leadingAnchor.constraint(equalTo: usernameTextField.leadingAnchor),
            passwordTextField.trailingAnchor.constraint(equalTo: usernameTextField.trailingAnchor),
            passwordTextField.heightAnchor.constraint(equalTo: usernameTextField.heightAnchor),
            
            // Login button
            loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 30),
            loginButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            loginButton.widthAnchor.constraint(equalToConstant: 120),
            loginButton.heightAnchor.constraint(equalToConstant: 40),
            
        ])
    }
}

