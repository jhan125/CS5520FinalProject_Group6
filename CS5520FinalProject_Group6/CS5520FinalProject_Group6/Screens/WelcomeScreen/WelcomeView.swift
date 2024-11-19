//
//  HomeView.swift
//
//  Created by NIKITA LIANG on 11/4/24.
//
import UIKit

class WelcomeView: UIView {
    
    // UI Elements
    let logoImageView = UIImageView()
    let welcomeLabel = UILabel()
    let loginButton = UIButton()
    let signupButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = .white
        
        // Configure logo image
        logoImageView.image = UIImage(named: "MindYourMind") // Ensure the image is added to assets
        logoImageView.contentMode = .scaleAspectFit
        
        // Configure welcome label
        welcomeLabel.text = "Welcome to FeelFree"
        welcomeLabel.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        welcomeLabel.textColor = .black
        welcomeLabel.textAlignment = .center
        
        // Configure login button
        loginButton.setTitle("Log In", for: .normal)
        loginButton.backgroundColor = .darkGray
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.layer.cornerRadius = 5
        loginButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        
        // Configure signup button
        signupButton.setTitle("Sign Up", for: .normal)
        signupButton.backgroundColor = .darkGray
        signupButton.setTitleColor(.white, for: .normal)
        signupButton.layer.cornerRadius = 5
        signupButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        
        // Add views
        addSubview(logoImageView)
        addSubview(welcomeLabel)
        addSubview(loginButton)
        addSubview(signupButton)
        
        // Layout constraints
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        welcomeLabel.translatesAutoresizingMaskIntoConstraints = false
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        signupButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            // Logo ImageView
            logoImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            logoImageView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -100),
            logoImageView.widthAnchor.constraint(equalToConstant: 200), // Adjusted width
            logoImageView.heightAnchor.constraint(equalToConstant: 200), // Adjusted height
            
            // Welcome Label
            welcomeLabel.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 20),
            welcomeLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            // Login Button
            loginButton.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 30),
            loginButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            loginButton.widthAnchor.constraint(equalToConstant: 120),
            loginButton.heightAnchor.constraint(equalToConstant: 40),
            
            // Sign Up Button
            signupButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 15),
            signupButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            signupButton.widthAnchor.constraint(equalToConstant: 120),
            signupButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}

