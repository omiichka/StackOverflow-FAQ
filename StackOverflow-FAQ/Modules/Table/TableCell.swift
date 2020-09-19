//
//  TableCell.swift
//  StackOverflow-FAQ
//
//  Created by Artem Golovanev on 14.09.2020.
//  Copyright © 2020 Artem Golovanev. All rights reserved.
//

import UIKit

final class TableCell: UITableViewCell {
    
    private var tags: Tag?
    func setup<T>(type: CellType, dataSource: T) {
        switch type {
        case .tags:
            guard let dataSource = dataSource as? Tag, contentView.subviews.isEmpty else { return }
//            tags = dataSource
            setupTags(with: dataSource)
            print(dataSource, "DDD")
        case .questions:
            guard let dataSource = dataSource as? Question else { return }
            setupQuestions(with: dataSource)
        case .answers:
            guard let dataSource = dataSource as? Answer else { return }
            setupAnswers(with: dataSource)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
//        setupTags(with: tags)
    }
}

private extension TableCell {
    
    func setupTags(with item: Tag?) {
        backgroundColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
        let titleLabel = UILabel()
        titleLabel.text = item?.name
        titleLabel.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        titleLabel.font = .systemFont(ofSize: 17)
        titleLabel.frame = CGRect(x: 15, y: center.y, width: titleLabel.intrinsicContentSize.width, height: 20)
        titleLabel.textAlignment = .left
        addSubview(titleLabel)
    }
    
    func setupQuestions(with item: Question) {
        let titleLabel = UILabel()
        let authorLabel = UILabel()
        let numberOfAnswerLabel = UILabel()
        let dateLabel = UILabel()
        
        backgroundColor = #colorLiteral(red: 0.07, green: 0.07, blue: 0.07, alpha: 1)
        titleLabel.text = item.title ?? ""
        titleLabel.numberOfLines = 0
        authorLabel.text = item.owner?.displayName ?? ""
        numberOfAnswerLabel.text = "Answer: " + String(item.answerCount ?? 0)
        dateLabel.text = String().formatter(intDate: item.lastActivityDate ?? 0) + String().timeAgo(intDate: item.lastActivityDate ?? 0)
        
        [titleLabel, authorLabel, numberOfAnswerLabel, dateLabel].forEach {
            $0.font = .systemFont(ofSize: 13)
            $0.textColor = #colorLiteral(red: 0.314, green: 0.89, blue: 0.761, alpha: 1)
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            titleLabel.heightAnchor.constraint(equalToConstant: 40),
            
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
    
    func setupAnswers(with item: Answer) {
        let answerLabel = UILabel()
        let authorLabel = UILabel()
        let lastActivityDateLabel = UILabel()
        let numberOfVotesLabel = UILabel()
        let checkImageView = UIImageView()
        
        backgroundColor = #colorLiteral(red: 0.07, green: 0.07, blue: 0.07, alpha: 1)
        answerLabel.attributedText = NSAttributedString().setupAnswersBody(with: item)
        authorLabel.text = item.owner?.displayName
        numberOfVotesLabel.text = String(format: "%li", Int(item.score ?? 0))
        lastActivityDateLabel.text = String().formatter(intDate: item.lastActivityDate ?? 0) + String().timeAgo(intDate: item.lastActivityDate ?? 0)
        
        [answerLabel, authorLabel, lastActivityDateLabel]
    }
    
    
}

