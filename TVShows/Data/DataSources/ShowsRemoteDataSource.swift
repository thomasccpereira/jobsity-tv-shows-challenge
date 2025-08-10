import Foundation

protocol ShowsRemoteDataSource: Sendable {
   func shows(page: Int) async throws -> ShowsListDTO
   func episodes(showID: Int) async throws -> EpisodesListDTO
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
         if case NetworkError.networkClientFailure(let statusCode, _) = error {
            if page > 0 && statusCode == 404 {
               return ShowsListDTO()
            }
         }
         
         throw error
      }
   }
   func episodes(showID: Int) async throws -> EpisodesListDTO {
      let requestConfig: ShowRequestConfigs = .getDetailedShow(showID: showID)
      let object: EpisodesListDTO = try await networkFactory.fetch(requestConfig: requestConfig)
      return object
   }
}
