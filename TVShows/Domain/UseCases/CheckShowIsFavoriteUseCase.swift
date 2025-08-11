import Foundation

@MainActor
protocol CheckShowIsFavoriteUseCase {
   func execute(showID: Int) async throws -> Bool
}

@MainActor
struct CheckShowIsFavoriteUseCaseImpl: CheckShowIsFavoriteUseCase {
   private let repository: FavoritesRepository
   
   init(repository: FavoritesRepository) {
      self.repository = repository
   }
   
   func execute(showID: Int) async throws -> Bool {
      try await repository.checkIfShowIsFavorite(showID)
   }
}
