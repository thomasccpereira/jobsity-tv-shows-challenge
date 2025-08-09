import Foundation

// MARK: - Request decoder - Protocol
protocol NetworkResponseDecoding: Sendable {
   func decode<T: Decodable>(_ type: T.Type, from data: Data) throws -> T
}

// MARK: - Request decoder - Implementation
struct JSONResponseDecoder: NetworkResponseDecoding {
   private let decoder: JSONDecoder
   
   init(_ decoder: JSONDecoder = JSONDecoder()) {
      self.decoder = decoder
   }
   
   func decode<T: Decodable>(_ type: T.Type, from data: Data) throws -> T {
      do {
         return try decoder.decode(T.self, from: data)
         
      } catch let DecodingError.keyNotFound(key, context) {
         throw NetworkError.decodingKeyNotFoundFailure(entity: context.codingPath.map(\.stringValue).joined(separator: "."),
                                                       key: key.stringValue)
         
      } catch let DecodingError.valueNotFound(value, context) {
         throw NetworkError.decodingValueNotFoundFailure(entity: context.codingPath.map(\.stringValue).joined(separator: "."),
                                                         key: context.debugDescription,
                                                         value: String(describing: value))
         
      } catch let DecodingError.typeMismatch(type, context) {
         throw NetworkError.decodingTypeMismatchFailure(entity: context.codingPath.map(\.stringValue).joined(separator: "."),
                                                        key: context.debugDescription,
                                                        type: String(describing: type))
         
      } catch {
         throw NetworkError.decodingGenericError(error: error)
      }
   }
}
