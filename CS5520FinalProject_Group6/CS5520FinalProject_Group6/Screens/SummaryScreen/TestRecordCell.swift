import UIKit

class TestRecordCell: UITableViewCell {
    private let containerView = UIView()
    private let testNameLabel = UILabel()
    private let scoreLabel = UILabel()
    private let dateLabel = UILabel()
    private let separatorView = UIView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupCell()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupCell() {
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.layer.cornerRadius = 8
        containerView.layer.borderWidth = 1
        containerView.layer.borderColor = UIColor.lightGray.cgColor
        containerView.backgroundColor = UIColor.systemGray6

        testNameLabel.font = UIFont.boldSystemFont(ofSize: 18)
        testNameLabel.textColor = UIColor(named: "DarkColor")
                
        testNameLabel.translatesAutoresizingMaskIntoConstraints = false

        scoreLabel.font = UIFont.systemFont(ofSize: 16)
        scoreLabel.textColor = UIColor.darkGray
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false

        dateLabel.font = UIFont.systemFont(ofSize: 16)
        dateLabel.textColor = UIColor.darkGray
        dateLabel.translatesAutoresizingMaskIntoConstraints = false

        separatorView.backgroundColor = UIColor.lightGray
        separatorView.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(containerView)
        containerView.addSubview(testNameLabel)
        containerView.addSubview(scoreLabel)
        containerView.addSubview(dateLabel)
        containerView.addSubview(separatorView)

        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),

            testNameLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 12),
            testNameLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 12),
            testNameLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -12),

            separatorView.topAnchor.constraint(equalTo: testNameLabel.bottomAnchor, constant: 8),
            separatorView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 12),
            separatorView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -12),
            separatorView.heightAnchor.constraint(equalToConstant: 1),

            scoreLabel.topAnchor.constraint(equalTo: separatorView.bottomAnchor, constant: 8),
            scoreLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 12),

            dateLabel.topAnchor.constraint(equalTo: separatorView.bottomAnchor, constant: 8),
            dateLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -12)
        ])
    }

    func configure(testName: String, score: Int, date: String) {
        testNameLabel.text = "Test Name: \(testName)"
        scoreLabel.text = "Score: \(score)%"
        dateLabel.text = "Date: \(date)"
    }
}

