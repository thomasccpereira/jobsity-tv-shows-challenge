import Foundation

@MainActor
protocol RemoveShowEpisodesFromFavoritesUseCase {
   func execute(showID: Int) async throws
}

@MainActor
struct RemoveShowEpisodesFromFavoritesUseCaseImpl: RemoveShowEpisodesFromFavoritesUseCase {
   private let repository: FavoritesRepository
   
   init(repository: FavoritesRepository) {
      self.repository = repository
   }
   
   func execute(showID: Int) async throws {
      try await repository.removeShowEpisodesFromFavorites(showID: showID)
   }
}
