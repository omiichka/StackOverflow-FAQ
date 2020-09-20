//
//  ShowAnswersButton.swift
//  StackOverflow-FAQ
//
//  Created by Artem Golovanev on 20.09.2020.
//  Copyright © 2020 Artem Golovanev. All rights reserved.
//

import UIKit

final class ShowAnswersButton: UIButton {
    
    override init(frame: CGRect) {
           super.init(frame: frame)
           setup()
       }
       
       required init?(coder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }
}

private extension ShowAnswersButton {
    
    func setup() {
        setTitle("Show answers", for: .normal)
        titleLabel?.font = .boldSystemFont(ofSize: 11)
        layer.borderWidth = 1
        titleLabel?.numberOfLines = 2
        titleLabel?.lineBreakMode = .byWordWrapping
        titleLabel?.textAlignment = .center
        backgroundColor = #colorLiteral(red: 0.314, green: 0.89, blue: 0.761, alpha: 1)
        layer.cornerRadius = 35
        translatesAutoresizingMaskIntoConstraints = false
        setTitleColor(#colorLiteral(red: 0.07, green: 0.07, blue: 0.07, alpha: 1), for: .normal)
    }
}
