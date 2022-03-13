//
//  CustomButton.swift
//  Navigation
//
//  Created by Антон Соколов on 13.03.2022.
//

import UIKit

class CustomButton: UIControl {
    private var title: String
    private var colorTint: UIColor
    var onButtonTap: (() -> Void)?
    lazy var button: UIButton = {
        let logButton = UIButton()
        logButton.setTitle(self.title, for: .normal)
        logButton.tintColor = self.colorTint
        logButton.setBackgroundImage(UIImage(named: "blue_pixel"), for: .normal)
        logButton.layer.cornerRadius = 10
        logButton.clipsToBounds = true
        logButton.toAutoLayout()
        logButton.addTarget(self, action: #selector(tapLoginButton), for: .touchUpInside)
        return logButton
    }()
    

    // перегруженный конструктор
    init(title: String, tintColor:UIColor) {
        self.title = title
        self.colorTint = tintColor
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func tapLoginButton() {
        self.onButtonTap?()
    }
}
