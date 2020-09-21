//
//  AnswerCell.swift
//  StackOverflow-FAQ
//
//  Created by Artem Golovanev on 19.09.2020.
//  Copyright © 2020 Artem Golovanev. All rights reserved.
//

import UIKit

final class AnswerCell: UITableViewCell {
    
    private let answerLabel = TitleLabel()
    private let authorLabel = ContentLabel()
    private let lastActivityDateLabel = ContentLabel()
    private let numberOfVotesLabel = ContentLabel()
    private let checkImageView = UIImageView()
    private let separatorView = SeparatorView()
    
    var answer: Answer? {
        didSet {
            guard let item = answer else { return }
            answerLabel.attributedText = NSAttributedString().setupAnswersBody(with: item.body)
            authorLabel.text = item.owner?.displayName
            numberOfVotesLabel.text = String(format: "%li", Int(item.score ?? 0))
            lastActivityDateLabel.text = String().formatter(intDate: item.lastActivityDate ?? 0) + String().timeAgo(intDate: item.lastActivityDate ?? 0)
            checkImageView.isHidden = !(item.isAccepted ?? true)
            layout()
        }
    }
    
    var height: CGFloat {
        return [answerLabel, authorLabel, numberOfVotesLabel, lastActivityDateLabel].map { $0.intrinsicContentSize.height }.reduce(0, +) + 80
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension AnswerCell {
    
    func setup() {
        backgroundColor = #colorLiteral(red: 0.07, green: 0.07, blue: 0.07, alpha: 1)
        checkImageView.image = #imageLiteral(resourceName: "done")
        [answerLabel, authorLabel, numberOfVotesLabel, lastActivityDateLabel].forEach {
            $0.font = .boldSystemFont(ofSize: 16)
        }
        [answerLabel, authorLabel, numberOfVotesLabel, lastActivityDateLabel, checkImageView, separatorView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
    }
    
    func layout() {
        NSLayoutConstraint.activate([
            answerLabel.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            answerLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            answerLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            answerLabel.heightAnchor.constraint(equalToConstant: answerLabel.intrinsicContentSize.height),

            authorLabel.topAnchor.constraint(equalTo: answerLabel.bottomAnchor, constant: 15),
            authorLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 10),
            authorLabel.widthAnchor.constraint(equalToConstant: authorLabel.intrinsicContentSize.width),
            authorLabel.heightAnchor.constraint(equalToConstant: authorLabel.intrinsicContentSize.height),

            numberOfVotesLabel.topAnchor.constraint(equalTo: answerLabel.bottomAnchor, constant: 15),
            numberOfVotesLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -10),
            numberOfVotesLabel.heightAnchor.constraint(equalToConstant: numberOfVotesLabel.intrinsicContentSize.height),

            lastActivityDateLabel.topAnchor.constraint(equalTo: numberOfVotesLabel.bottomAnchor, constant: 20),
            lastActivityDateLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -10),
            lastActivityDateLabel.heightAnchor.constraint(equalToConstant: lastActivityDateLabel.intrinsicContentSize.height),
            
            checkImageView.bottomAnchor.constraint(equalTo: separatorView.topAnchor, constant: -5),
            checkImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            checkImageView.widthAnchor.constraint(equalToConstant: 30),
            checkImageView.heightAnchor.constraint(equalToConstant: 30),

            separatorView.leadingAnchor.constraint(equalTo: leadingAnchor),
            separatorView.trailingAnchor.constraint(equalTo: trailingAnchor),
            separatorView.topAnchor.constraint(equalTo: bottomAnchor, constant: -1),
            separatorView.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
}

