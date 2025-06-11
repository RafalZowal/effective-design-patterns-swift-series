//  Created by Rafal Zowal 

import Foundation
import Core

public class ObserverFactory<T: Codable> {
    
    public init() { }
    
    public func executeRequest(_ request: RequestDataBuilder) -> Observer<T> {
        let observer = Observer<T>()
        let visitor = Visitor<T>(observer)
        DispatchCommand(visitor, request).execute()
        
        return observer
    }
}
