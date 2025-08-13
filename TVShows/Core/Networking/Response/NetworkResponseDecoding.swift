import Foundation

// MARK: - Request decoder - Protocol
protocol NetworkResponseDecoding: Sendable {
   func decode<T: Decodable>(_ type: T.Type, from data: Data) throws -> T
}

// MARK: - Request decoder - Concrete implementation
struct JSONResponseDecoder: NetworkResponseDecoding {
   private let decoder: JSONDecoder
   
   init(_ decoder: JSONDecoder = JSONDecoder()) {
      self.decoder = decoder
   }
   
   func decode<T: Decodable>(_ type: T.Type, from data: Data) throws -> T {
      do {
         return try decoder.decode(T.self, from: data)
         
      } catch let DecodingError.keyNotFound(key, _) {
         let entity = String(describing: T.self)
         let key = key.stringValue
         
         throw NetworkError.decodingKeyNotFoundFailure(entity: entity,
                                                       key: key)
         
      } catch let DecodingError.valueNotFound(value, context) {
         let entity = String(describing: T.self)
         let infoTexts = context.codingPath.filter ({ !$0.stringValue.isEmpty && $0.intValue == nil }).map ({ $0.stringValue })
         let key = infoTexts.last ?? ""
         let value = String(describing: value)
         
         throw NetworkError.decodingValueNotFoundFailure(entity: entity,
                                                         key: key,
                                                         value: value)
         
      } catch let DecodingError.typeMismatch(type, context) {
         let entity = String(describing: T.self)
         let infoTexts = context.codingPath.filter ({ !$0.stringValue.isEmpty && $0.intValue == nil }).map ({ $0.stringValue })
         let key = infoTexts.last ?? ""
         let type = String(describing: type)
         
         throw NetworkError.decodingTypeMismatchFailure(entity: entity,
                                                        key: key,
                                                        type: type)
         
      } catch {
         throw NetworkError.decodingGenericError
      }
   }
}
