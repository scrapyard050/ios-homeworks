//
//  Checker.swift
//  Navigation
//
//  Created by Антон Соколов on 13.03.2022.
//

import Foundation

/// @brief  Выполняет проверку введенного логина и пароля
class Checker {
    // MARK: Public properties
    static var shared: Checker = {
        let instance = Checker()
        return instance
    }()
    
    // MARK: Private properties
    private let login = "Anton"
    private let passwd = "Ivanov"
    
    private init() {}
    
    // MARK: Public methods
    func checker(login: String, passwd: String) -> Bool {
        return self.login == login && self.passwd == passwd
    }
}

extension Checker : NSCopying {
    // в случае операции копирования возвращаем себя же
    func copy(with zone: NSZone? = nil) -> Any {
        return self
    }
}
