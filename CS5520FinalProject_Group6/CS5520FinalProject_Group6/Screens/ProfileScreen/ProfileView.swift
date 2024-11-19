import UIKit

class ProfileView: UIView {

    // UI Elements
    let profileImageView = UIImageView()
    let nameTextField = UITextField()
    let emailTextField = UITextField()
    let editButton = UIButton()
    let saveChangesButton = UIButton()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        backgroundColor = .white

        // Configure Profile Image View
        profileImageView.image = UIImage(systemName: "person.circle.fill")
        profileImageView.contentMode = .scaleAspectFill
        profileImageView.clipsToBounds = true
        profileImageView.layer.cornerRadius = 50
        profileImageView.layer.borderWidth = 1
        profileImageView.layer.borderColor = UIColor.lightGray.cgColor
        profileImageView.translatesAutoresizingMaskIntoConstraints = false

        // Configure Name TextField
        nameTextField.borderStyle = .roundedRect
        nameTextField.font = UIFont.systemFont(ofSize: 16)
        nameTextField.placeholder = "Enter your name"
        nameTextField.translatesAutoresizingMaskIntoConstraints = false

        // Configure Email TextField
        emailTextField.borderStyle = .roundedRect
        emailTextField.font = UIFont.systemFont(ofSize: 16)
        emailTextField.placeholder = "Enter your email"
        emailTextField.translatesAutoresizingMaskIntoConstraints = false

        // Configure Edit Button
        editButton.setTitle("Edit Profile", for: .normal)
        editButton.backgroundColor = .darkGray
        editButton.setTitleColor(.white, for: .normal)
        editButton.layer.cornerRadius = 5
        editButton.translatesAutoresizingMaskIntoConstraints = false

        // Configure Save Changes Button
        saveChangesButton.setTitle("Save Changes", for: .normal)
        saveChangesButton.backgroundColor = .darkGray
        saveChangesButton.setTitleColor(.white, for: .normal)
        saveChangesButton.layer.cornerRadius = 5
        saveChangesButton.translatesAutoresizingMaskIntoConstraints = false
        saveChangesButton.isHidden = true // Initially hidden

        // Add Subviews
        addSubview(profileImageView)
        addSubview(nameTextField)
        addSubview(emailTextField)
        addSubview(editButton)
        addSubview(saveChangesButton)

        // Layout Constraints
        NSLayoutConstraint.activate([
            // Profile Image View
            profileImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            profileImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            profileImageView.widthAnchor.constraint(equalToConstant: 100),
            profileImageView.heightAnchor.constraint(equalToConstant: 100),

            // Name TextField
            nameTextField.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 20),
            nameTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            nameTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),

            // Email TextField
            emailTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 20),
            emailTextField.leadingAnchor.constraint(equalTo: nameTextField.leadingAnchor),
            emailTextField.trailingAnchor.constraint(equalTo: nameTextField.trailingAnchor),

            // Edit Button
            editButton.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 30),
            editButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            editButton.widthAnchor.constraint(equalToConstant: 150),
            editButton.heightAnchor.constraint(equalToConstant: 40),

            // Save Changes Button
            saveChangesButton.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 30),
            saveChangesButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            saveChangesButton.widthAnchor.constraint(equalToConstant: 150),
            saveChangesButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}

