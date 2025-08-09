import Foundation

// MARK: - Cache - Protocol
public protocol NetworkCacheManager: Sendable {
   func cachedData<T: Decodable & Sendable>(for key: String) async -> T?
   
   func cacheData<T: Encodable & Sendable>(_ data: T,
                                           for key: String,
                                           timeToLive: TimeInterval) async
   
   func clearCache(for key: String) async
}

public extension NetworkCacheManager {
   func cacheData<T: Encodable & Sendable>(_ data: T,
                                           for key: String) async {
      await cacheData(data,
                      for: key,
                      timeToLive: 300)
   }
}

// MARK: - Cache - In-Memory implementation
public actor InMemoryCacheManager: NetworkCacheManager {
   // Properties
   private var cache: [String: (data: Data, expiration: Date)] = [:]
   
   // Init
   public init() { }
   
   // Protocol methods
   public func cachedData<T: Decodable & Sendable>(for key: String) async -> T? {
      guard let entry = cache[key],
            entry.expiration > Date() else {
         cache.removeValue(forKey: key)
         return nil
      }
      return try? JSONDecoder().decode(T.self, from: entry.data)
   }
   
   public func cacheData<T: Encodable & Sendable>(_ data: T,
                                           for key: String,
                                           timeToLive: TimeInterval) async {
      if let encoded = try? JSONEncoder().encode(data) {
         cache[key] = (
            data: encoded,
            expiration: Date().addingTimeInterval(timeToLive)
         )
      }
   }
   
   public func clearCache(for key: String) async {
      cache.removeValue(forKey: key)
   }
}
