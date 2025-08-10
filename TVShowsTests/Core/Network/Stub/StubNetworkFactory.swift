import Foundation
@testable import TVShows

struct StubNetworkFactory: NetworkFactoryType {
   var handler: (NetworkRequestConfig) throws -> any Decodable
   func fetch<Model>(requestConfig: NetworkRequestConfig, shouldCache: Bool) async throws -> Model where Model : Decodable {
      return try handler(requestConfig) as! Model
   }
}
