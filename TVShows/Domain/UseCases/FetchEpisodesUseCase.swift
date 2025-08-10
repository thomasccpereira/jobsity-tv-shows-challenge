import Foundation

protocol FetchEpisodesUseCase: Sendable {
   func callAsFunction(showID: Int) async throws -> Envelope<EpisodesListModel>
}

struct FetchEpisodesUseCaseImpl: FetchEpisodesUseCase {
   private let repository: ShowsRepository
   
   init(repository: ShowsRepository) {
      self.repository = repository
   }
   
   func callAsFunction(showID: Int) async throws -> Envelope<EpisodesListModel> {
      try await repository.fetchEpisodes(showID: showID)
   }
}
