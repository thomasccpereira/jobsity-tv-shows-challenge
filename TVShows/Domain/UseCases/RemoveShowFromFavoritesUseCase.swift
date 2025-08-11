import Foundation

@MainActor
protocol RemoveShowFromFavoritesUseCase {
   func execute(showID: Int) async throws
}

@MainActor
struct RemoveShowFromFavoritesUseCaseImpl: RemoveShowFromFavoritesUseCase {
   private let repository: FavoritesRepository
   
   init(repository: FavoritesRepository) {
      self.repository = repository
   }
   
   func execute(showID: Int) async throws {
      try await repository.removeShowFromFavorites(showID: showID)
   }
}
