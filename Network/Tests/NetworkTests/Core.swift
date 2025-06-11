//  Created by Rafal Zowal 

import XCTest
import Core

@testable import Network

class Core: XCTestCase {
    
    var successConfigs: [Config] = [CoreNetworkSuccessConfig(), InterceptorConfig()]
    var badRequestConfigs: [Config] = [CoreNetworkFailMockConfig(), InterceptorConfig()]
    var noDecodableConfigs: [Config] = [CoreNetworkSuccessNoDecConfig(), InterceptorConfig()]
}

