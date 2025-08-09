import Foundation

protocol ShowsRemoteDataSource: Sendable {
   func shows(page: Int) async throws -> ShowsListDTO
struct ShowsRemoteDataSourceImpl: ShowsRemoteDataSource {
   private let networkFactory: any NetworkFactoryType
   
   init(networkFactory: any NetworkFactoryType = NetworkFactory()) {
      self.networkFactory = networkFactory
   }
   
   // MARK: Endpoints
   func shows(page: Int) async throws -> ShowsListDTO {
      let requestConfig: ShowRequestConfigs = .listShows(page: page)
      return try await request(requestConfig, as: ShowsListDTO.self)
   }
}

// MARK: - Private helpers
private extension ShowsRemoteDataSourceImpl {
   func request<T: Decodable>(_ requestConfig: ShowRequestConfigs, as type: T.Type) async throws -> T {
      let object: T = try await networkFactory.fetch(requestConfig: requestConfig)
      return object
   }
}
