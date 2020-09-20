//
//  QuestionCell.swift
//  StackOverflow-FAQ
//
//  Created by Artem Golovanev on 14.09.2020.
//  Copyright © 2020 Artem Golovanev. All rights reserved.
//

import UIKit

final class QuestionCell: UITableViewCell {
    
    private let titleLabel = TitleLabel()
    private let authorLabel = ContentLabel()
    private let numberOfAnswerLabel = ContentLabel()
    private let dateLabel = ContentLabel()
    private let separatorView = SeparatorView()
    
    var question: Question? {
        didSet {
            guard let item = question else { return }
            titleLabel.text = item.title ?? ""
            titleLabel.numberOfLines = 0
            authorLabel.text = item.owner?.displayName ?? ""
            numberOfAnswerLabel.text = "Answer: " + String(item.answerCount ?? 0)
            dateLabel.text = String().formatter(intDate: item.lastActivityDate ?? 0) + String().timeAgo(intDate: item.lastActivityDate ?? 0)
            layout()
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension QuestionCell {
    
    func setup() {
        backgroundColor = #colorLiteral(red: 0.07, green: 0.07, blue: 0.07, alpha: 1)
        [titleLabel, authorLabel, numberOfAnswerLabel, dateLabel, separatorView].forEach { addSubview($0) }
    }
    
    func layout() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            titleLabel.heightAnchor.constraint(equalToConstant: 75),
            
            authorLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 15),
            authorLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 10),
            authorLabel.widthAnchor.constraint(equalToConstant: authorLabel.intrinsicContentSize.width),
            authorLabel.heightAnchor.constraint(equalToConstant: 20),
            
            numberOfAnswerLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 15),
            numberOfAnswerLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -10),
            numberOfAnswerLabel.heightAnchor.constraint(equalToConstant: 20),
            
            dateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 40),
            dateLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -10),
            dateLabel.heightAnchor.constraint(equalToConstant: 20),
            
            separatorView.leadingAnchor.constraint(equalTo: leadingAnchor),
            separatorView.trailingAnchor.constraint(equalTo: trailingAnchor),
            separatorView.topAnchor.constraint(equalTo: bottomAnchor, constant: -1),
            separatorView.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
}

