import UIKit

class HomeView: UIView {

    let welcomeLabel = UILabel()
    let infoLabel = UILabel() // Info label for the additional text
    let profileButton = UIButton(type: .system) // Add profile button
    let logoutButton = UIButton(type: .system) // Add logout button
    let startTestsButton = UIButton(type: .system) // Start tests button

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        backgroundColor = .white

        // Configure Welcome Label
        welcomeLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        welcomeLabel.textAlignment = .center
        welcomeLabel.translatesAutoresizingMaskIntoConstraints = false

        // Configure Info Label with paragraph styling
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 8 // Add line spacing between each sentence
        paragraphStyle.alignment = .center

        let infoText = """
        Please note, the mental health tests are not a substitute for a professional diagnosis.
        
        Take a deep breath, and feel free to choose the answers that best suit your situation 💚
        """

        let attributedString = NSAttributedString(
            string: infoText,
            attributes: [
                .font: UIFont.systemFont(ofSize: 16, weight: .medium),
                .foregroundColor: UIColor.darkGray,
                .paragraphStyle: paragraphStyle
            ]
        )
        infoLabel.attributedText = attributedString
        infoLabel.numberOfLines = 0
        infoLabel.translatesAutoresizingMaskIntoConstraints = false

        // Configure Profile Button
        profileButton.setTitle("Profile", for: .normal)
        profileButton.translatesAutoresizingMaskIntoConstraints = false

        // Configure Logout Button
        logoutButton.setTitle("Logout", for: .normal)
        logoutButton.translatesAutoresizingMaskIntoConstraints = false

        // Configure Start Tests Button
        startTestsButton.setTitle("Choose a Test", for: .normal)
        startTestsButton.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        startTestsButton.backgroundColor = UIColor(named: "DarkColor")
        startTestsButton.setTitleColor(.white, for: .normal)
        startTestsButton.layer.cornerRadius = 8
        startTestsButton.translatesAutoresizingMaskIntoConstraints = false

        // Add subviews
        addSubview(profileButton)
        addSubview(logoutButton)
        addSubview(welcomeLabel)
        addSubview(infoLabel)
        addSubview(startTestsButton)

        // Layout Constraints
        NSLayoutConstraint.activate([
            // Profile Button
            profileButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 5),
            profileButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),

            // Logout Button
            logoutButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 5),
            logoutButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),

            // Welcome Label
            welcomeLabel.topAnchor.constraint(equalTo: profileButton.bottomAnchor, constant: 20),
            welcomeLabel.centerXAnchor.constraint(equalTo: centerXAnchor),

            // Info Label (centered vertically)
            infoLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            infoLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            infoLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),

            // Start Tests Button (near bottom)
            startTestsButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -40),
            startTestsButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            startTestsButton.widthAnchor.constraint(equalToConstant: 200),
            startTestsButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}
