//
//  TableView.swift
//  StackOverflow-FAQ
//
//  Created by Artem Golovanev on 14.09.2020.
//  Copyright © 2020 Artem Golovanev. All rights reserved.
//

import UIKit

final class TableView: UITableView {
    
    init(with type: CellType) {
        super.init(frame: .zero, style: .grouped)
        setup(with: type)
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup(with type: CellType) {
        backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        showsVerticalScrollIndicator = false
        register(TableCell.self, forCellReuseIdentifier: String().cellIdentifier(type: type))
    }
}

