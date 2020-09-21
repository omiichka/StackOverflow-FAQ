//
//  QuestionView.swift
//  StackOverflow-FAQ
//
//  Created by Artem Golovanev on 14.09.2020.
//  Copyright © 2020 Artem Golovanev. All rights reserved.
//

import UIKit

final class QuestionView: UITableView {
    
    init() {
        super.init(frame: .zero, style: .plain)
        setup()
        setupActivity()
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension QuestionView {
    
    func setup() {
        backgroundColor = #colorLiteral(red: 0.07, green: 0.07, blue: 0.07, alpha: 1)
        separatorStyle = .none
        showsVerticalScrollIndicator = false
        register(QuestionCell.self, forCellReuseIdentifier: String().cellIdentifier(type: .questions))
    }
}

