//
//  InfoViewController.swift
//  Navigation
//
//  Created by Антон Соколов on 20.10.2021.
//

import UIKit

class InfoViewController: UIViewController {
    
    private(set) lazy var jsonInfoSerializationTitle:UILabel =  {
        var info = UILabel()
        info.font = UIFont.boldSystemFont(ofSize: 18)
        info.textColor = UIColor.black
        info.toAutoLayout()
        return info
    }()
    
    private(set) lazy var jsonInfoSerializationPlanetInfo:UILabel =  {
        var info = UILabel()
        info.font = UIFont.boldSystemFont(ofSize: 18)
        info.textColor = UIColor.black
        info.toAutoLayout()
        return info
    }()
    
    // MARK: Life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        /// @todo не стал заворачивать это все в координатор, потому что нет соответствующего условия в задачи, да и лэйблы носят сугубо тестовый оттенок для вывода информации
        ///  в методе просто обращаемся к сервисам для получения информации
        self.jsonInfo()
    }
    
    private func jsonInfo() {
        NetworkService.shared.sendRequest(url: "https://jsonplaceholder.typicode.com/todos/", responseHandler: { result in
            // ответ пришел из другой очереди, поскольку сетевые запросу выполняются в бэкграйнде
            // поскольку отображем информацию в UI то переключаемся на главную очередь
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    self.jsonInfoSerializationTitle.text =  HttpDecoder.shared.decodeData(mode: .standartJsonSerialization, data: data)
                case.failure(let error):
                    self.jsonInfoSerializationTitle.text = error.localizedDescription
                }
            }
        })
        
        NetworkService.shared.sendRequest(url: "https://swapi.dev/api/planets/1/", responseHandler: { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    self.jsonInfoSerializationPlanetInfo.text =  HttpDecoder.shared.decodeData(mode: .decodable, data: data)
                case.failure(let error):
                    self.jsonInfoSerializationPlanetInfo.text = error.localizedDescription
                }
            }
        })
    }
                                          private func setupUI() {
        let alertButton = UIButton(frame: CGRect(x: 20, y: 20, width: 100, height: 60))
        alertButton.setTitle("Alert", for: .normal)
        alertButton.backgroundColor = UIColor.red
        // задаем обработчик
        alertButton.addTarget(self, action: #selector(self.tappedAlertButton), for: .touchUpInside)
        // так же выравниваем по центру, чтобы не перегружать констрейнтами или анчорами
        alertButton.center = self.view.center
        self.view.addSubviews(alertButton)
        
        self.view.addSubviews(self.jsonInfoSerializationPlanetInfo)
        self.view.addSubviews(self.jsonInfoSerializationTitle)
        let labelTestConstraint = 50.0
        
        let constraints = [
            self.jsonInfoSerializationPlanetInfo.widthAnchor.constraint(equalToConstant: labelTestConstraint),
            self.jsonInfoSerializationPlanetInfo.heightAnchor.constraint(equalToConstant: labelTestConstraint),
            self.jsonInfoSerializationPlanetInfo.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: labelTestConstraint),
            self.jsonInfoSerializationPlanetInfo.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -labelTestConstraint),
            self.jsonInfoSerializationPlanetInfo.topAnchor.constraint(equalTo: self.view.topAnchor, constant: labelTestConstraint),
            
            self.jsonInfoSerializationTitle.widthAnchor.constraint(equalToConstant: labelTestConstraint),
            self.jsonInfoSerializationTitle.heightAnchor.constraint(equalToConstant: labelTestConstraint),
            self.jsonInfoSerializationTitle.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: labelTestConstraint),
            self.jsonInfoSerializationTitle.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -labelTestConstraint),
            self.jsonInfoSerializationTitle.topAnchor.constraint(equalTo: self.jsonInfoSerializationPlanetInfo.bottomAnchor, constant: labelTestConstraint)
        ]
    
        NSLayoutConstraint.activate(constraints)
       
    }
    
    
    // MARK: Handlers and private methods
    @objc private func tappedAlertButton(sender: UIButton) {
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
}
