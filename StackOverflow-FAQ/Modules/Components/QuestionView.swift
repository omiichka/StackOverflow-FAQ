//
//  QuestionView.swift
//  StackOverflow-FAQ
//
//  Created by Artem Golovanev on 17.09.2020.
//  Copyright © 2020 Artem Golovanev. All rights reserved.
//

import UIKit

final class QuestionView: UIView {
    
    private let titleLabel = UILabel()
    private let authorLabel = UILabel()
    private let numberOfAnswerLabel = UILabel()
    private let dateLabel = UILabel()
    
    var question: Question? {
        didSet {
            guard let question = question else { return }
            setup(with: question)
        }
    }
    
    private func setup(with item: Question) {
        backgroundColor = #colorLiteral(red: 0.07, green: 0.07, blue: 0.07, alpha: 1)
        titleLabel.text = item.title ?? ""
        authorLabel.text = item.owner?.displayName ?? ""
        numberOfAnswerLabel.text = "Answer: " + String(item.answerCount ?? 0)
        dateLabel.text = String().formatter(intDate: item.lastActivityDate ?? 0) + String().timeAgo(intDate: item.lastActivityDate ?? 0)
        
        [titleLabel, authorLabel, numberOfAnswerLabel, dateLabel].forEach {
            $0.font = .systemFont(ofSize: 13)
            $0.textColor = #colorLiteral(red: 0.314, green: 0.89, blue: 0.761, alpha: 1)
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
        
//        titleLabel.frame = CGRect(x: center.x - titleLabel.intrinsicContentSize.width / 2, y: 10, width: titleLabel.intrinsicContentSize.width, height: 20)
//        authorLabel.frame = CGRect(x: 10, y: frame.height - 30, width: authorLabel.intrinsicContentSize.width, height: 20)
//        numberOfAnswerLabel.frame = CGRect(x: frame.width - numberOfAnswerLabel.intrinsicContentSize.width - 10, y: titleLabel.frame.height + 30, width: numberOfAnswerLabel.intrinsicContentSize.width, height: 20)
//        dateLabel.frame = CGRect(x: frame.width - dateLabel.intrinsicContentSize.width - 10, y: frame.height - 30, width: dateLabel.intrinsicContentSize.width, height: 20)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
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
            dateLabel.heightAnchor.constraint(equalToConstant: 20)
            
            
        ])
    }
}
