import Foundation

// MARK: - Network - Client protocol
public protocol NetworkClient: Sendable {
   func fetch<T: Decodable & Sendable>(request requestBuilder: some NetworkRequestBuilder,
                                       response: some NetworkResponseValidator,
                                       timeToLiveCache: TimeInterval) async throws -> T
}

// MARK: - Network - Default values
public extension NetworkClient {
   func fetch<T: Decodable & Sendable>(request requestBuilder: some NetworkRequestBuilder,
                                       response: some NetworkResponseValidator) async throws -> T {
      try await fetch(request: requestBuilder,
                      response: response,
                      timeToLiveCache: 300)
   }
}

// MARK: - Network - Client implementation
public final class NetworkExecutor: NetworkClient {
   // Properties
   private let sessionManager: any NetworkSessionManager
   private let cacheManager: any NetworkCacheManager
   private let networkLogger: any NetworkLogger
   
   public init(sessionManager: any NetworkSessionManager = DefaultSessionManager(),
               cacheMaganer: any NetworkCacheManager = InMemoryCacheManager(),
               networkLogger: any NetworkLogger = DefaultNetworkLogger()) {
      self.sessionManager = sessionManager
      self.cacheManager = cacheMaganer
      self.networkLogger = networkLogger
   }
   
   public func fetch<T: Decodable & Sendable>(request: some NetworkRequestBuilder,
                                              response: some NetworkResponseValidator,
                                              timeToLiveCache: TimeInterval) async throws -> T {
      let request = try request.buildRequest()
      let cacheKey = request.url?.absoluteString ?? ""
      
      networkLogger.logRequest(request)
      
      // Check cache first
      if let cached: T = await cacheManager.cachedData(for: cacheKey) {
         return cached
      }
      
      // Fetch fresh data
      let (data, urlResponse) = try await sessionManager.urlSession.data(for: request)
      networkLogger.logResponse(urlResponse, data: data)
      
      try response.validate(urlResponse, data: data)
      
      do {
         let decoder = JSONDecoder()
         let decodedOBject = try decoder.decode(T.self, from: data)
         
         // Update cache
         await cacheManager.cacheData(data, for: cacheKey, timeToLive: timeToLiveCache)
         
         return decodedOBject
         
      } catch {
         var decodingContext: DecodingError.Context?
         var decodingKey: (any CodingKey)?
         var decodingValueType: (any Any.Type)?
         var decodingTypeMismatch: (any Any.Type)?
         
         if case DecodingError.keyNotFound(let codingKey, let context) = error {
            decodingContext = context
            decodingKey = codingKey
            
         } else if case DecodingError.valueNotFound(let value, let context) = error {
            decodingContext = context
            decodingValueType = value
            
         } else if case DecodingError.typeMismatch(let type, let context) = error {
            decodingContext = context
            decodingTypeMismatch = type
         }
         
         if let contextInfo = decodingContext?.codingPath.filter ({ !$0.stringValue.isEmpty && $0.intValue == nil }).map ({ $0.stringValue }),
            let entity = contextInfo.first {
            
            if let key = decodingKey?.stringValue {
               throw NetworkError.decodingKeyNotFoundFailure(entity: entity, key: key)
               
            } else if let key = contextInfo.last, let valueType = decodingValueType {
               let value = String(describing: valueType)
               throw NetworkError.decodingValueNotFoundFailure(entity: entity, key: key, value: value)
               
            } else if let key = contextInfo.last, let typeMismatch = decodingTypeMismatch {
               let typeMismatch = String(describing: typeMismatch)
               throw NetworkError.decodingTypeMismatchFailure(entity: entity, key: key, type: typeMismatch)
            }
         }
         
         throw NetworkError.decodingGenericError(error: error)
      }
   }
}
