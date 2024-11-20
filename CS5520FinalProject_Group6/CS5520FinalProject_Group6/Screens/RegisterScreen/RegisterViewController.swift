//
//  RegisterViewController.swift
//
//  Created by Zhiqian Zhang on 11/17/24.
// 
//  Created by Jiali Han on 11/19/24.
//  Set UI Color to match the layout design.

import UIKit
import FirebaseAuth
import FirebaseFirestore

class RegisterViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    private let registerView = RegisterView()
    private let imageView = UIImageView()

    override func loadView() {
        view = registerView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Sign Up"
        view.backgroundColor = UIColor(named: "PrimaryColor")

        setupNavigationBar()
        setupImageView()
        setupButtonActions()
        disableAutofillForPasswordFields() // Disable autofill for password fields
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    private func setupNavigationBar() {
        // Set title for the navigation bar
        title = "Sign Up"

        // Add a back button
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            title: "Back",
            style: .plain,
            target: self,
            action: #selector(backTapped)
        )
    }

    @objc private func backTapped() {
        // Pop the view controller to navigate back
        navigationController?.popViewController(animated: true)
    }

    private func setupImageView() {
        // Configure the image view for profile picture
        imageView.image = UIImage(systemName: "person.circle.fill")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 50
        imageView.layer.borderColor = UIColor.lightGray.cgColor
        imageView.layer.borderWidth = 1
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: registerView.welcomeLabel.bottomAnchor, constant: 20),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 100),
            imageView.heightAnchor.constraint(equalToConstant: 100)
        ])
    }

    private func setupButtonActions() {
        // Add gesture recognizer to the image view to let the user pick an image
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(selectImage))
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(tapGesture)

        // Set up the sign-up button action
        registerView.signupButton.addTarget(self, action: #selector(signUpTapped), for: .touchUpInside)
    }

    private func disableAutofillForPasswordFields() {
        registerView.passwordTextField.textContentType = .oneTimeCode
        registerView.confirmPasswordTextField.textContentType = .oneTimeCode
    }

    @objc private func selectImage() {
        let alert = UIAlertController(title: "Select Photo", message: "Choose an option", preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Take Photo", style: .default, handler: { _ in
            self.openCamera()
        }))
        
        alert.addAction(UIAlertAction(title: "Choose from Album", style: .default, handler: { _ in
            self.openPhotoLibrary()
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(alert, animated: true, completion: nil)
    }

    private func openCamera() {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let picker = UIImagePickerController()
            picker.delegate = self
            picker.sourceType = .camera
            picker.allowsEditing = true
            present(picker, animated: true, completion: nil)
        } else {
            showAlert("Camera is not available.")
        }
    }

    private func openPhotoLibrary() {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let picker = UIImagePickerController()
            picker.delegate = self
            picker.sourceType = .photoLibrary
            picker.allowsEditing = true
            present(picker, animated: true, completion: nil)
        } else {
            showAlert("Photo Library is not available.")
        }
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let editedImage = info[.editedImage] as? UIImage {
            imageView.image = editedImage
        } else if let originalImage = info[.originalImage] as? UIImage {
            imageView.image = originalImage
        }
        dismiss(animated: true, completion: nil)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }

    @objc private func signUpTapped() {
        guard let username = registerView.usernameTextField.text, !username.isEmpty,
              let email = registerView.emailTextField.text, !email.isEmpty,
              let password = registerView.passwordTextField.text, !password.isEmpty,
              let confirmPassword = registerView.confirmPasswordTextField.text, !confirmPassword.isEmpty else {
            showAlert("Please fill in all fields, including a profile picture.")
            return
        }
        
        guard isValidEmail(email) else {
            showAlert("Please enter a valid email address.")
            return
        }

        guard imageView.image != UIImage(systemName: "person.circle.fill") else {
            showAlert("Please upload a profile picture.")
            return
        }

        guard password == confirmPassword else {
            showAlert("Passwords do not match.")
            return
        }

        // Firebase registration
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] authResult, error in
            guard let self = self else { return }
            if let error = error {
                self.showAlert("Registration failed: \(error.localizedDescription)")
                return
            }

            // Save additional user data to Firestore
            guard let userID = authResult?.user.uid else { return }
            self.saveUserDataToFirestore(userID: userID, username: username, email: email, profileImage: self.imageView.image)
        }
    }

    private func saveUserDataToFirestore(userID: String, username: String, email: String, profileImage: UIImage?) {
        let db = Firestore.firestore()
        
        // Save the image as Data (Optional)
        let imageData = profileImage?.jpegData(compressionQuality: 0.8)
        let base64String = imageData?.base64EncodedString() ?? "" // Convert image to Base64 string
        
        // Save user data
        db.collection("users").document(userID).setData([
            "username": username,
            "email": email,
            "profileImage": base64String,
            "created_at": Timestamp()
        ]) { error in
            if let error = error {
                self.showAlert("Failed to save user data: \(error.localizedDescription)")
            } else {
                self.showAlertWithAction(
                    title: "Registration Successful!",
                    message: "Your account has been created successfully. You can now log in.",
                    actionTitle: "Go to Login"
                ) {
                    self.navigationController?.popViewController(animated: true) // Navigate back to Login screen
                }
            }
        }
    }

    private func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: email)
    }

    private func showAlert(_ message: String, completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: "Notice", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            completion?()
        }))
        present(alert, animated: true)
    }

    private func showAlertWithAction(title: String, message: String, actionTitle: String, action: @escaping () -> Void) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: actionTitle, style: .default, handler: { _ in
            action()
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alert, animated: true)
    }
}
