import Foundation

// MARK: - Network Factory - Protocol
protocol NetworkFactoring: Sendable {
   func fetch<Model: Decodable>(requestConfig: NetworkRequestConfig,
                                cacheTTL: Duration) async throws -> Model
}

// MARK: - Network Factory - Default implementation without cache
extension NetworkFactoring {
   func fetch<Model: Decodable>(requestConfig: NetworkRequestConfig) async throws -> Model {
      try await fetch(requestConfig: requestConfig,
                      cacheTTL: .seconds(300))
   }
}

// MARK: - Network Factory - Concrete implementation
final class NetworkFactory: NetworkFactoring {
   private let dependencies: NetworkDependencies
   
   init(dependencies: NetworkDependencies = .default) {
      self.dependencies = dependencies
   }
   
   func fetch<Model: Decodable>(requestConfig: NetworkRequestConfig,
                                cacheTTL: Duration) async throws -> Model {
      let request = try dependencies.requestBuilder.makeRequest(with: requestConfig)
      dependencies.logger.logRequest(request)
      
      if let cached = await dependencies.cacher.cachedResponse(for: request) {
         dependencies.logger.logCacheHit(for: request)
         do { return try dependencies.decoder.decode(Model.self, from: cached) }
         catch {
            await dependencies.cacher.clearCache(for: request)
            dependencies.logger.logCacheDecodeFailure(error, for: request)
         }
      } else if cacheTTL != .zero {
         dependencies.logger.logCacheMiss(for: request)
      }
      
      do {
         let executor: any NetworkExecuting = NetworkExecutor(sessionManager: dependencies.sessionManager)
         let (data, response) = try await executor.execute(request: request)
         dependencies.logger.logResponse(response, data: data)
         
         guard let http = response as? HTTPURLResponse else {
            throw NetworkError.networkInvalidResponse
         }
         
         try dependencies.validator.validate(http, data: data)
         await dependencies.cacher.store(data, response: response, for: request, ttl: cacheTTL)
         
         return try dependencies.decoder.decode(Model.self, from: data)
         
      } catch {
         await dependencies.cacher.clearCache(for: request)
         throw dependencies.errorMapper.map(error, url: request.url)
      }
   }
}
