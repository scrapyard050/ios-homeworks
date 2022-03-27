//
//  Checker.swift
//  Navigation
//
//  Created by Антон Соколов on 13.03.2022.
//

import Foundation

/// @brief  Выполняет проверку введенного логина и пароля
class Checker {
    static var shared: Checker = {
        let instance = Checker()
        return instance
    }()
    
    // проверка введенных данных
    func checker(login: String, passwd: String) -> Bool {
        return self.login == login && self.passwd == passwd
    }
    
    private let login = "Anton"
    private let passwd = "Ivanov"
    
    
    // запрещаем создание обьекта через конструктор
    private init() {}
}

extension Checker : NSCopying {
    // в случае операции копирования возвращаем себя же
    func copy(with zone: NSZone? = nil) -> Any {
        return self
    }
}
