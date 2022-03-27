import Foundation
import UIKit


//protocol Module {}
//
/////  @brief Фабричный метод для создания Модулей
//protocol CreateModule: AnyObject {
//    func factoryMethod() -> Module
//}

/// @brief Интерфейс определят контракт для запуска flow
protocol CoordinatableProtocol: AnyObject {
    var navigationController: UINavigationController? { get set} 
    func start()
}
