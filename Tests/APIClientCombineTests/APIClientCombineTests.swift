import XCTest
import Combine
@testable import APIClientCombine

enum TestEnvironment: APIEnvionment {
    case httpbin

    var baseUrl: String {
        return "https://httpbin.org"
    }
}

enum Path: APIEndpointPath {
    case json

    var value: String {
        return "/json"
    }
}

class HttpBinResponse: Codable {
    let slideshow: Slideshow
}

class Slideshow: Codable {
    let author: String
}

final class APIClientCombineTests: XCTestCase {

    private var cancellable: AnyCancellable?

    func testGet() {
        
        let endpoint = APIEndpoint(environment: TestEnvironment.httpbin, path: Path.json)
        let apiRequest = APIRequest(endpoint: endpoint)
        let successExpectation = expectation(description: "Success")
        
        cancellable = APIClient().execute(apiRequest: apiRequest)
            .sink { error in
                print(error)
            } receiveValue: { (object: HttpBinResponse) in
                print(object)
                successExpectation.fulfill()
            }
        
        wait(for: [successExpectation], timeout: 15.0)
    }

    static var allTests = [
        ("testGet", testGet),
    ]
}

