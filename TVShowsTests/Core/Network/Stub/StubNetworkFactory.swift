import Foundation
@testable import TVShows

struct StubNetworkFactory: NetworkFactoring {
   var handler: @Sendable (NetworkRequestConfig) throws -> any Decodable
   func fetch<Model>(requestConfig: NetworkRequestConfig, cacheTTL: Duration) async throws -> Model where Model : Decodable {
      return try handler(requestConfig) as! Model
   }
}
