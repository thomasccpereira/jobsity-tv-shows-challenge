import Foundation

// MARK: - Cache - Protocol
protocol NetworkResponseCaching: Sendable {
   func cachedResponse(for request: URLRequest) -> Data?
   func store(_ data: Data, response: URLResponse, for request: URLRequest)
}

// MARK: - Cache - In-Memory implementation
final class DefaultNetworkResponseCache: NetworkResponseCaching {
   private let urlCache: URLCache
   
   public init(urlCache: URLCache = .shared) {
      self.urlCache = urlCache
   }
   
   func cachedResponse(for request: URLRequest) -> Data? {
      if let cached = urlCache.cachedResponse(for: request) { return cached.data }
      return nil
   }
   
   func store(_ data: Data, response: URLResponse, for request: URLRequest) {
      let cached = CachedURLResponse(response: response, data: data)
      urlCache.storeCachedResponse(cached, for: request)
   }
}
