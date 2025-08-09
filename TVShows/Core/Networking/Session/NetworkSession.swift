import Foundation

// MARK: - Session - Protocol
public protocol NetworkSessionManager: Sendable {
   var urlSession: URLSession { get }
}

// MARK: - Session - Implementation
public final class DefaultSessionManager: NetworkSessionManager {
   // Properties
   private let configuration: URLSessionConfiguration
   public var urlSession: URLSession {
      let sessionConfiguration = configuration
      return URLSession(configuration: sessionConfiguration)
   }
   
   // Init
   public init(configuration: URLSessionConfiguration? = nil) {
      if let configuration {
         self.configuration = configuration
         
      } else { // Default configuration
         let configuration = URLSessionConfiguration.default
         configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
         configuration.timeoutIntervalForRequest = 30.0
         configuration.timeoutIntervalForResource = 60.0
         self.configuration = configuration
      }
   }
}
