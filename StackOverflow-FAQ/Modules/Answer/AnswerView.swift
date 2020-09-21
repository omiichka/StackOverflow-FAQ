//
//  AnswerView.swift
//  StackOverflow-FAQ
//
//  Created by Artem Golovanev on 19.09.2020.
//  Copyright © 2020 Artem Golovanev. All rights reserved.
//

import UIKit

final class AnswerView: UITableView {
    
    init() {
        super.init(frame: .zero, style: .plain)
        setup()
        setupActivity()
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func showEmptyView() {
        let emptyLabel = TitleLabel()
        emptyLabel.text = "No answers yet :c"
        emptyLabel.translatesAutoresizingMaskIntoConstraints = false
        emptyLabel.textAlignment = .center
        emptyLabel.font = .boldSystemFont(ofSize: 25)
        addSubview(emptyLabel)
        
        NSLayoutConstraint.activate([
            emptyLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            emptyLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            emptyLabel.widthAnchor.constraint(equalToConstant: emptyLabel.intrinsicContentSize.width),
            emptyLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
}

private extension AnswerView {
    
    func setup() {
        allowsSelection = false
        backgroundColor = #colorLiteral(red: 0.07, green: 0.07, blue: 0.07, alpha: 1)
        separatorStyle = .none
        showsVerticalScrollIndicator = false
        register(AnswerCell.self, forCellReuseIdentifier: String().cellIdentifier(type: .answers))
    }
}

