//  Created by Rafal Zowal

import Foundation

public enum HTTPResponseCode: Int {
    case okay = 200
    case created = 201
    case noContent = 204
    case notModified = 304
    case badRequest = 400
    case unauthorized = 401
    case notFound = 404
    case validationError = 422
    case internalServerError = 500
    case unknown
}

extension HTTPResponseCode {
    
    var isSuccess: Bool {
        200 ..< 300 ~= self.rawValue
    }
}

public enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}
