//  Created by Rafal Zowal 

import Foundation
import Core

@testable import Network

struct CoreNetworkMock: CoreNetworking {
    
    private let code: HTTPResponseCode
    private let data: Data
    private let networkError: NetworkError
    
    init(_ code: HTTPResponseCode, _ data: Data, _ networkError: NetworkError = .invalidURL) {
        self.code = code
        self.data = data
        self.networkError = networkError
    }

    func dispatch(request: RequestData, response: @escaping ((DataTaskResult) -> Void)) {
        if code.isSuccess {
            response(.success((code, data)))
        } else {
            response(.failure(networkError))
        }
    }
}

struct CoreNetworkSuccessConfig: Config {
    func configure(_ injector: Injectorable) {
        injector.map(CoreNetworking.self,
                     CoreNetworkMock(.okay, APIServiceResponseMocks.success.data!))
    }
}

struct CoreNetworkSuccessNoDecConfig: Config {
    func configure(_ injector: Injectorable) {
        injector.map(CoreNetworking.self,
                     CoreNetworkMock(.okay, APIServiceResponseMocks.noDecodable.data!))
    }
}

struct CoreNetworkFailMockConfig: Config {
    func configure(_ injector: Injectorable) {
        injector.map(CoreNetworking.self,
                     CoreNetworkMock(.badRequest, Data(), .invalidURL))
    }
}
