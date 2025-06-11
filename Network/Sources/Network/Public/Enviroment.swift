//  Created by Rafal Zowal

import Foundation

public struct APIConfiguration {
    public let baseURL: String
    public let webAddress: String
    public let key: String
    public let secret: String
}

public enum EnvironmentConfiguration {
    case production
    case test1
    case custom(configuration: APIConfiguration)

    public func getConfiguration() -> APIConfiguration {
        var baseURL: String
        var webAddress: String
        let key: String = ""
        let secret: String = ""
        switch self {
        case .production:
            baseURL = "https://api.flickr.com/services"
            webAddress = ""
        case .test1:
            baseURL = "https://api.flickr.com/services"
            webAddress = ""
        case .custom(let configuration):
            return configuration
        }
        return APIConfiguration(baseURL: baseURL, webAddress: webAddress, key: key, secret: secret)
    }
}
