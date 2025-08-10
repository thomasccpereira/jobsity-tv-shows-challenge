import Foundation
@testable import TVShows

final class StubSessionManager: NetworkSessionManager {
   let urlSession: URLSession
   init() {
      let config = URLSessionConfiguration.ephemeral
      config.protocolClasses = [StubURLProtocol.self]
      urlSession = URLSession(configuration: config)
   }
}
