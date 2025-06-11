//  Created by Rafal Zowal 

import Foundation

public enum NetworkError: Error, Equatable {
    case invalidURL
    case serverError(HTTPResponseCode)
    case noData
    case noDecodable
    case failedEncoding
    case responseError(code: Int?, type: String?, detail: String?)
    case noInternetConnection
}
