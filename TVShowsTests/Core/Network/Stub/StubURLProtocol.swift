import Foundation
@testable import TVShows

final class StubURLProtocol: URLProtocol {
   struct Response {
      let data: Data
      let statusCode: Int
      let headers: [String:String]?
   }
   
   static var responseForURL: [URL: Response] = [:]
   static func register(url: URL, data: Data, statusCode: Int = 200, headers: [String:String]? = ["Content-Type":"application/json"]) {
      responseForURL[url] = .init(data: data, statusCode: statusCode, headers: headers)
   }
   
   static func reset() { responseForURL = [:] }
   
   override class func canInit(with request: URLRequest) -> Bool { true }
   override class func canonicalRequest(for request: URLRequest) -> URLRequest { request }
   override func startLoading() {
      guard let url = request.url, let hit = StubURLProtocol.responseForURL[url] else {
         client?.urlProtocol(self, didFailWithError: URLError(.badURL))
         return
      }
      let response = HTTPURLResponse(url: url, statusCode: hit.statusCode, httpVersion: "HTTP/1.1", headerFields: hit.headers)!
      client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
      client?.urlProtocol(self, didLoad: hit.data)
      client?.urlProtocolDidFinishLoading(self)
   }
   
   override func stopLoading() {}
}
