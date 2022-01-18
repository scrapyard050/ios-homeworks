//
//  UIViewHelpers.swift
//  Navigation
//
//  Created by Антон Соколов on 18.01.2022.
//

import UIKit
public extension UIView {
    func toAutoLayout() {
        translatesAutoresizingMaskIntoConstraints = false
    }

    func addSubviews(_ subviews: UIView...) {
        subviews.forEach { addSubview($0) }
    }
}
