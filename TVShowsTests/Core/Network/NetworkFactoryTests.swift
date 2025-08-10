import Testing
import Foundation
@testable import TVShows

@Suite
struct NetworkFactoryTests {
   struct Thing: Codable, Equatable {
      let value: String
   }
   
   @Test func fetchesAndDecodes() async throws {
      let url = URL(string:"https://api.tvmaze.com/test")!
      let payload = try! JSONEncoder().encode(Thing(value: "ok"))
      StubURLProtocol.reset()
      StubURLProtocol.register(url: url, data: payload, statusCode: 200, headers: ["Content-Type":"application/json"])
      
      struct RC: NetworkRequestConfig {
         var host: String { "https://api.tvmaze.com" }
         var path: String { "/test" }
         var queryItems: [URLQueryItem]? { nil }
      }
      
      let deps = NetworkDependencies(sessionManager: StubSessionManager(),
                                     requestBuilder: DefaultRequestBuilder(),
                                     cacher: DefaultNetworkResponseCache(),
                                     logger: DefaultNetworkLogger(),
                                     errorMapper: DefaultErrorMapper(),
                                     validator: StatusCodeValidator(),
                                     decoder: JSONResponseDecoder())
      let factory = NetworkFactory(dependencies: deps)
      let thing: Thing = try await factory.fetch(requestConfig: RC())
      #expect(thing == Thing(value: "ok"))
   }
}
