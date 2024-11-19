import UIKit
import FirebaseAuth
import FirebaseFirestore

class ProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    private let profileView = ProfileView()
    var username: String?
    var onProfileUpdate: ((String) -> Void)? // Closure to update username in HomeViewController

    override func loadView() {
        view = profileView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Profile"
        setupUI()
        setupActions()
        loadUserProfileData()
    }

    private func setupUI() {
        // Hide edit button and only show Save Changes
        profileView.editButton.isHidden = true
        profileView.saveChangesButton.isHidden = false
        
        // Restrict email text field to be non-editable
        profileView.emailTextField.isUserInteractionEnabled = false
        profileView.emailTextField.alpha = 0.6  // Make it visually distinct as non-editable
        
        // Ensure the username field is editable
        profileView.nameTextField.isUserInteractionEnabled = true
    }

    private func setupActions() {
        profileView.saveChangesButton.addTarget(self, action: #selector(saveChangesTapped), for: .touchUpInside)

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(selectProfileImage))
        profileView.profileImageView.isUserInteractionEnabled = true
        profileView.profileImageView.addGestureRecognizer(tapGesture)
    }

    private func loadUserProfileData() {
        guard let userID = Auth.auth().currentUser?.uid else { return }
        let db = Firestore.firestore()

        db.collection("users").document(userID).getDocument { [weak self] (document, error) in
            if let document = document, document.exists {
                let data = document.data()
                self?.profileView.nameTextField.text = data?["username"] as? String
                self?.profileView.emailTextField.text = data?["email"] as? String

                if let base64String = data?["profileImage"] as? String,
                   let imageData = Data(base64Encoded: base64String) {
                    self?.profileView.profileImageView.image = UIImage(data: imageData)
                }
            }
        }
    }

    @objc private func saveChangesTapped() {
        guard let userID = Auth.auth().currentUser?.uid else { return }
        guard let newUsername = profileView.nameTextField.text, !newUsername.isEmpty else {
            showAlert("Username field must be filled.")
            return
        }

        let updatedProfileImage = profileView.profileImageView.image

        // Only update username and profile image (email remains unchanged)
        updateFirestoreData(userID: userID, username: newUsername, profileImage: updatedProfileImage)
    }

    private func updateFirestoreData(userID: String, username: String, profileImage: UIImage?) {
        let db = Firestore.firestore()
        let imageBase64 = profileImage?.jpegData(compressionQuality: 0.8)?.base64EncodedString() ?? ""

        db.collection("users").document(userID).setData([
            "username": username,
            "profileImage": imageBase64
        ], merge: true) { [weak self] error in
            if let error = error {
                self?.showAlert("Failed to save changes: \(error.localizedDescription)")
            } else {
                self?.onProfileUpdate?(username) // Update HomeViewController's username
                self?.showAlert("Changes saved successfully!") {
                    self?.navigationController?.popViewController(animated: true)
                }
            }
        }
    }

    @objc private func selectProfileImage() {
        let alert = UIAlertController(title: "Select Photo", message: "Choose an option", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Take Photo", style: .default) { _ in
            self.openCamera()
        })
        alert.addAction(UIAlertAction(title: "Choose from Library", style: .default) { _ in
            self.openPhotoLibrary()
        })
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(alert, animated: true)
    }

    private func openCamera() {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let picker = UIImagePickerController()
            picker.delegate = self
            picker.sourceType = .camera
            picker.allowsEditing = true
            present(picker, animated: true)
        }
    }

    private func openPhotoLibrary() {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let picker = UIImagePickerController()
            picker.delegate = self
            picker.sourceType = .photoLibrary
            picker.allowsEditing = true
            present(picker, animated: true)
        }
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        if let editedImage = info[.editedImage] as? UIImage {
            profileView.profileImageView.image = editedImage
        } else if let originalImage = info[.originalImage] as? UIImage {
            profileView.profileImageView.image = originalImage
        }
        dismiss(animated: true)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true)
    }

    private func showAlert(_ message: String, completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: "Notice", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            completion?()
        }))
        present(alert, animated: true)
    }
}
