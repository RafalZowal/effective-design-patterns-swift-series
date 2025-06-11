//  Created by Rafal Zowal 

import Foundation

protocol Contextible {
    var injector: Injectorable { get }
    func configure(_ configs: [Config], completion: () -> Void)
}

public struct Context: Contextible {
    private let _injector: Injectorable = Injector()
    
    public var injector: Injectorable {
        return _injector
    }
    
    public func configure(_ configs: [Config], completion: () -> Void) {
        for config in configs {
            config.configure(injector)
        }
        
        completion()
    }
}

public struct GlobalContext: Contextible {
    public static let shared = GlobalContext()
    private let context = Context()
    
    public var injector: Injectorable {
        return context.injector
    }

    private init() {}
    
    public func configure(_ configs: [Config], completion: () -> Void) {
        context.configure(configs, completion: completion)
    }
}

@propertyWrapper
public struct Inject<T> {
    private(set) var value: T?
    
    public var wrappedValue: T? {
        return GlobalContext.shared.injector.get(T.self)
    }
    
    public init(wrappedValue initialValue: T?) {
        value = initialValue
    }
}
