import Foundation

protocol NetworkExecutable: Sendable {
   func execute(request: URLRequest,
                shouldCache: Bool) async throws -> (data: Data, response: URLResponse)
}

extension NetworkExecutable {
   func execute(request: URLRequest) async throws -> (data: Data, response: URLResponse) {
      try await execute(request: request, shouldCache: false)
   }
}

public final class NetworkExecutor: NSObject, NetworkExecutable {
   // MARK: - Properties
   private let sessionManager: any NetworkSessionManager

   // MARK: - Init
   init(sessionManager: any NetworkSessionManager = DefaultSessionManager()) {
      self.sessionManager = sessionManager
   }

   // MARK: - NetworkExecutable methods
   func execute(request: URLRequest,
                shouldCache: Bool) async throws -> (data: Data, response: URLResponse) {
      let urlSession = sessionManager.urlSession
      let (data, response) = try await urlSession.data(for: request)
      return (data, response)
   }
}
