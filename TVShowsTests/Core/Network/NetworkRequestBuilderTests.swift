import Testing
import Foundation
@testable import TVShows

@Suite
struct NetworkRequestBuilderTests {
   @Test func buildsURLRequestWithQueryHeadersAndBody() throws {
      struct RC: NetworkRequestConfig {
         let path: String = "/shows"
         var method: HTTPMethod { .get }
         var headers: HTTPHeaders? { ["Accept":"application/json"] }
         var queryItems: [URLQueryItem]? { [URLQueryItem(name:"page", value:"2")] }
         var body: HTTPBody? { nil }
      }
      let builder = DefaultRequestBuilder()
      let request = try builder.makeRequest(with: RC())
      #expect(request.url?.absoluteString == "https://api.tvmaze.com/shows?page=2")
      #expect(request.httpMethod == "GET")
      #expect(request.value(forHTTPHeaderField: "Accept") == "application/json")
   }
}
