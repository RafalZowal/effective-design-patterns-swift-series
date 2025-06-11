//  Created by Rafal Zowal 

import Foundation

protocol Visitorible {
    func visit(_ result: DataTaskResult)
}

extension Visitorible {
    func decode<ResponseType: Codable>(from result: DataTaskResult,
                                       decodeType: ResponseType.Type,
                                       response: @escaping (RequestTypeResult)) {
        switch result {
        case .success((let responseCode, let responseData)):
            if responseCode == .noContent {
                response(.success((responseCode, NoContentResponse())))
            } else {
                do {
                    let jsonDecoder = JSONDecoder()
                    let result = try jsonDecoder.decode(ResponseType.self, from: responseData)
                    DispatchQueue.main.async {
                        response(.success((responseCode, result)))
                    }
                } catch {
                    DispatchQueue.main.async {
                        response(.failure(.noDecodable))
                    }
                }
            }
        case .failure(let networkError):
            DispatchQueue.main.async {
                response(.failure(networkError))
            }
        }
    }
}
