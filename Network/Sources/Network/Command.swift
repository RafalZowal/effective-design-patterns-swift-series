//  Created by Rafal Zowal

import Foundation
import Core

public protocol Command {
    func execute()
}

class DispatchCommand: Command {
    @Inject private var receiver: Interceptoring?
    
    private let visitor: Visitorible
    private let request: RequestDataBuilder
    
    init(_ visitor: Visitorible, _ request: RequestDataBuilder) {
        self.visitor = visitor
        self.request = request
    }
    
    func execute() {
        receiver?.accept(visitor, request)
    }
}

public class NetworkSetupCommand: Command {
    private var configs: [Config]?
    private var cache: Bool
    private var enviroment: EnvironmentConfiguration = .production
    
    public init(configs: [Config]? = nil,
                enviroment: EnvironmentConfiguration = .production,
                useCache: Bool = false ) {
        self.configs = configs
        self.enviroment = enviroment
        self.cache = useCache
    }
    
    public func execute() {
        Interceptor.setup(configs: configs,
                      enviroment: enviroment,
                      useCache: cache)
    }
}
