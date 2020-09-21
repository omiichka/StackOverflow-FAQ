//
//  UIView.swift
//  StackOverflow-FAQ
//
//  Created by Artem Golovanev on 21.09.2020.
//  Copyright © 2020 Artem Golovanev. All rights reserved.
//

import UIKit

extension UIView {
    
    func setupActivity() {
        let activity = UIActivityIndicatorView()
        activity.translatesAutoresizingMaskIntoConstraints = false
        activity.showsLargeContentViewer = true
        activity.color = #colorLiteral(red: 0.314, green: 0.89, blue: 0.761, alpha: 1)
        activity.style = .large
        addSubview(activity)

        NSLayoutConstraint.activate([
            activity.centerXAnchor.constraint(equalTo: centerXAnchor),
            activity.centerYAnchor.constraint(equalTo: centerYAnchor),
            activity.widthAnchor.constraint(equalToConstant: 50),
            activity.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    func setActivityState(isOn: Bool) {
        guard let actvity = subviews.first(where: { $0 is UIActivityIndicatorView } ) as? UIActivityIndicatorView else { return }
        isOn ? actvity.startAnimating() : actvity.stopAnimating()
    }
}
