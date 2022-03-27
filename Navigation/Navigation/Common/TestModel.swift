//
//  TestModel.swift
//  Navigation
//
//  Created by Антон Соколов on 13.03.2022.
//

import Foundation
class TestModel {
    typealias ComplitaionHandler = (Bool) -> Void
    private let testMessage = "Hello"
    func check(word: String, completionHandler: ComplitaionHandler) {
        if testMessage != word {
            completionHandler(false)
            return
        }

        completionHandler(true)
    }
    
}

