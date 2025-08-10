import Foundation

final class ShowsRepositoryImpl: ShowsRepository {
   private let remote: ShowsRemoteDataSource
   
   init(remote: ShowsRemoteDataSource = ShowsRemoteDataSourceImpl()) {
      self.remote = remote
   }
   
   func fetchShows(page: Int) async throws -> Envelope<Page<SingleShowModel>> {
      let dto = try await remote.shows(page: page)
      let items = dto.domainModelObject
      let hasNextPage = !items.shows.isEmpty
      
      if let errorMessage = dto.error?.previous?.message ?? dto.error?.message {
         return .init(errorMessage: errorMessage)
      }
      
      let model = Page(items: items.shows,
                      pageIndex: page,
                      hasNextPage: hasNextPage)
      return .init(model: model)
   }
   func fetchEpisodes(showID: Int) async throws -> Envelope<EpisodesListModel> {
      let dto = try await remote.episodes(showID: showID)
      let model = dto.domainModelObject
      
      if let errorMessage = dto.error?.previous?.message ?? dto.error?.message {
         return .init(errorMessage: errorMessage)
      }
      
      return .init(model: model)
   }
   }
}
