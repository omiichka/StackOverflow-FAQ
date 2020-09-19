//
//  UIViewController.swift
//  StackOverflow-FAQ
//
//  Created by Artem Golovanev on 18.09.2020.
//  Copyright © 2020 Artem Golovanev. All rights reserved.
//

import UIKit

extension UIViewController {

    var topbarHeight: CGFloat {
        return (view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0.0) + (navigationController?.navigationBar.frame.height ?? 0.0)
    }
}
