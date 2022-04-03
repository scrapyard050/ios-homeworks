//
//  BrutForceButton.swift
//  Navigation
//
//  Created by Антон Соколов on 03.04.2022.
//

import UIKit

class BrutForceButton: UIButton {
    var onButtonTap: (() -> Void)?
    
    // перегруженный конструктор
    init(title: String, tintColor:UIColor) {
        super.init(frame: .zero)
        self.setTitle(title, for: .normal)
        self.setTitleColor(tintColor, for: .normal)
        self.setBackgroundImage(UIImage(named: "blue_pixel"), for: .normal)
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
        self.toAutoLayout()
        self.addTarget(self, action: #selector(tapLoginButton), for: .touchUpInside)
        self.toAutoLayout()
    }
    
   
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func tapLoginButton() {
        self.onButtonTap?()
    }
}

