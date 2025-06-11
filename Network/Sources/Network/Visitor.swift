//  Created by Rafal Zowal 

import Foundation

class Visitor<T: Codable>: Observable, Visitorible {
    typealias ReturnType = T
    
    private var subscribers = [Observer<ReturnType>]()
    
    init() {}
    
    init(_ observer: Observer<ReturnType>) {
        addObserver(observer)
    }
    
    func addObserver(_ observer: Observer<ReturnType>) {
        subscribers.append(observer)
    }
    
    func visit(_ result: DataTaskResult) {
        self.decode(from: result, decodeType: ReturnType.self) { response in
            switch response {
            case let .success((_, result)):
                self.subscribers.forEach( { $0._result?(.success(result as? T)) })
            case .failure(let error):
                self.subscribers.forEach( { $0._result?(.failure(error)) })
            }
        }
    }
}
