//
//  UIView+AutoLayout.swift
//  employees
//
//  Created by Miroslav Ganchev on 23.11.23.
//

import Foundation
import UIKit

extension UIView {
    func addSubview(_ view: UIView, with constraints: [NSLayoutConstraint]) {
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        NSLayoutConstraint.activate(constraints)
    }
}
