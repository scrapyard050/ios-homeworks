////
////  CustomButton.swift
////  Navigation
////
////  Created by Антон Соколов on 13.03.2022.
///
import UIKit

class CustomButton: UIButton {
    var onButtonTap: (() -> Void)?
    
    // перегруженный конструктор
    init(title: String, tintColor:UIColor) {
        super.init(frame: .zero)
        self.setTitle(title, for: .normal)
        self.setTitleColor(tintColor, for: .normal)
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
