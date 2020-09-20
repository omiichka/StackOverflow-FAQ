//
//  TagView.swift
//  StackOverflow-FAQ
//
//  Created by Artem Golovanev on 20.09.2020.
//  Copyright © 2020 Artem Golovanev. All rights reserved.
//

import UIKit

final class TagView: UITableView {
    
    init() {
        super.init(frame: .zero, style: .grouped)
        setup()
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        backgroundColor = #colorLiteral(red: 0.07, green: 0.07, blue: 0.07, alpha: 1)
        layer.cornerRadius = 25
        layer.borderWidth = 2
        layer.borderColor = #colorLiteral(red: 0.314, green: 0.89, blue: 0.761, alpha: 1)
        showsVerticalScrollIndicator = false
        register(TagCell.self, forCellReuseIdentifier: String().cellIdentifier(type: .tags))
    }
}

