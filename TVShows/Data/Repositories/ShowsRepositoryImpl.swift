import Foundation

final class ShowsRepositoryImpl: ShowsRepository {
   private let remote: ShowsRemoteDataSource
   
   init(remote: ShowsRemoteDataSource = ShowsRemoteDataSourceImpl()) {
      self.remote = remote
   }
   
   func fetchShows(page: Int) async throws -> Page<SingleShowModel> {
      let dtos = try await remote.shows(page: page)
      let items = dtos.domainModelObject
      
      let hasNext = !(dtos.shows.count < 250)
      
      return Page(items: items.shows,
                  pageIndex: page,
                  hasNextPage: hasNext)
   }
}
