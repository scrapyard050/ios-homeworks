//
//  InfoViewController.swift
//  Navigation
//
//  Created by Антон Соколов on 20.10.2021.
//

import UIKit

class InfoViewController: UIViewController {
    
    @objc func tappedAlertButton(sender: UIButton) {
        NSLog("Show alert")
        let alert = UIAlertController(title: "Alert", message: "Go back?", preferredStyle: .alert)
        let ok = UIAlertAction(title: "YES", style: .default, handler: { _ in
            NSLog("Go back")
            self.dismiss(animated: true) {
                NSLog("Controller is dismissed")
            }
        })
        
        let cancel = UIAlertAction(title: "NO", style: .cancel, handler: { _ in
            NSLog("No")
        })
        
        alert.addAction(ok)
        alert.addAction(cancel)
        
        self.present(alert, animated: true) {
            NSLog("Alert is shown")
        }
    }
    
    func setupButton() {
        let alertButton = UIButton(frame: CGRect(x: 20, y: 20, width: 100, height: 60))
        alertButton.setTitle("Alert", for: .normal)
        alertButton.backgroundColor = UIColor.red
        // задаем обработчик
        alertButton.addTarget(self, action: #selector(self.tappedAlertButton), for: .touchUpInside)
        // так же выравниваем по центру, чтобы не перегружать констрейнтами или анчорами
        alertButton.center = self.view.center
        self.view.addSubviews(alertButton)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupButton()
    }
    

}
