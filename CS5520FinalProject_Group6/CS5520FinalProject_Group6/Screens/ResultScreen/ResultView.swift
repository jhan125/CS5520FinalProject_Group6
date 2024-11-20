// Modified by Jiali Han on 11/20/24.
// Reset color design for user experience.

import UIKit

class ResultView: UIView {

    private let scoreCircleView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        view.layer.borderWidth = 2
        view.layer.cornerRadius = 75
        return view
    }()

    let scoreLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 48)
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        
        // make label more contrast
        label.layer.shadowColor = UIColor.black.cgColor
        label.layer.shadowOffset = CGSize(width: 1, height: 1)
        label.layer.shadowRadius = 2
        label.layer.shadowOpacity = 0.7
        
        return label
    }()

    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
        
        label.textColor = .darkGray
        
        return label
    }()

    let saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Save result", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.backgroundColor = UIColor(named: "DarkColor")
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    let historyButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("See all Test History", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.underline()
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        addSubview(scoreCircleView)
        scoreCircleView.addSubview(scoreLabel)
        addSubview(descriptionLabel)
        addSubview(saveButton)
        addSubview(historyButton)

        NSLayoutConstraint.activate([
            scoreCircleView.centerXAnchor.constraint(equalTo: centerXAnchor),
            scoreCircleView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 40),
            scoreCircleView.widthAnchor.constraint(equalToConstant: 150),
            scoreCircleView.heightAnchor.constraint(equalToConstant: 150),

            scoreLabel.centerXAnchor.constraint(equalTo: scoreCircleView.centerXAnchor),
            scoreLabel.centerYAnchor.constraint(equalTo: scoreCircleView.centerYAnchor),

            descriptionLabel.topAnchor.constraint(equalTo: scoreCircleView.bottomAnchor, constant: 20),
            descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),

            saveButton.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 30),
            saveButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            saveButton.widthAnchor.constraint(equalToConstant: 150),
            saveButton.heightAnchor.constraint(equalToConstant: 50),

            historyButton.topAnchor.constraint(equalTo: saveButton.bottomAnchor, constant: 10),
            historyButton.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }

    func setScoreAndColor(score: Int) {
        var textColor: UIColor
        var backgroundColor: UIColor
        
//        switch score {
//        case 40..<51:
//            textColor = .red
//        case 30..<40:
//            textColor = .orange
//        case 20..<30:
//            textColor = .yellow
//        case 10..<20:
//            textColor = .green
//        default:
//            textColor = .gray
//        }
            
        // Set colors based on score
        switch score {
        case 40..<51:
            textColor = .darkRed
            backgroundColor = UIColor(red: 1.0, green: 0.8, blue: 0.8, alpha: 1.0) // Light Red
        case 30..<40:
            textColor = .darkOrange
            backgroundColor = UIColor(red: 1.0, green: 0.9, blue: 0.7, alpha: 1.0) // Light Orange
        case 20..<30:
            textColor = .darkYellow
            backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 0.8, alpha: 1.0) // Light Yellow
        case 10..<20:
            textColor = .darkGreen
            backgroundColor = UIColor(red: 0.8, green: 1.0, blue: 0.8, alpha: 1.0) // Light Green
        default:
            textColor = .darkGray
            backgroundColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0) // Light Gray
        }

        scoreLabel.textColor = textColor
        scoreCircleView.layer.borderColor = textColor.cgColor
        scoreCircleView.backgroundColor = backgroundColor
    }
}

extension UILabel {
    func underline() {
        guard let text = self.text else { return }
        let attributedString = NSMutableAttributedString(string: text)
        attributedString.addAttribute(.underlineStyle,
                                      value: NSUnderlineStyle.single.rawValue,
                                      range: NSRange(location: 0, length: text.count))
        self.attributedText = attributedString
    }
}

