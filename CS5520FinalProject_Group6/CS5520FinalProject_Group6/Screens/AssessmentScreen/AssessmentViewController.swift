import UIKit

class AssessmentViewController: UIViewController {

    var testName: String = "Quiz"
    var questions: [String] = [] // Stores all questions for the selected quiz
    private var currentQuestionIndex = 0 // Tracks the current question
    private var answers: [String] = [] // Stores user-selected answers
    private var selectedButton: UIButton? // Tracks the currently selected button

    // UI Elements
    private let titleLabel = UILabel()
    private let questionLabel = UILabel()
    private let optionsStackView = UIStackView()
    private let nextButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        loadQuestion()
    }

    private func setupUI() {
        // Title Label
        titleLabel.text = testName
        titleLabel.font = UIFont.boldSystemFont(ofSize: 24)
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleLabel)

        // Question Label
        questionLabel.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        questionLabel.numberOfLines = 0
        questionLabel.textAlignment = .center
        questionLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(questionLabel)

        // Options Stack View
        optionsStackView.axis = .vertical
        optionsStackView.spacing = 15
        optionsStackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(optionsStackView)

        // Add Option Buttons
        ["Strongly Agree", "Agree", "Neutral", "Disagree", "Strongly Disagree"].forEach { option in
            let button = UIButton(type: .system)
            button.setTitle(option, for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
            button.backgroundColor = .lightGray
            button.setTitleColor(.white, for: .normal)
            button.layer.cornerRadius = 8
            button.addTarget(self, action: #selector(optionTapped(_:)), for: .touchUpInside)
            optionsStackView.addArrangedSubview(button)
        }

        // Next Button
        nextButton.setTitle("Next Question", for: .normal)
        nextButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        nextButton.backgroundColor = .red
        nextButton.setTitleColor(.white, for: .normal)
        nextButton.layer.cornerRadius = 8
        nextButton.addTarget(self, action: #selector(nextQuestion), for: .touchUpInside)
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(nextButton)

        // Layout Constraints
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            questionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            questionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            questionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            optionsStackView.topAnchor.constraint(equalTo: questionLabel.bottomAnchor, constant: 20),
            optionsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            optionsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),

            nextButton.topAnchor.constraint(equalTo: optionsStackView.bottomAnchor, constant: 20),
            nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nextButton.widthAnchor.constraint(equalToConstant: 200),
            nextButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    private func loadQuestion() {
        guard currentQuestionIndex < questions.count else {
            showResults()
            return
        }

        questionLabel.text = "Question \(currentQuestionIndex + 1)/\(questions.count):\n\(questions[currentQuestionIndex])"
        
        // Reset selected button state
        selectedButton?.backgroundColor = .lightGray
        selectedButton = nil
    }

    @objc private func optionTapped(_ sender: UIButton) {
        guard let selectedOption = sender.titleLabel?.text else { return }

        // Highlight the selected button
        selectedButton?.backgroundColor = .lightGray // Reset previously selected button
        sender.backgroundColor = .blue // Highlight new selection
        selectedButton = sender // Update the current selected button

        // Save or update the selected answer
        if answers.count > currentQuestionIndex {
            answers[currentQuestionIndex] = selectedOption
        } else {
            answers.append(selectedOption)
        }
    }

    @objc private func nextQuestion() {
        // Ensure an answer is selected before proceeding
        guard answers.count > currentQuestionIndex else {
            showAlert("Please select an answer before proceeding.")
            return
        }

        currentQuestionIndex += 1
        loadQuestion()
    }

    private func showResults() {
        // Show results when all questions are answered
        let alert = UIAlertController(
            title: "Quiz Completed",
            message: "You completed the quiz! Answers saved.",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
            self.navigationController?.popViewController(animated: true)
        })
        present(alert, animated: true)
    }

    private func showAlert(_ message: String) {
        let alert = UIAlertController(title: "Notice", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
