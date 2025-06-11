//  Created by Rafal Zowal 

import Foundation

public class RequestDataBuilder {
    public typealias BaseURL = String?
    public typealias Path = String
    public typealias Paramas = [String: String]?
    
    public init() {}
    
    enum BuilderErrors: Error {
        case wrongPath
        case missingMethod
    }
    
    public enum DataType {
        case baseURL(BaseURL)
        case path(Path)
        case method(HTTPMethod?)
        case params(Paramas)
        case body(Data?)
    }

    private var baseURL: BaseURL = nil
    private var path: Path? = nil
    private var method: HTTPMethod? = nil
    private var params: Paramas = nil
    private var body: Data? = nil
    
    public func make(_ type: DataType) -> RequestDataBuilder {
        switch type {
        case .baseURL(let baseURL):
            self.baseURL = baseURL
        case .path(let path):
            self.path = path
        case .method(let method):
            self.method = method
        case .params(let params):
            self.params = params
        case .body(let body):
            self.body = body
        }
        
        return self
    }
    
    func create() throws -> RequestData {
        guard let path = path else {
            throw BuilderErrors.wrongPath
        }
        guard let method = method else {
            throw BuilderErrors.missingMethod
        }
        
        return RequestData(path: path,
                           method: method,
                           params: params,
                           baseURL: baseURL,
                           body: body)
    }
}
