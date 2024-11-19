import UIKit

class TestSelectionViewController: UIViewController {

    private let testButtons: [UIButton] = ["Stress Quiz", "Depression Quiz", "Bipolar Quiz", "PTSD Quiz"].map {
        let button = UIButton(type: .system)
        button.setTitle($0, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        button.backgroundColor = .lightGray
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        return button
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
    }

    private func setupUI() {
        let stackView = UIStackView(arrangedSubviews: testButtons)
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])

        for button in testButtons {
            button.translatesAutoresizingMaskIntoConstraints = false
            button.widthAnchor.constraint(equalToConstant: 200).isActive = true
            button.heightAnchor.constraint(equalToConstant: 50).isActive = true
            button.addTarget(self, action: #selector(testSelected(_:)), for: .touchUpInside)
        }
    }

    @objc private func testSelected(_ sender: UIButton) {
        guard let testName = sender.title(for: .normal) else { return }

        let questions: [String]
        switch testName {
        case "Stress Quiz":
            questions = [
                "I feel overwhelmed by my own emotions.",
                "I have trouble sleeping due to stress.",
                "I find it hard to relax in stressful situations.",
                "I often feel irritable or short-tempered.",
                "I find it difficult to focus or concentrate on tasks.",
                "I experience physical symptoms like headaches or muscle tension.",
                "I feel like I have too much to do and not enough time.",
                "I feel anxious or worried about the future.",
                "I avoid social interactions because of stress.",
                "I feel a lack of control over my life."
            ]
        case "Depression Quiz":
            questions = [
                "I feel sad or hopeless.",
                "I have lost interest in activities I used to enjoy.",
                "I feel fatigued or lack energy most days.",
                "I have trouble sleeping or sleep too much.",
                "I feel worthless or guilty without a clear reason.",
                "I experience changes in appetite (eating too much or too little).",
                "I feel restless or slowed down in my movements.",
                "I feel like life isn’t worth living.",
                "I have withdrawn from social activities or relationships."
            ]
        case "Bipolar Quiz":
            questions = [
                "I experience extreme mood swings between feeling very high or energetic and very low or sad.",
                "I feel unusually energetic or restless, even when I haven’t slept much.",
                "I have episodes where I feel overly optimistic, self-confident, or invincible.",
                "I sometimes talk very quickly or feel like my thoughts are racing.",
                "I feel unusually irritable or easily frustrated during certain periods.",
                "I engage in risky activities or make impulsive decisions during periods of high energy.",
                "I have difficulty concentrating or completing tasks due to sudden shifts in energy.",
                "I experience episodes of depression where I feel hopeless or lack energy.",
                "My mood changes seem to disrupt my personal or professional life.",
                "I find it difficult to maintain relationships due to my changing moods."
            ]
        case "PTSD Quiz":
            questions = [
                "I have frequent, distressing memories or flashbacks of a traumatic event.",
                "I try to avoid thoughts, feelings, or reminders of the traumatic event.",
                "I feel emotionally numb or disconnected from others.",
                "I have trouble sleeping due to nightmares or anxiety.",
                "I feel constantly on edge, alert, or easily startled.",
                "I struggle to remember important details about the traumatic event.",
                "I often feel angry, irritable, or experience sudden outbursts.",
                "I have lost interest in activities I once enjoyed.",
                "I feel detached from reality, like things are happening around me but I’m not truly present.",
                "I avoid places, people, or situations that remind me of the traumatic event."
            ]
        default:
            questions = []
        }

        let assessmentVC = AssessmentViewController()
        assessmentVC.testName = testName
        assessmentVC.questions = questions
        navigationController?.pushViewController(assessmentVC, animated: true)
    }
}
