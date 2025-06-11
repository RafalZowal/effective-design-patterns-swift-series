//  Created by Rafal Zowal

import Foundation
import Core

protocol Interceptoring {
    func accept(_ visitor: Visitorible, _ request: RequestDataBuilder)
}

class Interceptor: Interceptoring {
    @Inject private var service: CoreNetworking?
    
    static func setup(configs: [Config]? = nil,
                      enviroment: EnvironmentConfiguration = .production,
                      useCache: Bool = false) {
        guard let configs = configs else {
            return GlobalContext.shared.configure(localConfigs(enviroment, useCache)) {}
        }
        
        GlobalContext.shared.configure(configs) { }
    }
    
    static private func localConfigs(_ enviroment: EnvironmentConfiguration,
                                     _ useCache: Bool = false) -> [Config] {
        return [
            InterceptorConfig(),
            CoreNetworkConfig(enviroment, useCache: useCache)
        ]
    }
    
    func accept(_ visitor: Visitorible, _ request: RequestDataBuilder) {
        do {
            service?.dispatch(request: try request.create(), response: { visitor.visit($0) })
        } catch {
            visitor.visit(.failure(.invalidURL))
        }
    }
}
