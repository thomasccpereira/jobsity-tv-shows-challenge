import Foundation

final class ShowsRepositoryImpl: ShowsRepository {
   private let remote: ShowsRemoteDataSource
   
   init(remote: ShowsRemoteDataSource = ShowsRemoteDataSourceImpl()) {
      self.remote = remote
   }
   
   func fetchShows(page: Int) async throws -> Page<SingleShowModel> {
      do {
         let dtos = try await remote.shows(page: page)
         let items = dtos.domainModelObject
         
         return Page(items: items.shows,
                     pageIndex: page,
                     hasNextPage: true)
         
      } catch {
         if page > 0,
            case NetworkError.networkClientFailure(let code, _) = error,
            code == 404 {
            
            return Page(items: [],
                        pageIndex: page,
                        hasNextPage: false)
         }
         
         throw error
      }
   }
   }
}
