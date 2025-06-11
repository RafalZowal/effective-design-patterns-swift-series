//  Created by Rafal Zowal 

import Foundation

protocol Observable {
    associatedtype ReturnType: Codable
    
    func addObserver(_ observer: Observer<ReturnType>)
}

protocol IObserver {
    associatedtype T: Codable
    
    func complete(_ result: ((Result<T?, Error>) -> Void)?)
}

public class Observer<Element: Codable>: IObserver {
    
    public typealias T = Element
    public var _result: ((Result<T?, Error>) -> Void)?
    
    public init() { }
    
    public func complete(_ result: ((Result<Element?, Error>) -> Void)?) {
        _result = result
    }
}
