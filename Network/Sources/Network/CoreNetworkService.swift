//  Created by Rafal Zowal

import Foundation

protocol CoreNetworking {
    func dispatch(request: RequestData, response: @escaping ((DataTaskResult) -> Void))
}

struct CoreNetworkService: CoreNetworking {
init(configuration: EnvironmentConfiguration = .production, useCache: Bool = false) {
        setup(configuration: configuration, useCache: useCache)
    }
    
    /// Sets up the configuration environment APIServices.
    /// If this endpoint is not defined, the default configuration will be set it up for production environment.
    /// The Environment Configuration can be changed at any moment by calling this endpoint.
    /// - Parameter configuration: Environments are listed on EnvironmentConfiguration for production,
    ///     tests environments or a custom.
    /// EnvironmentConfiguration includes baseURL, Web Address, Key and Secret.
    /// For cache system I will use URLCache - good article you can read here:
    ///     https://medium.com/@master13sust/to-nscache-or-not-to-nscache-what-is-the-urlcache-35a0c3b02598
    func setup(configuration: EnvironmentConfiguration = .production,
               useCache: Bool = false) {
        ServiceConfig.shared.setup(apiConfiguration: configuration, useCache: useCache)
    }

    func dispatch(request: RequestData, response: @escaping ((DataTaskResult) -> Void)) {
        let fullPath = request.baseURL.appending(request.path)

        guard let url = URL(string: fullPath) else {
            response(.failure(.invalidURL))
            return
        }

        var urlRequest: URLRequest

        if var components = URLComponents(string: fullPath), let parameters = request.params {
            components.queryItems = parameters.map({ (key, value) -> URLQueryItem in
                URLQueryItem(name: key, value: String(value))
            })
            urlRequest = URLRequest(url: components.url!)
        } else {
            urlRequest = URLRequest(url: url)
        }

        urlRequest.httpMethod = request.method.rawValue

        if let body = request.body {
            urlRequest.httpBody = body
        }

        if let serviceHeaders = request.headers {
            urlRequest.allHTTPHeaderFields = serviceHeaders
        }

        let config = URLSessionConfiguration.default
        config.requestCachePolicy = request.cachePolicy
        
        if !ServiceConfig.shared.useCache {
            config.urlCache =  nil
        }

        let session = URLSession.init(configuration: config)
        session.dataTask(with: urlRequest) { (data, urlResponse, error) in
            guard let httpResponse = urlResponse as? HTTPURLResponse else {
                response(.failure(.noInternetConnection))
                return
            }

            let status = httpResponse.statusCode
            let responseCode: HTTPResponseCode = HTTPResponseCode(rawValue: status) ?? .unknown

            if error != nil {
                response(.failure(.serverError(responseCode)))
            }
            
            if responseCode.isSuccess {
                guard let data = data else {
                    response(.failure(.noData))
                    return
                }
                response(.success((responseCode, data)))
            } else {
                response(.failure(.serverError(responseCode)))
            }
        }.resume()
    }
}
