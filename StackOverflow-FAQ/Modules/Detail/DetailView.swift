//
//  DetailView.swift
//  StackOverflow-FAQ
//
//  Created by Artem Golovanev on 16.09.2020.
//  Copyright © 2020 Artem Golovanev. All rights reserved.
//

import UIKit

final class DetailView: UIView {
    
    private let titleLabel = UILabel()
    private let authorLabel = UILabel()
    private let numberOfAnswerLabel = UILabel()
    private let dateLabel = UILabel()
    
    let showAnswersButton = UIButton()
    
    var question: Question? {
        didSet {
            guard let item = question else { return }
            titleLabel.text = item.title ?? ""
            authorLabel.text = item.owner?.displayName ?? ""
            numberOfAnswerLabel.text = "Answer: " + String(item.answerCount ?? 0)
            dateLabel.text = String().formatter(intDate: item.lastActivityDate ?? 0) + String().timeAgo(intDate: item.lastActivityDate ?? 0)
            layout()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension DetailView {
    
    func setup() {
        backgroundColor = #colorLiteral(red: 0.07, green: 0.07, blue: 0.07, alpha: 1)
        [titleLabel, authorLabel, numberOfAnswerLabel, dateLabel].forEach {
            $0.font = .systemFont(ofSize: 13)
            $0.textColor = #colorLiteral(red: 0.314, green: 0.89, blue: 0.761, alpha: 1)
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
        showAnswersButton.setTitle("SHOW", for: .normal)
        showAnswersButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(showAnswersButton)
    }
    
    func layout() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 100),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            titleLabel.heightAnchor.constraint(equalToConstant: 20),
            
            authorLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 40),
            authorLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            authorLabel.widthAnchor.constraint(equalToConstant: authorLabel.intrinsicContentSize.width),
            authorLabel.heightAnchor.constraint(equalToConstant: 20),
            
            numberOfAnswerLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            numberOfAnswerLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            numberOfAnswerLabel.widthAnchor.constraint(equalToConstant: numberOfAnswerLabel.intrinsicContentSize.width),
            numberOfAnswerLabel.heightAnchor.constraint(equalToConstant: 20),
            
            dateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 40),
            dateLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            dateLabel.widthAnchor.constraint(equalToConstant: dateLabel.intrinsicContentSize.width),
            dateLabel.heightAnchor.constraint(equalToConstant: 20),
            
            showAnswersButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            showAnswersButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            showAnswersButton.widthAnchor.constraint(equalToConstant: 50),
            showAnswersButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}
