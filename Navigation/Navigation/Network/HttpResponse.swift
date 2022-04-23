
import Foundation

/// @brief Описание ошибок, структуры расширяема для описания ошибок друггих типов
///  Зарезервированно на будующее
struct ResponseError {
    enum HttpAnswer: Error {
        case badFormatRequest
        case badAnswer
        case noData
        case errorParseResponse
    }
}

/// @brief Обработчик ответов http
typealias CompletionHttpResponseHandler = (Result<Data, ResponseError.HttpAnswer>) -> Void
