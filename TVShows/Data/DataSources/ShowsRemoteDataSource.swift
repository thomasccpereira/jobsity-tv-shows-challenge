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
      do {
         let requestConfig: ShowRequestConfigs = .listShows(page: page)
         let object: ShowsListDTO = try await networkFactory.fetch(requestConfig: requestConfig)
         return object
         
      } catch {
         if case NetworkError.networkClientFailure(let response, _) = error {
            if page > 0 && response.statusCode == 404 {
               return ShowsListDTO()
            }
         }
         
         throw error
      }
   }
      return object
   }
}
