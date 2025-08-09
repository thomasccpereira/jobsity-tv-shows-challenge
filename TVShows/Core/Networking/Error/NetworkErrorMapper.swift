import Foundation

protocol NetworkErrorMapping: Sendable {
   func map(_ error: Error, url: URL?) -> NetworkError
}

final class DefaultErrorMapper: NetworkErrorMapping {
   init() { }
   
   func map(_ error: Error, url: URL?) -> NetworkError {
      if let err = error as? NetworkError { return err }
      return .genericError(error)
   }
}
