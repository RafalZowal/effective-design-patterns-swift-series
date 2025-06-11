//  Created by Rafal Zowal

import Foundation
import Core

struct CoreNetworkConfig: Config {
    private let enviroment: EnvironmentConfiguration
    private let useCache: Bool
    
    init(_ enviroment: EnvironmentConfiguration, useCache: Bool = false) {
        self.enviroment = enviroment
        self.useCache = useCache
    }
    
    func configure(_ injector: Injectorable) {
        injector.map(CoreNetworking.self, CoreNetworkService(configuration: enviroment,
                                                             useCache: useCache))
    }
}

struct InterceptorConfig: Config {
    func configure(_ injector: Injectorable) {
        injector.map(Interceptoring.self, Interceptor())
    }
}
