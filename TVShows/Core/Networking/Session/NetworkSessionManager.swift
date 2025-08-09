import Foundation

// MARK: - Session - Protocol
protocol NetworkSessionManager: Sendable {
   var urlSession: URLSession { get }
}

// MARK: - Session - Implementation
final class DefaultSessionManager: NetworkSessionManager {
   let urlSession: URLSession
   
   init(configuration: URLSessionConfiguration? = nil) {
      if let configuration {
         self.urlSession = URLSession(configuration: configuration)
         
      } else { // Default configuration
         let configuration = URLSessionConfiguration.default
         configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
         configuration.timeoutIntervalForRequest = 30.0
         configuration.timeoutIntervalForResource = 60.0
         self.urlSession = URLSession(configuration: configuration)
      }
   }
}
