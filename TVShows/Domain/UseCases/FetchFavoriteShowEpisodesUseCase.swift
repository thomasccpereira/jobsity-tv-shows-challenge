import Foundation

@MainActor
protocol FetchFavoriteShowEpisodesUseCase {
   func execute(showID: Int) async throws -> [SingleEpisodeModel]
}

@MainActor
struct FetchFavoriteShowEpisodesUseCaseImpl: FetchFavoriteShowEpisodesUseCase {
   private let repository: FavoritesRepository
   
   init(repository: FavoritesRepository) {
      self.repository = repository
   }
   
   func execute(showID: Int) async throws -> [SingleEpisodeModel] {
      try await repository.fetchFavoritesEpisodes(showID: showID)
   }
}
