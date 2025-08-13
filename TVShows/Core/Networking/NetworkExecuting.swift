import Foundation

// MARK: - Network executor - Protocol
protocol NetworkExecuting: Sendable {
   func execute(request: URLRequest) async throws -> (data: Data, response: URLResponse)
}

// MARK: - Network executor - Concrete implementation
final class NetworkExecutor: NSObject, NetworkExecuting {
   // MARK: - Properties
   private let sessionManager: any NetworkSessionManaging
   
   // MARK: - Init
   init(sessionManager: any NetworkSessionManaging = DefaultSessionManager()) {
      self.sessionManager = sessionManager
   }
   
   // MARK: - NetworkExecutable methods
   func execute(request: URLRequest) async throws -> (data: Data, response: URLResponse) {
      let urlSession = sessionManager.urlSession
      let (data, response) = try await urlSession.data(for: request)
      return (data, response)
   }
}
