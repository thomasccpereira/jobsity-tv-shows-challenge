import Foundation

// MARK: - Request validator - Protocol
public protocol NetworkResponseValidator: Sendable {
   func validate(_ response: URLResponse,
                 data: Data) throws
}

// MARK: - Request validator - Implementation
struct StatusCodeValidator: NetworkResponseValidator {
   let validStatusCodes: Range<Int>
   
   func validate(_ response: URLResponse, data: Data) throws {
      guard let httpResponse = response as? HTTPURLResponse else {
         throw NetworkError.networkInvalidResponse
      }
      
      guard !validStatusCodes.contains(httpResponse.statusCode) else {
         return
      }
      
      let urlString = httpResponse.url?.absoluteString ?? ""
      
      switch httpResponse.statusCode {
      case 400...499:
         throw NetworkError.networkClientFailure(code: httpResponse.statusCode, url: urlString)
      case 500...599:
         throw NetworkError.networkServerFailure(code: httpResponse.statusCode, url: urlString)
      default:
         throw NetworkError.networkUnknownStatusCode(code: httpResponse.statusCode, url: urlString)
      }
   }
}
