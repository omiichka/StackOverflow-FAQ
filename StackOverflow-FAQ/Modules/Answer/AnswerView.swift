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
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        backgroundColor = #colorLiteral(red: 0.314, green: 0.89, blue: 0.761, alpha: 1)
        separatorStyle = .none
        showsVerticalScrollIndicator = false
        register(AnswerCell.self, forCellReuseIdentifier: String().cellIdentifier(type: .answers))
    }
}

