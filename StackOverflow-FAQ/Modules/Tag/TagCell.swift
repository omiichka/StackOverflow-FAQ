//
//  TagCell.swift
//  StackOverflow-FAQ
//
//  Created by Artem Golovanev on 20.09.2020.
//  Copyright © 2020 Artem Golovanev. All rights reserved.
//

import UIKit

final class TagCell: UITableViewCell {
    
    private let titleLabel = TitleLabel()
    private let separatorView = SeparatorView()
    
    var tags: Tag? {
        didSet {
            guard let item = tags else { return }
            titleLabel.text = item.name
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
        titleLabel.frame = CGRect(x: 15, y: center.y - 10, width: frame.width, height: 20)
        separatorView.frame = CGRect(x: 0, y: frame.height - 1, width: frame.width, height: 1)
        [titleLabel, separatorView].forEach { addSubview($0) }
    }
}
