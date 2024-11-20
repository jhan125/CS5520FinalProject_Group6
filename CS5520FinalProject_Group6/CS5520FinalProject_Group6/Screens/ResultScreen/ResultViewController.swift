// Created by Yanqiong Ma on 11/19/24.

import UIKit
import FirebaseAuth
import FirebaseFirestore

class ResultViewController: UIViewController {
    private let resultView = ResultView()

    var score: Int = 0
    var resultMessage: String = ""
    var testName: String = "" 


    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupView()
        bindData()
        setupActions()
        animateScore()
        setupCustomBackButton()
    }

    private func setupCustomBackButton() {
        let backButton = UIBarButtonItem(title: "Back",
                                         style: .plain,
                                         target: self,
                                         action: #selector(backToHomePage))
        backButton.image = UIImage(systemName: "chevron.left")
        backButton.tintColor = .blue
        navigationItem.leftBarButtonItem = backButton
    }

    @objc private func backToHomePage() {
        if let testSelectionVC = navigationController?.viewControllers.first(where: { $0 is TestSelectionViewController }) {
            navigationController?.popToViewController(testSelectionVC, animated: true)
        } else {
            navigationController?.popToRootViewController(animated: true)
        }
    }
    


    @objc private func showHistory() {
        let summaryVC = SummaryViewController()
        navigationController?.pushViewController(summaryVC, animated: true)
    }


    private func setupView() {
        view.addSubview(resultView)
        resultView.translatesAutoresizingMaskIntoConstraints = false
        resultView.historyButton.addTarget(self,
                                           action: #selector(showHistory),
                                           for: .touchUpInside)
        NSLayoutConstraint.activate([
            resultView.topAnchor.constraint(equalTo: view.topAnchor),
            resultView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            resultView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            resultView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    private func bindData() {
        resultView.scoreLabel.text = "\(score)%"
        resultView.descriptionLabel.text = resultMessage
        resultView.setScoreAndColor(score: score)

        switch score {
        case 40..<51:
            resultView.scoreLabel.textColor = .red
            resultView.descriptionLabel.textColor = .darkRed
        case 30..<40:
            resultView.scoreLabel.textColor = .orange
            resultView.descriptionLabel.textColor = .darkOrange
        case 20..<30:
            resultView.scoreLabel.textColor = .yellow
            resultView.descriptionLabel.textColor = .darkYellow
        case 10..<20:
            resultView.scoreLabel.textColor = .green
            resultView.descriptionLabel.textColor = .darkGreen
        default:
            resultView.scoreLabel.textColor = .gray
            resultView.descriptionLabel.textColor = .darkGray
        }
    }

    private func setupActions() {
        resultView.saveButton.addTarget(self, action: #selector(saveResult), for: .touchUpInside)
    }

    private func animateScore() {
        resultView.scoreLabel.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        resultView.scoreLabel.alpha = 0
        UIView.animate(withDuration: 1.0, delay: 0, options: .curveEaseOut) {
            self.resultView.scoreLabel.transform = CGAffineTransform.identity
            self.resultView.scoreLabel.alpha = 1
        }
    }

    @objc private func saveResult() {
        guard let userID = Auth.auth().currentUser?.uid else {
            showAlert("You must be logged in to save your results.")
            return
        }

        let db = Firestore.firestore()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let currentDate = Date()
        let formattedDate = dateFormatter.string(from: currentDate)
        let testResult: [String: Any] = [
            "userID": userID,
            "testName": testName,
            "score": score,
            "resultMessage": resultMessage,
            "date": formattedDate
        ]

        db.collection("tests").addDocument(data: testResult) { error in
            if let error = error {
                print("Failed to save test result: \(error.localizedDescription)")
                self.showAlert("Failed to save test result. Please try again.")
            } else {
                print("Test result saved successfully!")
                self.showAlert("Test result saved successfully!") {
                }
            }
        }
    }

}

extension UIViewController {
    func showAlert(_ message: String, title: String = "Notice", completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            completion?()
        }))
        self.present(alert, animated: true)
    }
}

extension UIColor {
    static let darkRed = UIColor(red: 0.7, green: 0.0, blue: 0.0, alpha: 1.0)
    static let darkOrange = UIColor(red: 0.8, green: 0.4, blue: 0.0, alpha: 1.0)
    static let darkYellow = UIColor(red: 0.7, green: 0.7, blue: 0.0, alpha: 1.0)
    static let darkGreen = UIColor(red: 0.0, green: 0.5, blue: 0.0, alpha: 1.0)
    static let darkGray = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1.0)
}
