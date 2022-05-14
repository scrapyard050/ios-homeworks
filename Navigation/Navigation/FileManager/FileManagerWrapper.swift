//
//  File.swift
//  Navigation
//
//  Created by Антон Соколов on 14.05.2022.
//

import Foundation
import UIKit

/// @todo В будущем слои отвещающие за работу с данными переедут в отдельную группу, чтобы упорядочить данные
/// @brief Класс Работает с файловой системой
class FileManagerWrapper {
    
    /// @brief Проверка является ли директория пустой
    func isDocumentsDirEmpty() -> Bool {
        return self.contentsDir().isEmpty
    }
    
    /// @brief Возвращаем содержимое директории Документы
    func documentsDir () -> [URL] {
        return self.contentsDir()
    }
    
    func addPhoto(image: UIImage, name: String) {
        let data = image.jpegData(compressionQuality: 0.5)
        do {
            let imagePath = try documentsPath().appendingPathComponent(name)
            FileManager.default.createFile(atPath: imagePath.path, contents: data)
        }catch let error {
            print(error.localizedDescription)
        }
    }
    
    /// @brief Путь до диретории Documents
    private func documentsPath() throws -> URL  {
        let documentsDir =  try FileManager.default.url(for: .documentDirectory,
                                                        in: .userDomainMask,
                                                        appropriateFor: nil,
                                                        create: false)
        
        return documentsDir
    }
    
    /// @brief Содержимое директории Documents
    private func contentsDir() -> [URL] {
        var data: [URL] = []
        do {
            data = try FileManager.default.contentsOfDirectory(at: documentsPath(), includingPropertiesForKeys: nil, options: [.skipsHiddenFiles])
            return data
        }catch let error {
            print(error.localizedDescription)
            return data
        }
    }
}
