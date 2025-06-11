//  Created by Rafal Zowal 

import Foundation

// Simply and primitive Depedency Injection Container system
public protocol Injectorable {
    func map<T>(_ type: T.Type, _ object: Any)
    func get<T>(_ type: T.Type) -> T?
}

public final class Injector: Injectorable {
    private var mapping = [String : Any]()
    
    public func map<T>(_ type: T.Type, _ object: Any) {
        let key = mappingId(type)
        mapping[key] = object
    }
    
    public func get<T>(_ type: T.Type) -> T? {
        let key = mappingId(type)
        return get(key: key)
    }
    
    private func get<T>(key: String) -> T? {
        guard let returnObject = mapping[key] as? T else {
            return nil
        }
        
        return returnObject
    }
    
    private func mappingId<T>(_ instance: T.Type) -> String {
        return String(describing: instance)
    }
}

