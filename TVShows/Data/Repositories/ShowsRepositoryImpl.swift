import Foundation

final class ShowsRepositoryImpl: ShowsRepository {
   private let remote: ShowsRemoteDataSource
   
   init(remote: ShowsRemoteDataSource = ShowsRemoteDataSourceImpl()) {
      self.remote = remote
   }
   
   func fetchShows(page: Int) async throws -> Page<SingleShowModel> {
      let dtos = try await remote.shows(page: page)
      let items = dtos.domainModelObject
      let hasNextPage = !items.shows.isEmpty
      let errorMessage = dtos.error?.previous?.message ?? dtos.error?.message
      
      return Page(items: items.shows,
                  pageIndex: page,
                  hasNextPage: hasNextPage,
                  errorMessage: errorMessage)
   }
   }
}
