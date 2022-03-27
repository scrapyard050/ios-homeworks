import Foundation
import UIKit

/// @brief Интерфейс определят контракт для запуска flow
protocol CoordinatableProtocol: AnyObject {
    var navigationController: UINavigationController? { get set} 
    func start()
}
