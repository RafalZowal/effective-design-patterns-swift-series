//  Created by Rafal Zowal 

import Foundation

typealias DataTaskResult = Result<(HTTPResponseCode, Data), NetworkError>
typealias RequestTypeResult = (Result<(HTTPResponseCode, Codable), NetworkError>) -> Void

struct NoContentResponse: Codable { }
