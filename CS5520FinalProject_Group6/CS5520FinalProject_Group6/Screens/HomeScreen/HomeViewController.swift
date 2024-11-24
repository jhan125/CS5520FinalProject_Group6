import UIKit
import FirebaseAuth
import FirebaseFirestore

class HomeViewController: UIViewController {

    private let homeView = HomeView() // Use HomeView

    var username: String = "" {
        didSet {
            homeView.welcomeLabel.text = "Welcome to FeelFree, \(username)!"
        }
    }

    override func loadView() {
        view = homeView // Set HomeView as the main view
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "PrimaryColor")

        // Hide the back button
        navigationItem.hidesBackButton = true

        // Setup actions
        setupActions()

        // Fetch updated username from Firestore before setting welcome message
        loadUpdatedUsername()
    }

    private func setupActions() {
        homeView.profileButton.addTarget(self, action: #selector(profileTapped), for: .touchUpInside)
        homeView.logoutButton.addTarget(self, action: #selector(logoutTapped), for: .touchUpInside)
        homeView.startTestsButton.addTarget(self, action: #selector(openTestSelection), for: .touchUpInside)
    }

    private func loadUpdatedUsername() {
        guard let userID = Auth.auth().currentUser?.uid else { return }

        let db = Firestore.firestore()
        db.collection("users").document(userID).getDocument { [weak self] (document, error) in
            if let document = document, document.exists {
                let data = document.data()
                if let updatedUsername = data?["username"] as? String {
                    DispatchQueue.main.async {
                        self?.username = updatedUsername
                    }
                }
            }
        }
    }

    @objc private func profileTapped() {
        let profileVC = ProfileViewController()
        profileVC.username = username
        profileVC.onProfileUpdate = { [weak self] updatedUsername in
            self?.username = updatedUsername
        }
        navigationController?.pushViewController(profileVC, animated: true)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadUpdatedUsername()
    }

    @objc private func logoutTapped() {
        navigationController?.popToRootViewController(animated: true)
    }

    @objc private func openTestSelection() {
        let testSelectionVC = TestSelectionViewController()
        navigationController?.pushViewController(testSelectionVC, animated: true)
    }
}
