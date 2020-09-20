//
//  TitleLabel.swift
//  StackOverflow-FAQ
//
//  Created by Artem Golovanev on 20.09.2020.
//  Copyright © 2020 Artem Golovanev. All rights reserved.
//

import UIKit

final class TitleLabel: UILabel {
    
     override init(frame: CGRect) {
           super.init(frame: frame)
           setup()
       }
       
       required init?(coder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }
}

private extension TitleLabel {
    
    func setup() {
        textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        font = .boldSystemFont(ofSize: 20)
        numberOfLines = 0
        lineBreakMode = .byWordWrapping
        translatesAutoresizingMaskIntoConstraints = false
    }
}
