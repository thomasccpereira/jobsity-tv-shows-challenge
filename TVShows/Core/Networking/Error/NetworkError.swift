import Foundation

enum NetworkError: Error, Equatable, Sendable {
   static func == (lhs: NetworkError, rhs: NetworkError) -> Bool {
      switch (lhs, rhs) {
      case (.genericError(let lError), .genericError(let rError)):
         lError.localizedDescription == rError.localizedDescription
         
      case (.noInternetConnection, .noInternetConnection):
         true
         
      case (.cancelled, .cancelled):
         true
         
      case (.timedOut, .timedOut):
         true
         
      case (.networkBadRequest, .networkBadRequest):
         true
         
      case (.networkRequestBuildFailure, .networkRequestBuildFailure):
         true
         
      case (.networkClientFailure(let lCode, let lUrl), .networkClientFailure(let rCode, let rUrl)):
         lCode == rCode && lUrl == rUrl
         
      case (.networkServerFailure(let lCode, let lUrl), .networkServerFailure(let rCode, let rUrl)):
         lCode == rCode && lUrl == rUrl
         
      case (.networkUnknownStatusCode(let lCode, let lUrl), .networkUnknownStatusCode(let rCode, let rUrl)):
         lCode == rCode && lUrl == rUrl
         
      case (.networkInvalidResponse, .networkInvalidResponse): true
         
      case (.networkInvalidStatusCode(let lCode, let lUrl), .networkInvalidStatusCode(let rCode, let rUrl)):
         lCode == rCode && lUrl == rUrl
         
      case (.decodingGenericError(let lError), .decodingGenericError(let rError)):
         lError.localizedDescription == rError.localizedDescription
         
      case (.decodingKeyNotFoundFailure(let lEntity, let lKey), .decodingKeyNotFoundFailure(let rEntity, let rKey)):
         lEntity == rEntity && lKey == rKey
         
      case (.decodingValueNotFoundFailure(let lEntity, let lKey, let lValue), .decodingValueNotFoundFailure(let rEntity, let rKey, let rValue)):
         lEntity == rEntity && lKey == rKey && lValue == rValue
         
      case (.decodingTypeMismatchFailure(let lEntity, let lKey, let lType), .decodingTypeMismatchFailure(let rEntity, let rKey, let rType)):
         lEntity == rEntity && lKey == rKey && lType == rType
         
      default: false
      }
   }
   
   // Generic
   case genericError(Error)
   case noInternetConnection
   case cancelled
   case timedOut
   
   // Request
   case networkBadRequest
   case networkRequestBuildFailure
   
   // Client
   case networkClientFailure(code: Int, url: String)
   
   // Server
   case networkServerFailure(code: Int, url: String)
   case networkServerStatusError(message: String)
   case networkUnknownStatusCode(code: Int, url: String)
   
   // Response
   case networkInvalidResponse
   case networkInvalidStatusCode(code: Int, url: String)
   
   // Decoding
   case decodingGenericError(error: Error)
   case decodingKeyNotFoundFailure(entity: String, key: String)
   case decodingValueNotFoundFailure(entity: String, key: String, value: String)
   case decodingTypeMismatchFailure(entity: String, key: String, type: String)
}
