//
//  SeparatorView.swift
//  StackOverflow-FAQ
//
//  Created by Artem Golovanev on 20.09.2020.
//  Copyright © 2020 Artem Golovanev. All rights reserved.
//

import UIKit

final class SeparatorView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension SeparatorView {
    
    func setup() {
        backgroundColor = #colorLiteral(red: 0.314, green: 0.89, blue: 0.761, alpha: 1)
        translatesAutoresizingMaskIntoConstraints = false
    }
}
