// Created by Zhiqian Zhang on 11/18/24.
// Modified by Yanqiong Ma on 11/19/24.
// Modified by Jiali Han on 11/19/24.

// Implemented rainbow colors to answer buttons and highlighted selected button
// when user selects the button for user experience.


import UIKit

class AssessmentViewController: UIViewController {
    
    var testName: String = "Quiz"
    var questions: [String] = [] // Stores all questions for the selected quiz
    private var currentQuestionIndex = 0 // Tracks the current question
    //private var answers: [String] = [] // Stores user-selected answers
    private var selectedButton: UIButton? // Tracks the currently selected button
    private var answers: [Int] = []
    
    // UI Elements
    private let titleLabel = UILabel()
    private let questionLabel = UILabel()
    private let optionsStackView = UIStackView()
    private let nextButton = UIButton()
    
    // Define colors for each option
    private let buttonColors: [UIColor] = [
        UIColor(red: 0.18, green: 0.8, blue: 0.44, alpha: 1.0), // Green for "Strongly Agree"
        UIColor(red: 0.5, green: 0.8, blue: 0.2, alpha: 1.0),  // Light green for "Agree"
        UIColor(red: 1.0, green: 0.84, blue: 0.0, alpha: 1.0), // Yellow for "Neutral"
        UIColor(red: 1.0, green: 0.6, blue: 0.0, alpha: 1.0),  // Orange for "Disagree"
        UIColor(red: 0.8, green: 0.0, blue: 0.0, alpha: 1.0)   // Red for "Strongly Disagree"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Quiz in progress"
        view.backgroundColor = UIColor(named: "PrimaryColor")
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
        
        // Add Option Buttons with corresponding colors
//        ["Strongly Agree", "Agree", "Neutral", "Disagree", "Strongly Disagree"].enumerated().forEach { index, option in
//            let button = UIButton(type: .system)
//            button.setTitle(option, for: .normal)
//            button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
//            
//            // Use the extension to set the background color for all states
//            button.setBackgroundColor(buttonColors[index], for: .normal)
//            button.setBackgroundColor(buttonColors[index].withAlphaComponent(0.8), for: .highlighted) // Slightly dimmed for highlighted state
//            
//            button.setTitleColor(.white, for: .normal)
//            button.layer.cornerRadius = 8
//            button.clipsToBounds = true // Ensures corners are rounded
//            button.addTarget(self, action: #selector(optionTapped(_:)), for: .touchUpInside)
//            optionsStackView.addArrangedSubview(button)
//        }
        
        // Next Button
        nextButton.setTitle("Next Question", for: .normal)
        nextButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        nextButton.backgroundColor = UIColor(named: "DarkColor")
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
            
            nextButton.topAnchor.constraint(equalTo: optionsStackView.bottomAnchor, constant: 50),
            nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nextButton.widthAnchor.constraint(equalToConstant: 200),
            nextButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    //    private func loadQuestion() {
    //        guard currentQuestionIndex < questions.count else {
    //            showResults()
    //            return
    //        }
    //
    //        questionLabel.text = "Question \(currentQuestionIndex + 1)/\(questions.count):\n\(questions[currentQuestionIndex])"
    //
    //        // Reset selected button state
    //        selectedButton?.backgroundColor = .lightGray
    //        selectedButton = nil
    //    }
    private func loadQuestion() {
        guard currentQuestionIndex < questions.count else {
            showResults()
            return
        }
        
        questionLabel.text = "Question \(currentQuestionIndex + 1)/\(questions.count):\n\(questions[currentQuestionIndex])"
        
        // Clear previous buttons and reset colors
        optionsStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        selectedButton = nil
        
        // Add Option Buttons with corresponding colors
        ["Strongly Agree", "Agree", "Neutral", "Disagree", "Strongly Disagree"].enumerated().forEach { index, option in
            let button = UIButton(type: .system)
            button.setTitle(option, for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
            button.backgroundColor = buttonColors[index] // Set original colors
            button.tag = index // Assign the index as the tag
            button.setTitleColor(.white, for: .normal)
            button.layer.cornerRadius = 8
            button.clipsToBounds = true
            button.addTarget(self, action: #selector(optionTapped(_:)), for: .touchUpInside)
            optionsStackView.addArrangedSubview(button)
        }
    }
    
    @objc private func optionTapped(_ sender: UIButton) {
        guard let selectedOption = sender.titleLabel?.text else { return }
        
        let score: Int
        switch selectedOption {
        case "Strongly Agree": score = 5
        case "Agree": score = 4
        case "Neutral": score = 3
        case "Disagree": score = 2
        case "Strongly Disagree": score = 1
        default: return
        }
        
        // Reset the previously selected button to its original color
       if let previousButton = selectedButton {
           previousButton.backgroundColor = buttonColors[previousButton.tag]
           // Reset color based on tag
       }
        
        
//        selectedButton?.backgroundColor = buttonColors[selectedButton?.tag ?? 0] // Reset previously selected button
        
        // Highlight the selected button
        sender.backgroundColor = .darkGray // Highlight new selection
        selectedButton = sender // Update the current selected button
        
        // Save or update the selected answer
        /*
         if answers.count > currentQuestionIndex {
         answers[currentQuestionIndex] = selectedOption
         } else {
         answers.append(selectedOption)
         }
         */
        
        if answers.count > currentQuestionIndex {
            answers[currentQuestionIndex] = score
        } else {
            answers.append(score)
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
    
    private func showAlert(_ message: String) {
        let alert = UIAlertController(title: "Notice", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    /*
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
     */
    
    private func showResults() {
        view.backgroundColor = UIColor(named: "PrimaryColor")
        let totalScore = answers.reduce(0, +)
        let resultMessage: String
        switch totalScore {
        case 40...50:
            resultMessage = """
            Your results suggest that there might be significant challenges in this area. It’s important to acknowledge these feelings and remember that support is always available. Seeking guidance from a professional, such as a counselor, therapist, or specialist in this field, can help you better understand and manage your situation. Taking the first step to seek help can feel daunting, but it’s a brave and positive action toward improving your well-being.
            """
        case 30...39:
            resultMessage = """
            Your responses indicate moderate difficulties in this area. This might be a good time to consider reaching out for support, whether from a professional, trusted friends, or family members. Exploring strategies such as building routines, engaging in relaxing activities, or finding a supportive community can also help. Remember, you're not alone, and taking small steps can lead to meaningful progress.
            """
        case 20...29:
            resultMessage = """
            Your results suggest mild concerns. It’s always beneficial to stay mindful of how you’re feeling and to practice self-care. Whether it’s dedicating time to activities you enjoy, maintaining a balanced lifestyle, or seeking support when needed, these small actions can contribute significantly to your overall well-being. If things feel challenging, don’t hesitate to reach out for guidance.
            """
        case 10...19:
            resultMessage = """
            Your results indicate that things seem to be going well in this area. It’s great that you’re maintaining balance and prioritizing your well-being. Continue with the healthy habits and practices that work for you, and remember that everyone faces ups and downs. Being aware of your needs and knowing when to seek help is a strength.
            """
        default:
            resultMessage = """
            It looks like there might be an issue with your responses, and we couldn’t calculate a valid score. This can happen if some answers were incomplete or inconsistent. To gain accurate insights, consider retaking the test when you’re ready. Remember, this test is just a tool for reflection, and professional advice is always a good next step if you have concerns.
            """
        }
        
        let resultVC = ResultViewController()
        resultVC.score = totalScore
        resultVC.resultMessage = resultMessage
        resultVC.testName = testName
        navigationController?.pushViewController(resultVC, animated: true)
    }
    
}


