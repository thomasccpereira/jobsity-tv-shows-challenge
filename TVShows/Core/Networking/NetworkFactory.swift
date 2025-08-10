import Foundation

protocol NetworkFactoryType: Sendable {
   func fetch<Model: Decodable>(requestConfig: NetworkRequestConfig,
                                shouldCache: Bool) async throws -> Model
}

extension NetworkFactoryType {
   func fetch<Model: Decodable>(requestConfig: NetworkRequestConfig) async throws -> Model {
      try await fetch(requestConfig: requestConfig,
                      shouldCache: false)
   }
}

final class NetworkFactory: NetworkFactoryType {
   private let dependencies: NetworkDependencies
   
   init(dependencies: NetworkDependencies = .default) {
      self.dependencies = dependencies
   }
   
   func fetch<Model: Decodable>(requestConfig: NetworkRequestConfig,
                                shouldCache: Bool) async throws -> Model {
      
      let request = try dependencies.requestBuilder.makeRequest(with: requestConfig)
      
      // Check cache
      if let cached = dependencies.cacher.cachedResponse(for: request),
            let decodedCached = try? dependencies.decoder.decode(Model.self, from: cached) {
         return decodedCached
      }
      
      dependencies.logger.logRequest(request)
      
      do {
         let executor: any NetworkExecutable = NetworkExecutor(sessionManager: dependencies.sessionManager)
         let (data, response) = try await executor.execute(request: request, shouldCache: shouldCache)
         dependencies.logger.logResponse(response, data: data)
         
         guard let http = response as? HTTPURLResponse else {
            throw NetworkError.networkInvalidResponse
         }
         try dependencies.validator.validate(http, data: data)
         
         if shouldCache {
            dependencies.cacher.store(data, response: response, for: request)
         }
         
         return try dependencies.decoder.decode(Model.self, from: data)
         
      } catch {
         dependencies.cacher.clearCache(for: request)
         throw dependencies.errorMapper.map(error, url: request.url)
      }
   }
}
