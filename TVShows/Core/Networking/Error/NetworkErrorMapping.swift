import Foundation

// MARK: - Error mapper - Protocol
protocol NetworkErrorMapping: Sendable {
   func map(_ error: Error, url: URL?) -> NetworkError
}

// MARK: - Error mapper - Concrete implementation
final class DefaultErrorMapper: NetworkErrorMapping {
   init() { }
   
   func map(_ error: Error, url: URL?) -> NetworkError {
      if error is CancellationError { return .cancelled }
      
      // URLSession / Foundation errors
      if let urlError = error as? URLError {
         switch urlError.code {
         case .cancelled: return .cancelled
         case .notConnectedToInternet, .networkConnectionLost: return .noInternetConnection
         case .timedOut: return .timedOut
         default: break
         }
      }
      
      let networkError = error as? NetworkError
      return networkError ?? .genericError(error)
   }
}
