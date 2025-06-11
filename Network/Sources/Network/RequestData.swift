//  Created by Rafal Zowal 

import Foundation

struct RequestData {
    let baseURL: String
    let path: String
    let method: HTTPMethod
    let params: [String: String]?
    let headers: [String: String]?
    let body: Data?
    let decoder: JSONDecoder
    let cachePolicy: NSURLRequest.CachePolicy
    
    init(path: String,
         method: HTTPMethod,
         params: [String: String]? = nil,
         headers: [String: String]? = nil,
         baseURL: String? = nil,
         body: Data? = nil,
         decoder: JSONDecoder = JSONDecoder(),
         cachePolicy: NSURLRequest.CachePolicy = ServiceConfig.shared.useCache ? .returnCacheDataElseLoad : .useProtocolCachePolicy) {
        
        self.baseURL = baseURL ?? ServiceConfig.shared.currentConfiguration.baseURL
        self.path = path
        self.method = method
        self.params = params
        self.headers = headers
        self.body = body
        self.decoder = decoder
        self.cachePolicy = cachePolicy
    }
}
