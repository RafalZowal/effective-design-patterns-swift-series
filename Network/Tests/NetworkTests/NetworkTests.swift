import XCTest
@testable import Network

class NetworkTests: Core {
    func test_dispatch_request_success() {
        NetworkSetupCommand(configs: successConfigs).execute()
        let exp = expectation(description: "activities response success")
        
        let request = RequestDataBuilder()
            .make(.path("/search?query=harry"))
            .make(.method(.get))
                  
        ObserverFactory<SearchResponse>().executeRequest(request).complete { response in
            if case Result.success(_) = response {
                exp.fulfill()
            }
        }
        
        wait(for: [exp], timeout: 2.0)
    }
    
    func test_dispatch_request_fail() {
        NetworkSetupCommand(configs: badRequestConfigs).execute()
        let exp = expectation(description: "activities response success")

        let request = RequestDataBuilder()
            .make(.path("/search?query=harry"))
            .make(.method(.get))
        
        ObserverFactory<SearchResponse>().executeRequest(request).complete { response in
            if case Result.failure(_) = response {
                exp.fulfill()
            }
        }
       
        wait(for: [exp], timeout: 2.0)
    }
    
    func test_dispatch_no_decodable_data() {
        NetworkSetupCommand(configs: noDecodableConfigs).execute()
        let exp = expectation(description: "activities response success")
        
        let request = RequestDataBuilder()
            .make(.path("/search?query=harry"))
            .make(.method(.get))
        
        ObserverFactory<SearchResponse>().executeRequest(request).complete { response in
            if case let Result.failure(error) = response {
                if error as! NetworkError == NetworkError.noDecodable {
                    exp.fulfill()
                } else {
                    XCTFail("Unexpected error type")
                }
            }
        }

        wait(for: [exp], timeout: 2.0)
    }
    
    func test_wrong_request_data() {
        // wrong request data are exactly the same like request fail
        // what I saw we are using htmal feedback - what also give me a clue I should deceode
        // resposne after checking the content type first
    }

    static var allTests = [
        ("test_dispatch_request_success", test_dispatch_request_success),
        ("test_dispatch_request_fail", test_dispatch_request_fail),
        ("test_dispatch_no_decodable_data", test_dispatch_no_decodable_data),
        ("test_wrong_request_data", test_wrong_request_data),
    ]
}
