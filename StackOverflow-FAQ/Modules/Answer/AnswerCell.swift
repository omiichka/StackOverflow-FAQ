//
//  AnswerCell.swift
//  StackOverflow-FAQ
//
//  Created by Artem Golovanev on 19.09.2020.
//  Copyright © 2020 Artem Golovanev. All rights reserved.
//

import UIKit

final class AnswerCell: UITableViewCell {
    
    private let answerLabel = UILabel()
    private let authorLabel = UILabel()
    private let lastActivityDateLabel = UILabel()
    private let numberOfVotesLabel = UILabel()
    private let checkImageView = UIImageView()
    
    var answer: Answer? {
        didSet {
            guard let item = answer else { return }
            answerLabel.attributedText = NSAttributedString().setupAnswersBody(with: item)
            authorLabel.text = item.owner?.displayName
            numberOfVotesLabel.text = String(format: "%li", Int(item.score ?? 0))
            lastActivityDateLabel.text = String().formatter(intDate: item.lastActivityDate ?? 0) + String().timeAgo(intDate: item.lastActivityDate ?? 0)
//            answerLabel.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            print(answerLabel, "answerLabel")
            print(NSAttributedString().setupAnswersBody(with: item), "NSAttributedString().setupAnswersBody(with: item)")
            answerLabel.frame = frame
            answerLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
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
    
    func setup() {
        backgroundColor = #colorLiteral(red: 0.07, green: 0.07, blue: 0.07, alpha: 1)
        [answerLabel, authorLabel, numberOfVotesLabel, lastActivityDateLabel].forEach {
//            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
    }
    
    func layout() {
        NSLayoutConstraint.activate([
            answerLabel.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            answerLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            answerLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
//            answerLabel.heightAnchor.constraint(equalToConstant: 75),
            
            authorLabel.topAnchor.constraint(equalTo: answerLabel.bottomAnchor, constant: 15),
            authorLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 10),
            authorLabel.widthAnchor.constraint(equalToConstant: authorLabel.intrinsicContentSize.width),
            authorLabel.heightAnchor.constraint(equalToConstant: 20),
            
            numberOfVotesLabel.topAnchor.constraint(equalTo: answerLabel.bottomAnchor, constant: 15),
            numberOfVotesLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -10),
            numberOfVotesLabel.heightAnchor.constraint(equalToConstant: 20),
            
            lastActivityDateLabel.topAnchor.constraint(equalTo: answerLabel.bottomAnchor, constant: 40),
            lastActivityDateLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -10),
            lastActivityDateLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
}
